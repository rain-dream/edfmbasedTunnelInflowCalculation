function [truncatedFracLines] = truncateFracIntoRectDomain(fracLines, rectDomain)
    %% Truncate fractures into the rectangular domain

    %% Input
    % fracLines: Struct array of fracture endpoint coordinates
    % rectDomain: the rectangular domain

    %% Output
    % truncatedFracLines: truncated fracture lines

    for i = 1:length(fracLines)
        isInRectDomain = isFracInRectDomain(fracLines(i).points(1:2, 1:2), rectDomain);
        if isInRectDomain(1) == 1
            continue;
        else
            truncatedFracEndpoint = truncateFracIntoRectDomainHelper(fracLines(i).points(1:2, 1:2), rectDomain, isInRectDomain);
            fracLines(i).points(1:2, 1:2) = truncatedFracEndpoint(1:2, :);
            fracLines(i).points(3, 1:2) = truncatedFracEndpoint(2, :);
            fracLines(i).points(4, 1:2) = truncatedFracEndpoint(1, :);
        end
    end
    truncatedFracLines = fracLines;
end


function [truncatedFracEndpoint] = truncateFracIntoRectDomainHelper(fracEndpoint, rectDomain, isInRectDomain)
    %% A helper function to truncate fractures into the rectangular domain

    %% Input
    % fracEndpoint: coordinates of fracture endpoints 
    % eg. [p_1x p_1y; p_2x p_2y]
    % rectDomain: the rectangular domain 
    % eg. [x_min y_min; x_max y_max]
    % isInRectDomain: a boolean value to indicate whether the fracture is in the rectangular domain

    %% Output
    % truncatedFracEndpoint: truncated fracture endpoints

    if isInRectDomain(1) == -1 || isInRectDomain(1) == -2
        truncatedFracEndpoint = truncateX(fracEndpoint, rectDomain, isInRectDomain);
    else
        truncatedFracEndpoint = truncateY(fracEndpoint, rectDomain, isInRectDomain);
    end

    isInRectDomain = isFracInRectDomain(truncatedFracEndpoint, rectDomain);
    if isInRectDomain(1) == 1
        return;
    else
        truncatedFracEndpoint = truncateFracIntoRectDomainHelper(truncatedFracEndpoint, rectDomain, isInRectDomain);
    end
end


function [truncatedFracEndpoint] = truncateX(fracEndpoint, rectDomain, isInRectDomain)
    %% Truncate fractures into the rectangular domain along x-axis

    %% Input
    % fracEndpoint: coordinates of fracture endpoints 
    % rectDomain: the rectangular domain 
    % isInRectDomain: a boolean value to indicate whether the fracture is in the rectangular domain

    %% Output
    % truncatedFracEndpoint: truncated fracture endpoints

    if isInRectDomain(1) == -1
        xLim = rectDomain(1, 1);
    else
        xLim = rectDomain(2, 1);
    end

    if isInRectDomain(2) == 1
        alteredPoint = fracEndpoint(1, :);
        fixedPoint = fracEndpoint(2, :);
    else
        alteredPoint = fracEndpoint(2, :);
        fixedPoint = fracEndpoint(1, :);
    end

    deltaX1X2 = alteredPoint(1) - fixedPoint(1);
    deltaX1XLlim = alteredPoint(1) - xLim;
    deltaXRatio = deltaX1XLlim / deltaX1X2;
    deltaY1Y2 = alteredPoint(2) - fixedPoint(2);

    alteredPoint(2) = alteredPoint(2) - deltaY1Y2 * deltaXRatio;
    alteredPoint(1) = xLim;

    if isInRectDomain(2) == 1
        truncatedFracEndpoint = [alteredPoint;
                                 fixedPoint];
    else
        truncatedFracEndpoint = [fixedPoint;
                                 alteredPoint];
    end
end


function [truncatedFracEndpoint] = truncateY(fracEndpoint, rectDomain, isInRectDomain)
    %% Truncate fractures into the rectangular domain along y-axis

    %% Input
    % fracEndpoint: coordinates of fracture endpoints 
    % rectDomain: the rectangular domain 
    % isInRectDomain: a boolean value to indicate whether the fracture is in the rectangular domain

    %% Output
    % truncatedFracEndpoint: truncated fracture endpoints

    if isInRectDomain(1) == -3
        yLim = rectDomain(1, 2);
    else
        yLim = rectDomain(2, 2);
    end

    if isInRectDomain(2) == 1
        alteredPoint = fracEndpoint(1, :);
        fixedPoint = fracEndpoint(2, :);
    else
        alteredPoint = fracEndpoint(2, :);
        fixedPoint = fracEndpoint(1, :);
    end

    deltaY1Y2 = alteredPoint(2) - fixedPoint(2);
    deltaY1YLlim = alteredPoint(2) - yLim;
    deltaYRatio = deltaY1YLlim / deltaY1Y2;
    deltaX1X2 = alteredPoint(1) - fixedPoint(1);

    alteredPoint(1) = alteredPoint(1) - deltaX1X2 * deltaYRatio;
    alteredPoint(2) = yLim;

    if isInRectDomain(2) == 1
        truncatedFracEndpoint = [alteredPoint;
                                 fixedPoint];
    else
        truncatedFracEndpoint = [fixedPoint;
                                 alteredPoint];
    end
end