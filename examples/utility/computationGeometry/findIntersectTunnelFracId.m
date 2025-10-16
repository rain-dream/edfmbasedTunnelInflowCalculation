function [fracIds] = findIntersectTunnelFracId(fracPlanes, h, ME)
    fracIds = zeros(1,length(fracPlanes));

    for fracId = 1:length(fracPlanes)
        fracFirstPoint = fracPlanes(fracId).points(1, 1:2);
        fracSecondPoint = fracPlanes(fracId).points(2, 1:2);

        if isPointOnBoundary(fracFirstPoint, h, ME) && isPointOnBoundary(fracSecondPoint, h, ME)
            continue;
        else
            fracIds(fracId) = 1;
        end
    end

    fracIds = find(fracIds==1);
end

function [cond] = isPointOnBoundary(point, h, ME)
    minX = 0;
    maxX = 2*ME;
    minY = 0;
    maxY = ME+h;

    if point(1) == minX || point(1) == maxX || point(2) == minY || point(2) == maxY
        cond = 1;
    else
        cond = 0;
    end
end