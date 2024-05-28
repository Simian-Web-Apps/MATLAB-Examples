function payload = clearHistory(~, payload)
    % guiEvent Handle the form's events.
    %     payload = guiEvent(metaData, payload) Handles the event in the payload data and updates the payload with
    %     results.
    %
    % Inputs:
    % - metaData    Form meta data.
    % - payload     Current data of the Form's contents.
    %
    % Returns:
    % - payload     Updated Form contents.

    % Copyright 2021-2024 MonkeyProof Solutions BV.

    import simian.gui.*;

    % Clears the data from the plot.
    plotly      = utils.getSubmissionData(payload, "plot");
    plotly.data = [];
    payload     = utils.setSubmissionData(payload, "plot", plotly);

    % Only leave one empty row.
    payload = utils.setSubmissionData(payload, "summary", repmat({""}, 1, 10)); %#ok<STRSCALR> cellstr needed.
    payload = utils.addAlert(payload, "History of throws cleared.", "info");
end
