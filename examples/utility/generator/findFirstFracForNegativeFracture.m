function [firstFracLine] = findFirstFracForNegativeFracture(tunnelIntersectPoint, dipDirection, fracSpacing, height, width, ME)
    % This function finds the first fracture line for a  fracture with dip angle > 90 degrees

    b = tunnelIntersectPoint(2) - tan(deg2rad(180-dipDirection))*(2*ME-tunnelIntersectPoint(1));
    
    if b >= 0
        anotherPoint = [0 b];
    else
        p = [2*ME+b/tan(deg2rad(180-dipDirection)) 0];
        anotherPoint = findFirstFracHelper(p, dipDirection, fracSpacing, ME);
    end

    while anotherPoint(2) < height
        anotherPoint = anotherPoint + [0 fracSpacing/sin(deg2rad(dipDirection-90))];
    end
    anotherPoint = anotherPoint - [0 fracSpacing/sin(deg2rad(dipDirection-90))];

    x0 = (height-anotherPoint(2))*tan(deg2rad(dipDirection-90));
    if x0 < width
        firstFracLine = [2*ME anotherPoint(2); 2*ME-x0 height];
    else
        firstFracLine = [2*ME anotherPoint(2); 0 tan(deg2rad(180-dipDirection))*width + anotherPoint(2)];
    end 
end

function [anotherPoint] = findFirstFracHelper(p, dipDirection, fracSpacing, ME)
    deltaX = fracSpacing/sin(deg2rad(180-dipDirection));
    x = p(1)+deltaX;
    
    if x < 2*ME
        anotherPoint = findFirstFracHelper([x p(2)], dipDirection, fracSpacing, ME);
    else
        b = tan(deg2rad(180-dipDirection))*(x-2*ME);
        anotherPoint = [2*ME b];
    end
end