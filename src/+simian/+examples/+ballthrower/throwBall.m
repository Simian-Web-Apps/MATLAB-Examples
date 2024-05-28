function payload = throwBall(~, payload)
    % guiEvent Simulate throwing a ball.
    %
    % Inputs:
    % - metaData    Form meta data.
    % - payload     Current data of the Form's contents.
    %
    % Returns:
    % - payload     Updated Form contents.

    % Copyright 2021-2024 MonkeyProof Solutions BV.

    import simian.gui.*;

    % Get the settings from the payload and multiply with the enabled states to switch off parts of the
    % simulation.
    enableDrag  = utils.getSubmissionData(payload, "enableDrag", "Parent", "options");
    enableWind  = utils.getSubmissionData(payload, "enableWind", "Parent", "options");
    horSpeed    = utils.getSubmissionData(payload, "speedHorizontal");
    verSpeed    = utils.getSubmissionData(payload, "speedVertical");
    dragCoeff   = utils.getSubmissionData(payload, "dragCoefficient") * enableDrag;
    radiusBall  = utils.getSubmissionData(payload, "ballRadius") * enableDrag;
    rhoAir      = utils.getSubmissionData(payload, "airDensity") * enableDrag;
    gravity     = utils.getSubmissionData(payload, "gravity") * -1;
    massBall    = utils.getSubmissionData(payload, "ballMass"); % May not be zero.
    windSpeed   = utils.getSubmissionData(payload, "windSpeed") * enableDrag * enableWind;

    % Simulate a ball throw with the settings in the form.
    [~, x, y] = simian.examples.BallThrower.throwBall(...
        "u0", horSpeed, ...
        "v0", verSpeed, ...
        "Cd", dragCoeff, ...
        "r", radiusBall, ...
        "rho", rhoAir, ...
        "g", gravity, ...
        "m", massBall, ...
        "w", windSpeed);

    % Create a plotly object from the data in the form, put the current data in the plotly object and get the
    % legends.
    plotly          = utils.getSubmissionData(payload, "plot");
    dataSpec        = plotly.data;
    existingNames   = cellfun(@(x) x.name, plotly.data, "UniformOutput", false);

    % Plot the new newly calculated x and y values, append the legend and put the plotly object in the
    % submission data.
    nr = numel(dataSpec) + 1;
    plotly.plot(x, y)
    plotly.legend(existingNames{:}, sprintf("Attempt %d", nr));
    payload = utils.setSubmissionData(payload, "plot", plotly);

    % Update the table with the settings used for the throws.
    newRow = {nr, nr, horSpeed, verSpeed, windSpeed, massBall, radiusBall, dragCoeff, gravity, rhoAir};

    if nr == 1
        % First throw. Only put the new row in the table.
        newTableValues  = newRow;
    else
        tableValues     = table2cell(utils.getSubmissionData(payload, "summary"));
        newTableValues  = [tableValues; newRow];
    end

    payload = utils.setSubmissionData(payload, "summary", newTableValues);

    % Accept all changes to settings and lower the changes flag.
    payload.pristine = true;
end
