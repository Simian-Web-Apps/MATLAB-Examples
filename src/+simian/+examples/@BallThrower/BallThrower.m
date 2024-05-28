classdef BallThrower < handle
    %% BallThrower class
    % Model for simulating the trajectories of thrown balls.
    % Initital location and speed can be set.
    % Properties of the ball that affect the trajectory like mass, radius, and drag coefficient can be set.
    % The effects of drag and wind can be simulated or ignored.
    
    % Copyright 2021-2022 MonkeyProof Solutions BV.
    
    methods (Static)
        [t, x, y, u, v]                 = throwBall(inputs);
    end
    
    methods (Static, Access = protected)
        dzdt                            = dragBall(t, z, inputs);
        [value, isterminal, direction]  = zeroCrossing(t, z, varargin);
    end
end
