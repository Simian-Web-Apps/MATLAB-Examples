function [t, x, y, u, v] = throwBall(inputs)
    %% throwBall
    % Simulates the trajectory of a ball with the given settings.
    %
    % Optional inputs:
    % * x0      Initial horizontal location [m].
    % * y0      Initial vertical location [m].
    % * u0      Initial horizontal velocity [m/s].
    % * v0      Initial vertical velocity [m/s].
    % * Cd      Drag coefficient [-].
    % * r       Radius of the ball [m].
    % * rho     Density of the air [kg/m3].
    % * g       Gravitional acceleration [m/s2].
    % * m       Mass of the ball [kg].
    % * w       Horizontal wind speed in the x-direction [m].
    %
    % Outputs
    % * t       Time stamps for which the location of the ball is known.
    % * x       Horizontal location over time.
    % * y       Vertical location over time.
    % * u       Horizontal velocity over time.
    % * v       Vertical velocity over time.
    
    % Copyright 2021-2022 MonkeyProof Solutions BV.
    
    arguments
        inputs.x0   (1, 1)  double                      = 0 %@ok<*CNVPC-NAMING-18> Consistency over the class.
        inputs.y0   (1, 1)  double  {mustBeNonnegative} = 0
        inputs.u0   (1, 1)  double  {mustBeNonnegative} = 10
        inputs.v0   (1, 1)  double  {mustBeNonnegative} = 10
        inputs.Cd   (1, 1)  double  {mustBeNonnegative} = 0.4
        inputs.r    (1, 1)  double  {mustBeNonnegative} = 0.05
        inputs.rho  (1, 1)  double  {mustBeNonnegative} = 1.239
        inputs.g    (1, 1)  double  {mustBeNegative}    = -9.81
        inputs.m    (1, 1)  double  {mustBePositive}    = 0.1
        inputs.w    (1, 1)  double                      = 0
    end
    
    
    % Prepare the ODE options.
    odeOptions = odeset( ...
        'AbsTol', 1e-8, ...
        'RelTol', 1e-8, ...
        'Events', @simian.examples.BallThrower.zeroCrossing);
    
    %% Call ode
    [t, trajectory] = ode45( ...
        @simian.examples.BallThrower.dragBall, ...
        [0, Inf], ...
        [inputs.x0; inputs.u0; inputs.y0; inputs.v0], ...
        odeOptions, ...
        inputs);
    
    %% Return results
    x   = trajectory(:, 1);
    u   = trajectory(:, 2);
    y   = trajectory(:, 3);
    v   = trajectory(:, 4);
    
end
