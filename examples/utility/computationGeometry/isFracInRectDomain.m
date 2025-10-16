function [isInRectDomain] = isFracInRectDomain(fracEndpoint, rectDomain)
    %% Check whether the fracture is in the rectangular domain

    %% Input
    % fracEndpoint: coordinates of fracture endpoints 
    % eg. [p_1x p_1y; p_2x p_2y]
    % rectDomain: the rectangular domain 
    % eg. [x_min y_min; x_max y_max]

    %% Output
    % isInRectDomain: a boolean value to indicate whether the fracture is in the rectangular domain

    cond1 = find(fracEndpoint(:, 1) < rectDomain(1, 1));
    if ~isempty(cond1)
        isInRectDomain = [-1, cond1];
        return;
    end

    cond2 = find(fracEndpoint(:, 1) > rectDomain(2, 1));
    if ~isempty(cond2)
        isInRectDomain = [-2, cond2];
        return;
    end

    cond3 = find(fracEndpoint(:, 2) < rectDomain(1, 2));
    if ~isempty(cond3)
        isInRectDomain = [-3, cond3];
        return;
    end

    cond4 = find(fracEndpoint(:, 2) > rectDomain(2, 2));
    if ~isempty(cond4)
        isInRectDomain = [-4, cond4];
        return;
    end

    isInRectDomain = [1, 1];
end