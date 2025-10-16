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
    % disp(tunnelFracInterfaces);

    q = sum(abs(states{1}.flux(tunnelBoundaryFaces)));
    % disp('q:');
    % disp(q);
    for i = 1:length(tunnelFracInterfaces)
        rawFaceQ = abs(states{1}.flux(tunnelFracInterfaces(i)));
        q = q - apertures(i)/G.faces.areas(tunnelFracInterfaces(i))*rawFaceQ;
    end
    
    % rawFaceQ = 0;
    % for i = 1:length(tunnelFracInterfaces)
    %     rawFaceQ = rawFaceQ + abs(states{1}.flux(tunnelFracInterfaces(i)));
    % end
    % disp('rawFaceQ:');
    % disp(rawFaceQ);

    fracTunnelInterFaces = findFracTunnelInterFaces(matrixFractureG, fracNo, fracTunnelInterPoints);
    
    % qmatrix = q;
    % disp('matrix inflow:');
    % disp(qmatrix);

    qfrac = sum(abs(states{1}.flux(fracTunnelInterFaces)));
    % disp(abs(states{1}.flux(fracTunnelInterFaces(1))));
    % disp(abs(states{1}.flux(fracTunnelInterFaces(2))));
    % disp(abs(states{1}.flux(fracTunnelInterFaces(3))));
    % disp(abs(states{1}.flux(fracTunnelInterFaces(4))));
    q = q + qfrac;

    % disp('fracture inflow:');
    % disp(qfrac);

    disp('maximum fracture inflow:');
    disp(max(abs(states{1}.flux(fracTunnelInterFaces))));

    % disp('matrix/fracture inflow:');
    % disp(qmatrix/qfrac);

    % disp('relative error:');
    % disp(abs(3.7360e-3-q)/q);
end