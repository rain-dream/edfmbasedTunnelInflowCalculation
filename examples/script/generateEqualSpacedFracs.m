%% Parameter setting
h = 10;                     % groundwater head above the tunnel centerline
z = 10;                     % tunnel depth
ME = 30;                    % model extent 
r = 3;                      % tunnel radius

rectDomain = [0 0; 2*ME z+ME];
tunnelCenter = [ME ME];
fracSpacing = 8;
fracAngleX = 45;
tunnelIntersectPoint = [ME-r*cos(deg2rad(fracAngleX)) ME-r*sin(deg2rad(fracAngleX))];
[firstFracLine] = findFirstFrac(tunnelIntersectPoint, fracAngleX, fracSpacing, z+ME, 2*ME);

fracLinesSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\Fraclines.mat';
fracPlanesSaveMatPath = 'D:\achievement\myPaper\Suitability research of EDFM for calculation of fractured rock tunnel\code\mrst-2024a-research\mrst-2024a\period1\EDFM\SCI\11\workspaceData\Fracplanes.mat';

%% Generate equal spaced fractures in a rectangular domain with tunnel
fracLines1 = generateEqualSpacedFracsInRectDomainWithTunnel(rectDomain, tunnelCenter, r, fracSpacing, fracAngleX, firstFracLine, fracLinesSaveMatPath);
fracAngleX = 135;
tunnelIntersectPoint = [ME+r*cos(deg2rad(180-fracAngleX)) ME-r*sin(deg2rad(180-fracAngleX))];
firstFracLine = findFirstFracForNegativeFracture(tunnelIntersectPoint, fracAngleX, fracSpacing, z+ME, 2*ME, ME);
fracLines2 = generateEqualSpacedFracsInRectDomainWithTunnel(rectDomain, tunnelCenter, r, fracSpacing, fracAngleX, firstFracLine, fracLinesSaveMatPath);
% disp(tunnelIntersectPoint);
% disp(firstFracLine);

%% Generate EDFM fracture planes from fracture lines
fracPlanes1 = generateEDFMFracplanesFromFraclines(fracLines1, '');
fracPlanes2 = generateEDFMFracplanesFromFraclines(fracLines2, '');
fracPlanes = [fracPlanes1, fracPlanes2];
save(fracPlanesSaveMatPath, "fracPlanes");
disp(length(fracPlanes));
disp(length(fracPlanes1));
disp(length(fracPlanes2));