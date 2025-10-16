function [truncatedFracLines] = truncateFracCrossingTunnel(fracLines, tunnelCenter, tunnelRadius)
    %% Truncate fractures crossing the tunnel

    %% Input
    % fracLines: Struct array of fracture endpoint coordinates
    % tunnelCenter: coordinates of the tunnel center
    % tunnelRadius: tunnel radius

    %% Output
    % truncatedFracLines: truncated fracture lines

    truncatedFracLines = struct('points', []);

    i = 1;
    j = 1;

    while i <= length(fracLines)
        isCrossingTunnel = isFracCrossingTunnel(tunnelCenter, tunnelRadius, fracLines(i).points(1:2, 1:2));
        if ~isCrossingTunnel
            truncatedFracLines(j).points = fracLines(i).points;
            j = j + 1;
        else
            % Calculate the line equation
            [A, B, C] = calculateLineEquation(fracLines(i).points(1:2, 1:2));  

            % Calculate the intersection points of this line and this circle
            [p1, p2] = calculateIntersectionPointOfLineAndCircle(A, B, C, tunnelCenter, tunnelRadius); 
            
            %% Split the fracline into two parts
            [fracLine1, fracLine2] = splitOneFracLineIntoTwoParts(fracLines(i).points(1:2, 1:2), p1, p2);
            truncatedFracLines(j).points = fracLine1;
            truncatedFracLines(j+1).points = fracLine2;

            j= j + 2;
        end
        i = i + 1;
    end
end


function [isCrossingTunnel] = isFracCrossingTunnel(tunnelCenter, tunnelRadius, fracEndpoint)
    %% Check whether the fracture is crossing the tunnel

    %% Input
    % tunnelCenter: coordinates of the tunnel center
    % tunnelRadius: tunnel radius
    % fracEndpoint: coordinates of fracture endpoints 
    % eg. [p_1x p_1y; p_2x p_2y]

    %% Output
    % isCrossingTunnel: a boolean value to indicate whether the fracture is crossing the tunnel

    %% Calculate the distance between the tunnel center and the fracline
    distance = calculatePointToLineDistance(tunnelCenter, fracEndpoint);

    if distance >= tunnelRadius
        isCrossingTunnel = false;
    else
        isCrossingTunnel = true;
    end
end


function [fracLine1, fracLine2] = splitOneFracLineIntoTwoParts(fracLine, splitPoint1, splitPoint2)
    %% Split one fracline into two parts

    %% Input
    % fracLine: coordinates of the fracline endpoints
    % splitPoint1: coordinates of the first split point
    % splitPoint2: coordinates of the second split point

    %% Output
    % fracLine1: coordinates of the first fracline endpoints
    % fracLine2: coordinates of the second fracline endpoints

    %% Determine the split point paring with the first endpoint of the line 
    d1 = sqrt((splitPoint1(1)-fracLine(1, 1))^2 + (splitPoint1(2)-fracLine(1, 2))^2);  % distance between the split point 1 and the first endpoint of the line
    d2 = sqrt((splitPoint2(1)-fracLine(1, 1))^2 + (splitPoint2(2)-fracLine(1, 2))^2);  % distance between the split point 2 and the first endpoint of the line

    if d1 < d2
        p1 = splitPoint1;
        p2 = splitPoint2;
    else
        p1 = splitPoint2;
        p2 = splitPoint1;
    end

    fracLine1 = [fracLine(1, 1) fracLine(1, 2); p1(1) p1(2)];
    fracLine2 = [p2(1) p2(2); fracLine(2, 1) fracLine(2, 2)];
end