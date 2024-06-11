function payload = guiEvent(metaData, payload)
    import simian.gui.*;

    % Register event handlers.
    Form.eventHandler(YearSelected=@updateYear);

    % Handle the event using the event data in the payload.
    payload = utils.dispatchEvent(metaData, payload);
end

%% updateYear
function payload = updateYear(~, payload)
    import simian.gui.*

    % Get the year and treemap.
    year    = utils.getSubmissionData(payload, "year");
    treemap = utils.getSubmissionData(payload, "treemap");

    % Update the layout and plot data with the data of the selected year.
    [treemap.layout, treemap.data] = simian.examples.treemap.selectYear(year);

    % Set the treemap value.
    payload = utils.setSubmissionData(payload, "treemap", treemap);
end
