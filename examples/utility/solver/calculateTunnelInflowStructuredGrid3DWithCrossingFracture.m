function [q] = calculateTunnelInflowStructuredGrid3DWithCrossingFracture(G, matrixFractureG, states, fracNo, fracTunnelInterPoints, apertures, tunnelFracInterFaceCentroids)
    %% Calculate tunnel inflow rate on 3D structured grid with crossing fracture

    %% Input
    % G: grid
    % matrixFractureG: grid structure of the matrix domain with fractures
    % states: states
    % fracNo: index of fractures crossing through tunnel
    % fracTunnelInterPoints: intersection points between fractures and tunnel (x coordinates)
    % apertures: fracture apertures
    % tunnelFracInterFaceCentroids: centroids of the faces of the tunnel-fracture intersection

    %% Output
    % q: tunnel inflow rate 

    [~, ~, ~, ~, ~, ~, tunnelBoundaryFaces] = findBoundaryFace3D(G, 1e-5);
    [tunnelFracInterfaces] = findSpecifiedCentroidMatrixFaces(G, tunnelFracInterFaceCentroids, 1e-5);

    q = sum(abs(states{1}.flux(tunnelBoundaryFaces)));

    for i = 1:length(tunnelFracInterfaces)
        rawFaceQ = abs(states{1}.flux(tunnelFracInterfaces(i)));
        q = q - apertures(i)/G.faces.areas(tunnelFracInterfaces(i))*rawFaceQ;
    end

    fracTunnelInterFaces = findFracTunnelInterFaces(matrixFractureG, fracNo, fracTunnelInterPoints);

    qfrac = sum(abs(states{1}.flux(fracTunnelInterFaces)));
    q = q + qfrac;
end