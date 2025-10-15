mrstModule add hfm;

%% Parameter setting
h = 10;                      % groundwater head above the tunnel centerline
z = 10;                      % tunnel depth
ME = 30;                    % model extent
tunnelCenter = [ME ME];
tunnelRadius = 3;

tifFigureResolution = 1000;

%% Relevant file path
rawFracPlanesSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\Fracplanes.mat';
processedFracPlanesSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\processedFracPlanes1.mat';
matrixGridSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixGrid1.mat';
matrixFractureGridSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixFractureGrid1.mat';
solutionSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\solutionEDFM1.mat';

geometryMatLabFigureSavePath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\fig\matlabFigure\geometry.fig';
geometryTifFigureSavePath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\fig\tif\geometry.tif';

matrixFractureGridMatLabFigureSavePath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\fig\matlabFigure\matrixFractureGrid.fig';
matrixFractureGridTifFigureSavePath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\fig\tif\matrixFractureGrid.tif';

pressureDistributionMatLabFigureSavePath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\fig\matlabFigure\pressure1.fig';
pressureDistributionTifFigureSavePath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\fig\tif\pressure1.tif';

matrixPressureRelativeErrorSaveMatPath = '';
matrixPressureRelativeErrorDistributionMatlabFigureSavePath = '';
matrixPressureRelativeErrorDistributionTifFigureSavePath = '';

%% Load relevant data
load(rawFracPlanesSaveMatPath, "fracPlanes");
load(processedFracPlanesSaveMatPath, "fracLines");
load(matrixGridSaveMatPath, "G");
load(matrixFractureGridSaveMatPath, "matrixFractureG");
load(solutionSaveMatPath, "states");
% load(matrixPressureRelativeErrorSaveMatPath, "matrixPressureRelativeError");

%% Plot the geometry
% plotGeometry(2*ME, ME+z, tunnelCenter, tunnelRadius, fracPlanes, tifFigureResolution, geometryMatLabFigureSavePath, geometryTifFigureSavePath);

%% Plot the grid
plotfracongrid(G, fracLines, 'label', false, 'facefacealpha', 1, 'facefacecolor', 'black');
if ~isempty(matrixFractureGridMatLabFigureSavePath)
    savefig(matrixFractureGridMatLabFigureSavePath);
end
view(2);
axis on;

%% plot the pressure distribution
% colorBarLim = [0 12e5];
% xTicks = 0:20:200;
% yTicks = 0:20:120;
% isWithFractures = true;
% plotPressureDistributionEDFM(matrixFractureG, states, colorBarLim, xTicks, yTicks, isWithFractures, ...
% tifFigureResolution, pressureDistributionMatLabFigureSavePath, pressureDistributionTifFigureSavePath);

%% Plot the distribution of matrix pressure relative error
% isWithFractures = true;
% colorBarLim = [];
% xTicks = 0:30:240;
% yTicks = 0:30:150;

% plotMatrixPressureRelativeErrorDistribution(matrixFractureG, matrixPressureRelativeError, isWithFractures, ...
% colorBarLim, xTicks, yTicks, ...
% tifFigureResolution, matrixPressureRelativeErrorDistributionMatlabFigureSavePath, matrixPressureRelativeErrorDistributionTifFigureSavePath);