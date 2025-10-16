function [fracTunnelInterFaces] = findFracTunnelInterFaces(matrixFractureG, fracNo, fracTunnelInterPoints)
    %% Find the faces of the fractures that intersect with the tunnel

    %% Input
    % matrixFractureG: grid structure of the matrix domain with fractures
    % fracNo: index of fractures crossing through tunnel
    % fracTunnelInterPoints: intersection points between fractures and tunnel (x coordinates)

    %% Output
    % fracTunnelInterFaces: faces of the fractures that intersect with the tunnel

    fracTunnelInterFaces = ones(1, length(fracNo));
    for i = 1:length(fracNo)
        fracName = strcat('Frac', num2str(fracNo(i)));
        fracFaces = matrixFractureG.FracGrid.(fracName).faces;
        idxFaces = 1:fracFaces.num;
        fracTunnelInterFaces(i) = idxFaces(abs(fracFaces.centroids(idxFaces, 1)-fracTunnelInterPoints(i))<1e-5)+fracFaces.start-1;
    end
end