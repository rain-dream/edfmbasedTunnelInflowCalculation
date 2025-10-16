function [fracLines] = generateEqualSpacedFracsInRectDomainWithTunnel(rectDomain, tunnelCenter, tunnelRadius, fracSpacing, fracAngleX, firstFracLine, fracLinesSaveMatPath)
    %% Generate equal spaced fractures in a rectangular domain with tunnel

    %% Input
    % rectDomain: the rectangular domain 
    % eg. [x_min y_min; x_max y_max] 
    % tunnelCenter: coordinates of the tunnel center
    % tunnelRadius: tunnel radius
    % fracSpacing: spacing between fractures
    % fracAngleX: angle of the fractures in x direction
    % firstFracLine: endpoint coordinates of the first fracline
    % fracLinesSaveMatPath: path of the mat file to save fraclines

    %% Output
    % fracLines: fracture endpoint coordinates

    fracLines = struct('points', []);
    
    fracLines(1).points = firstFracLine;

    %% Generating equal spaced fractures without considering the tunnel
    i = 2;                           % index of the next fracline
    isEnding = false;                % flag to indicate whether the generation is ending
    lastFracLine = firstFracLine;    % coordinates of the last fracline endpoints
    while ~isEnding
        if fracAngleX <= 90
            nextFracLine = generateNextFracLine1(lastFracLine, rectDomain, fracSpacing, fracAngleX);
        else
            nextFracLine = generateNextFracLine2(lastFracLine, rectDomain, fracSpacing, fracAngleX);
        end

        if isempty(nextFracLine)
            isEnding = true;
        else
            fracLines(i).points = nextFracLine;
            truncatedFracLines = truncateFracIntoRectDomain(fracLines(i), rectDomain);  % truncate the fracline into the rectangular domain
            fracLines(i).points = truncatedFracLines(1).points;
            lastFracLine = fracLines(i).points;
            i = i + 1;
        end
    end

    %% Truncate fractures crossing the tunnel
    fracLines = truncateFracCrossingTunnel(fracLines, tunnelCenter, tunnelRadius);

    if ~isempty(fracLinesSaveMatPath)
        save(fracLinesSaveMatPath, 'fracLines');
    end
end


function [nextFracLine] = generateNextFracLine1(lastFracLine, rectDomain, fracSpacing, fracAngleX)
    %% Generate next fracline according to last fracline (for fracAngleX between 0~pi/2)

    %% Input
    % lastFracLine: coordinates of last fracline endpoints
    % rectDomain: the rectangular domain 
    % fracSpacing: spacing between fractures
    % fracAngleX: angle of the fractures in x direction

    %% Output
    % nextFracLine: coordinates of the next fracline endpoints

    p1X = lastFracLine(1, 1);
    p1Y = lastFracLine(1, 2);
    p2X = lastFracLine(2, 1);
    p2Y = lastFracLine(2, 2);

    if p1Y ~= rectDomain(1, 2)
        n1X = rectDomain(1, 1);
        n1Y = p1Y - fracSpacing/cos(deg2rad(fracAngleX));
    else
        n1X = p1X + fracSpacing/sin(deg2rad(fracAngleX));
        n1Y = rectDomain(1, 2);
    end

    if p2X ~= rectDomain(2, 1)
        n2X = p2X + fracSpacing/sin(deg2rad(fracAngleX));
        n2Y = rectDomain(2, 2);
    else
        n2X = rectDomain(2, 1);
        n2Y = p2Y - fracSpacing/cos(deg2rad(fracAngleX));
    end

    if n1X >= rectDomain(2, 1)
        nextFracLine = [];
    else
        nextFracLine = [n1X n1Y; n2X n2Y];
    end
end


function [nextFracLine] = generateNextFracLine2(lastFracLine, rectDomain, fracSpacing, fracAngleX)
    %% Generate next fracline according to last fracline (for fracAngleX between pi/2~pi)

    %% Input
    % lastFracLine: coordinates of last fracline endpoints
    % rectDomain: the rectangular domain 
    % fracSpacing: spacing between fractures
    % fracAngleX: angle of the fractures in x direction

    %% Output
    % fracEndpoint: coordinates of the next fracline endpoints

    p1X = lastFracLine(1, 1);
    p1Y = lastFracLine(1, 2);
    p2X = lastFracLine(2, 1);
    p2Y = lastFracLine(2, 2);

    if p1Y ~= rectDomain(1, 2)
        n1X = rectDomain(2, 1);
        n1Y = p1Y + fracSpacing/cos(deg2rad(fracAngleX));
    else
        n1X = p1X - fracSpacing/sin(deg2rad(fracAngleX));
        n1Y = rectDomain(1, 2);
    end

    if p2X ~= rectDomain(1, 1)
        n2X = p2X - fracSpacing/sin(deg2rad(fracAngleX));
        n2Y = rectDomain(2, 2);
    else
        n2X = rectDomain(1, 1);
        n2Y = p2Y + fracSpacing/cos(deg2rad(fracAngleX));
    end

    if n1X <= rectDomain(1, 1)
        nextFracLine = [];
    else
        nextFracLine = [n1X n1Y; n2X n2Y];
    end
end