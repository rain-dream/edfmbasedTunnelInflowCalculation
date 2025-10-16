%% Relevant file path
matrixPressureDFMSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixPressureDFM1.mat';
matrixPressureRelativeErrorSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixPressureRelativeError1.mat';

fracPressureDFMSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\FracPressureDFM1.mat';
fracPressureRelativeErrorSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\FracPressureRelativeError1.mat';

solutionEDFMSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\solutionEDFM1.mat';
matrixFractureGSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixFractureGrid1.mat';

%% Calculate relative error of matrix pressure
gridName = 'matrixFractureG';
isWithFractures = true;
[matrixPressureRelativeError, meanMatrixPressureRelativeError] = calculateMatrixPressureRelativeError(matrixPressureDFMSaveMatPath, solutionEDFMSaveMatPath, ...
matrixFractureGSaveMatPath, gridName, isWithFractures, matrixPressureRelativeErrorSaveMatPath);
disp(max(matrixPressureRelativeError));
disp(length(matrixPressureRelativeError));
disp(meanMatrixPressureRelativeError);

%% Calculate relative error of fracture pressure
[fracPressureRelativeError, meanFracPressureRelativeError] = calculateFracPressureRelativeError(fracPressureDFMSaveMatPath, solutionEDFMSaveMatPath, ...
matrixFractureGSaveMatPath, gridName, fracPressureRelativeErrorSaveMatPath);
disp(max(fracPressureRelativeError));
disp(length(fracPressureRelativeError));
disp(meanFracPressureRelativeError);