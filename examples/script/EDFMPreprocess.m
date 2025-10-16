mrstModule add hfm;

%% Relevant file path
apertures = [1e-4, 1.75e-4, 3.75e-4, 1.5e-3];

for j = [1]
    fracPlanesSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\Fracplanes.mat';
    matrixGridSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixGrid', num2str(j), '.mat');
    matrixFractureGridSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixFractureGrid', num2str(j), '.mat');

    %% Load relevant data
    load(fracPlanesSaveMatPath, "fracPlanes");
    load(matrixGridSaveMatPath, "G");

    fracLines = struct('points', {});

    for i = 1:length(fracPlanes)
        fracLines(i).points = fracPlanes(i).points;
        fracLines(i).aperture = apertures(ceil(j/4));
        fracLines(i).poro = 1.0;
        fracLines(i).perm = fracLines(i).aperture^2/12;
    end

    h = 20;
    ME = 100;
    [fracIds] = findIntersectTunnelFracId(fracPlanes, h, ME);
    nps = [97.4, 102.6, 97.4, 102.6];
    interCases = [1, 1, 2, 2];
    for i = 1:length(fracIds)
        fracId = fracIds(i);
        fracFirstPoint = fracPlanes(fracId).points(1, 1:2);
        fracSecondPoint = fracPlanes(fracId).points(2, 1:2);

        distOfFirstFracPointToTunnelCenter = sqrt((fracFirstPoint(1)-ME)^2+(fracFirstPoint(2)-ME)^2);
        distOfSecondFracPointToTunnelCenter = sqrt((fracSecondPoint(1)-ME)^2+(fracSecondPoint(2)-ME)^2);
        if distOfFirstFracPointToTunnelCenter < distOfSecondFracPointToTunnelCenter
            farPoint = fracSecondPoint;
        else
            farPoint = fracFirstPoint;
        end

        [A, B, C] = calculateLineEquation([fracFirstPoint; fracSecondPoint]);
        [p] = calculateIntersectionPointOfTwoLine(A, B, C, nps(i), interCases(i));
        fracLines(fracId).points = [p 0;
                                    farPoint 0;
                                    farPoint 1;
                                    p 1];
    end
                            
    processedFracplanesSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\processedFracPlanes', num2str(j), '.mat');
    save(processedFracplanesSaveMatPath, "fracLines");

    %% EDFM pre-processing
    tol = 1e-6;
    [matrixFractureG, ~] = EDFMPreProcess(G, fracLines, tol);
    save(matrixFractureGridSaveMatPath, "matrixFractureG");
end