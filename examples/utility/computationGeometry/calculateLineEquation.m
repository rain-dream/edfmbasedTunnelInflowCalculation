function [A, B, C] = calculateLineEquation(lineEndpoints)
    %% Calculate the line equation in the form of A*x + B*y + C = 0

    %% Input
    % lineEndpoints: coordinates of the line endpoints
    % eg. [p_1x p_1y; p_2x p_2y]

    %% Output
    % A: A
    % B: B
    % C: C

    A = lineEndpoints(2, 2) - lineEndpoints(1, 2);
    B = lineEndpoints(1, 1) - lineEndpoints(2, 1);
    C = (lineEndpoints(2, 1)-lineEndpoints(1, 1))*lineEndpoints(1, 2) - (lineEndpoints(2, 2)-lineEndpoints(1, 2))*lineEndpoints(1, 1);
end