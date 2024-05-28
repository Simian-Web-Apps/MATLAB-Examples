function payload = causeError(~, payload) %#ok<INUSD> 
    % guiEvent Throws an error.
    %
    % Inputs:
    % - metaData    Form meta data.
    % - payload     Current data of the Form's contents.
    %
    % Returns:
    % - payload     Updated Form contents.

    % Copyright 2021-2024 MonkeyProof Solutions BV.

    % Throws an error so that the user can see the error handling in action.
    error("Ballthrower:throwError:event", "Error thrown for testing the error handling mechanism.");
end
