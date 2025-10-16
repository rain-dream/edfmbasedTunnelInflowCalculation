function [states] = cubicDomainWithTunnelWithoutFracturesBC1Solver(G, fluidModel, solutionSavePath)
    %% Steady state single phase flow solver for cubic domain with tunnel without fractures

    %% Input
    % G: grid structure
    % fluidModel: fluid model
    % solutionSavePath: path to save the solution

    %% Output
    % states: solution

    %% Set up gravity
    gravity('on');
    gravity('y');

    %% Set up initial and boundary conditions
    rhoW = 1000;  % Density of water

    % Initial condition
    state = initResSol(G, (G.h+G.ME-G.cells.centroids(:,2))*rhoW*norm(gravity), 1.0);

    % Boundary condition
    tol = 1e-6;
    [upperFaces, ~, leftFaces, rightFaces, ~, ~, innerFaces] = findBoundaryFace3D(G, tol);
    bc = [];
    bc = addBC(bc, upperFaces, 'Pressure', (G.h-G.z)*rhoW*norm(gravity));
    bc = addBC(bc, leftFaces, 'Pressure', (G.h+G.ME-G.faces.centroids(leftFaces,2))*rhoW*norm(gravity));
    bc = addBC(bc, rightFaces, 'Pressure', (G.h+G.ME-G.faces.centroids(rightFaces,2))*rhoW*norm(gravity));
    bc = addBC(bc, innerFaces, 'Pressure', 0.0);

    %% Solve
    states = steadySinglePhaseFlowSolver(G, fluidModel, state, bc, false, solutionSavePath);
end