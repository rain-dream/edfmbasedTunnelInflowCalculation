function [p] = calculateIntersectionPointOfTwoLine(A, B, C, np, interCase)
    if interCase == 1
        y = (-A*np-C)/B;
        p = [np y];
    else
        x = (-B*np-C)/A;
        p = [x np];
    end
end