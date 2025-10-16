%% This script is used to generate fractures.

%% Set parameters
h = 20;                     % groundwater head above the tunnel centerline
z = 20;                     % tunnel depth
ME = 100;                   % model extent
r = 3;                      % tunnel radius
rectDomain = [0 0; 2*ME z+ME];  % model extent
tunnelCenter = [ME ME];     % tunnel center
fracSpacing = 8;            % fracture spacing
fracAngleX = 40;            % dip angle of one fracture set
fracLinesSavePath = 'examples\workspaceData\fracLines.mat';     % fracture lines save path
fracPlanesSavePath = 'examples\workspaceData\fracPlanes.mat';   % fracture planes save path

%% Generate equal spaced fractures in a rectangular domain with a tunnel
tunnelIntersectPoint = [ME-r*cos(deg2rad(fracAngleX)) ME-r*sin(deg2rad(fracAngleX))];
[firstFracLine] = findFirstFrac(tunnelIntersectPoint, fracAngleX, fracSpacing, z+ME, 2*ME);

fracLines1 = generateEqualSpacedFracsInRectDomainWithTunnel(rectDomain, tunnelCenter, r, fracSpacing, fracAngleX, firstFracLine, fracLinesSavePath);
fracAngleX = 130;
tunnelIntersectPoint = [ME+r*cos(deg2rad(180-fracAngleX)) ME-r*sin(deg2rad(180-fracAngleX))];
firstFracLine = findFirstFracForNegativeFracture(tunnelIntersectPoint, fracAngleX, fracSpacing, z+ME, 2*ME, ME);
fracLines2 = generateEqualSpacedFracsInRectDomainWithTunnel(rectDomain, tunnelCenter, r, fracSpacing, fracAngleX, firstFracLine, fracLinesSavePath);

%% Generate EDFM fracture planes from fracture lines
fracPlanes1 = generateEDFMFracplanesFromFraclines(fracLines1);
fracPlanes2 = generateEDFMFracplanesFromFraclines(fracLines2);
fracPlanes = [fracPlanes1, fracPlanes2];
save(fracPlanesSavePath, "fracPlanes");