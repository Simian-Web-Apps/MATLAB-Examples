function [value, isterminal, direction] = zeroCrossing(t, z, varargin)
    %% zeroCrossing
    % Detect when the y value of the arc (in z(3)) passes zero in a downward manner
    %
    % Inputs
    % * t           Timestamp
    % * z           Ball location and speed information.
    %
    % Outputs:
    % * value       Vertical position of the ball.
    % * isterminal  If the integration is to terminate on this event.
    % * direction   When to locate zeros.
    
    % Copyright 2021-2022 MonkeyProof Solutions BV.
    
    arguments
        t           (1, 1) double %#ok<INUSA> Mandatory ODE input.
        z           (4, 1) double
    end
    
    arguments (Repeating)
        varargin        % Called by odeevents which passes unknown eventArgs into this function.
    end
    
    value       = z(3);
    isterminal  = true;
    direction   = -1;
end
