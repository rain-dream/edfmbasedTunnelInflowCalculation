GEDFMSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixGrid1.mat';
mfGSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixFractureGrid1.mat';
solutionEDFMSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\solutionEDFM1.mat';
fracLinesSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\processedFracPlanes1.mat';

load(GEDFMSaveMatPath);
load(mfGSaveMatPath);
load(solutionEDFMSaveMatPath);
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

format long;

tunnelFracInterFaceCentroids = [97.4 98.475;
                                102.6 101.525;
                                101.525 97.4;
                                98.475 102.6];

q = calculateTunnelInflowStructuredGrid3DWithCrossingFracture(G, matrixFractureG, states, fracIds, fracTunnelIntersectX, ones(1,length(fracIds))*1e-4, tunnelFracInterFaceCentroids);
disp(q);

[uq, bq, lq, rq, fq, baq] = calculateOuterBCFlux3D(matrixFractureG, states);
disp(uq);
disp(bq);
disp(lq);
disp(rq);
disp(fq);
disp(baq);