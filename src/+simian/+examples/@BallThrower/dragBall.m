function dzdt = dragBall(t, z, inputs)
    %% dragBall
    % |dzdt = dragBall(t, z, pars)| ODE function to be resolved for the input parameters.
    %
    % Inputs:
    % * t               The current time step.
    % * z               The current position and velocity of the ball: [x, u, y, v].
    % * inputs          Struct with the settings for the throw. Required fields: ["Cd", "r", "rho", "g", "m", "w"]
    %
    % Outputs:
    % * dzdt            The change in position and velocity for the current time step.
    %
    
    % Copyright 2021-2022 MonkeyProof Solutions BV.
    
    arguments
        t           (1, 1) double                       %#ok<INUSA> Mandatory ODE input.
        z           (4, 1) double
        inputs      (1, 1) struct {mustBeBallInputs}
    end
    
    % Create easier to read variables from the inputs.
    drag    = inputs.Cd;      % Drag coefficient [-].
    r       = inputs.r;       % Radius of the ball [m].
    rho     = inputs.rho;     % Density of the air [kg/m3].
    g       = inputs.g;       % Gravitional acceleration [m/s2].
    m       = inputs.m;       % Mass of the ball [kg].
    w       = inputs.w;       % Horizontal wind speed in the x-direction [m].
    area    = pi * r ^ 2;     % Area [m2].
    
    % Setup the ODE equations for the trajectory of the thrown ball.
    dzdt = [
        z(2);
        -0.5 * rho / m * (z(2) - w) ^ 2 * drag * area * sign(z(2) - w);
        z(4);
        -0.5 * rho / m * z(4) ^ 2 * drag * area * sign(z(4)) + g;
        ];
    
end


function valid = mustBeBallInputs(inputs)
    %% mustBeBallInputs
    % Check whether the inputs struct contains the necessary fields.
    valid = all(ismember(["Cd", "r", "rho", "g", "m", "w"], fieldnames(inputs)));
end
