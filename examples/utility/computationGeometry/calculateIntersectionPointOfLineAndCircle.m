function [p1, p2] = calculateIntersectionPointOfLineAndCircle(A, B, C, tunnelCenter, tunnelRadius)
    %% Calculate the intersection points of a line and a circle
    % reference: https://www.zhihu.com/question/646718373

    %% Input
    % A: coefficient of x in the line equation
    % B: coefficient of y in the line equation
    % C: constant in the line equation
    % tunnelCenter: coordinates of the tunnel center
    % tunnelRadius: tunnel radius

    %% Output
    % p1: intersection point 1
    % p2: intersection point 2

    en = [A/sqrt(A^2+B^2), B/sqrt(A^2+B^2)];                         % unit normal vector of the line
    a = [B/sqrt(A^2+B^2), -A/sqrt(A^2+B^2)];                         % unit tangent vector of the line
    delta = (A*tunnelCenter(1)+B*tunnelCenter(2)+C)/sqrt(A^2+B^2);   % distance between the tunnel center and the line (with signs)
    
    p1 = tunnelCenter - delta*en - sqrt(tunnelRadius^2-delta^2)*a;
    p2 = tunnelCenter - delta*en + sqrt(tunnelRadius^2-delta^2)*a;
end