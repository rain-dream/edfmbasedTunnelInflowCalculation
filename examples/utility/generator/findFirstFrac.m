function [firstFracLine] = findFirstFrac(tunnelIntersectPoint, dipDirection, fracSpacing, height, width)
    % This function finds the first fracture line for a  fracture with dip angle < 90 degrees

    b = tunnelIntersectPoint(2) - tan(deg2rad(dipDirection))*tunnelIntersectPoint(1);
    
    if b >= 0
        anotherPoint = [0 b];
    else
        p = [-b/tan(deg2rad(dipDirection)) 0];
        anotherPoint = findFirstFracHelper(p, dipDirection, fracSpacing);
    end

    while anotherPoint(2) < height
        anotherPoint = anotherPoint + [0 fracSpacing/cos(deg2rad(dipDirection))];
    end
    anotherPoint = anotherPoint - [0 fracSpacing/cos(deg2rad(dipDirection))];

    x0 = (height-anotherPoint(2))*tan(deg2rad(90-dipDirection));
    if x0 < width
        firstFracLine = [0 anotherPoint(2); x0 height];
    else
        firstFracLine = [0 anotherPoint(2); width tan(deg2rad(dipDirection))*width + anotherPoint(2)];
    end 
end

function [anotherPoint] = findFirstFracHelper(p, dipDirection, fracSpacing)
    deltaX = fracSpacing/sin(deg2rad(dipDirection));
    x = p(1)-deltaX;
    
    if x > 0
        anotherPoint = findFirstFracHelper([x p(2)], dipDirection, fracSpacing);
    else
        b = -tan(deg2rad(dipDirection))*x;
        anotherPoint = [0 b];
    end
end