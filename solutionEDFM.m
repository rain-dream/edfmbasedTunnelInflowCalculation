mrstModule add hfm;

%% Relevant file path
for k = [1]
    for j = [1]
        matrixGridSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixGrid', num2str((k-1)*4+j), '.mat');
        matrixFractureGridSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixFractureGrid', num2str((k-1)*4+j), '.mat');
        solutionSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\solutionEDFM', num2str((k-1)*4+j), '.mat');

        %% Load relevant data
        load(matrixGridSaveMatPath, "G");
        load(matrixFractureGridSaveMatPath, "matrixFractureG");

        %% Generate water model
        waterModel = generateWaterModel(matrixFractureG);

        fracLinesSaveMatPath = strcat('D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\processedFracPlanes', num2str((k-1)*4+j), '.mat');
        load(fracLinesSaveMatPath, "fracLines");
        h = 20;
        ME = 100;
        [fracIds] = findIntersectTunnelFracId(fracLines, h, ME);
        fracTunnelIntersectX = zeros(1, length(fracIds));
        for i = 1:length(fracIds)
            fracId = fracIds(i);
            fracFirstPoint = fracLines(fracId).points(1, 1:2);
            fracSecondPoint = fracLines(fracId).points(2, 1:2);

            distOfFirstFracPointToTunnelCenter = sqrt((fracFirstPoint(1)-ME)^2+(fracFirstPoint(2)-ME)^2);
            distOfSecondFracPointToTunnelCenter = sqrt((fracSecondPoint(1)-ME)^2+(fracSecondPoint(2)-ME)^2);
            if distOfFirstFracPointToTunnelCenter < distOfSecondFracPointToTunnelCenter
                nearPoint = fracFirstPoint;
            else
                nearPoint = fracSecondPoint;
            end

            fracTunnelIntersectX(i) = nearPoint(1);
        end

        states = cubicDomainWithTunnelWithCrossingFracturesBC1(G, matrixFractureG, waterModel, fracIds, fracTunnelIntersectX, solutionSaveMatPath);
    end
end