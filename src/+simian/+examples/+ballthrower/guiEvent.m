function payload = guiEvent(metaData, payload)
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

    Form.eventHandler( ...
        "Throwing",     @simian.examples.ballthrower.throwBall, ...
        "ClearHistory", @simian.examples.ballthrower.clearHistory, ...
        "CauseError",   @simian.examples.ballthrower.causeError ...
        );
    payload = utils.dispatchEvent(metaData, payload);
end
