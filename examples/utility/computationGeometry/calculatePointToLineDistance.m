function [distance] = calculatePointToLineDistance(point, lineEndpoints)
    %% Calculate the distance between a point and a line

    %% Input
    % point: the point
    % lineEndpoints: coordinates of the two line endpoints
    % eg.[p_1x p_1y; p_2x p_2y]

    %% Output
    % distance: distance between the point and the line

    px = point(1);
    py = point(2);
    Ax = lineEndpoints(1, 1);
    Ay = lineEndpoints(1, 2);
    Bx = lineEndpoints(2, 1);
    By = lineEndpoints(2, 2);

    distance = abs((By - Ay) * px - (Bx - Ax) * py + Bx * Ay - By * Ax) / sqrt((By - Ay)^2 + (Bx - Ax)^2);
end