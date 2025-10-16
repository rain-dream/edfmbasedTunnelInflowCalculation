function [states] = cubicDomainWithTunnelWithCrossingFracturesBC1(matrixG, matrixFractureG, fluidModel, fracNo, fracTunnelInterPoints, solutionSavePath)
    %% Steady state single phase flow solver for cubic domain with tunnel with crossing fractures

    %% Input
    % matruxG: grid structure of the matrix domain
    % matrixFractureG: grid structure of the matrix domain with fractures
    % fluidModel: fluid model
    % fracNo: index of fractures crossing through tunnel
    % fracTunnelInterPoints: intersection points between fractures and tunnel (x coordinates)
    % solutionSavePath: path to save the solution

    %% Output
    % states: solution

    %% Set up gravity
    gravity('on');
    gravity('y');

    %% Set up initial and boundary conditions
    rhoW = 1000;  % Density of water
     
    % Initial condition
    state = initResSol(matrixFractureG, (matrixFractureG.h+matrixFractureG.ME-matrixFractureG.cells.centroids(:,2))*rhoW*norm(gravity), 1.0);

    % Boundary condition
    tol = 1e-6;
    [matrixGUpperFaces, matrixGBottomFaces, matrixGLeftFaces, matrixGRightFaces, ~, ~, matrixGInnerFaces] = findBoundaryFace3D(matrixG, tol);
    [matrixFractureGUpperFaces, matrixFractureGBottomFaces, matrixFractureGLeftFaces, matrixFractureGRightFaces, ~, ~, ~] = findBoundaryFace3D(matrixFractureG, tol);

    bc = [];
    bc = addBC(bc, matrixFractureGUpperFaces, 'Pressure', 0);
    bc = addBC(bc, matrixFractureGLeftFaces, 'Pressure', (matrixFractureG.h+matrixFractureG.ME-matrixFractureG.faces.centroids(matrixFractureGLeftFaces,2))*rhoW*norm(gravity));
    bc = addBC(bc, matrixFractureGRightFaces, 'Pressure', (matrixFractureG.h+matrixFractureG.ME-matrixFractureG.faces.centroids(matrixFractureGRightFaces,2))*rhoW*norm(gravity));
    bc = addBC(bc, matrixFractureGBottomFaces, 'Pressure', (matrixFractureG.h+matrixFractureG.ME)*rhoW*norm(gravity));
    bc = addBC(bc, matrixGInnerFaces, 'Pressure', 0.0);

    fracTunnelInterFaces = findFracTunnelInterFaces(matrixFractureG, fracNo, fracTunnelInterPoints);
    
    bc = addBC(bc, fracTunnelInterFaces, 'Pressure', 0.0);

    %% Solve
    [states] = steadySinglePhaseFlowSolver(matrixFractureG, fluidModel, state, bc, true, solutionSavePath);
end