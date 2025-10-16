%% Relevant file path
mphFilePath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\DFM\SCI\11\mphFile\solutionDFM1.mph';
matrixFractureGSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixFractureGrid1.mat';
matrixPressureDFMSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\matrixPressureDFM1.mat';
fracPressureDFMSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\FracPressureDFM1.mat';

%% Extract matrix cell pressure data from COMSOL solution
gridName = 'matrixFractureG';
isWithFractures = true;
matrixPressureDFM = extractMatrixPressureDataFromCOMSOL(mphFilePath, matrixFractureGSaveMatPath, gridName, ...
isWithFractures, matrixPressureDFMSaveMatPath);

%% Extract fracture cell pressure data from COMSOL solution
fracPressureDFM = extractFracPressureDataFromCOMSOL(mphFilePath, matrixFractureGSaveMatPath, gridName, fracPressureDFMSaveMatPath);