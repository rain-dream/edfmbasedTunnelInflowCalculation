function [states] = rectDomainWithTunnelWithoutFracturesBC1Solver(G, fluidModel, solutionSavePath)
    %% Steady state single phase flow solver for rectangular domain with tunnel without fractures

    %% Input
    % G: grid structure
    % fluidModel: fluid model
    % solutionSavePath: path to save the solution

    %% Output
    % states: solution

    %% Set up gravity
    gravity('on');
    gravity('y');  % the y component of gravity needs to be changed

    %% Set up initial and boundary conditions
    rhoW = 1000;  % Density of water

    % Initial condition
    state = initResSol(G, (G.h+G.ME-G.cells.centroids(:,2))*rhoW*norm(gravity), 1.0);

    % Boundary condition
    tol = 1e-3;
    [upperFaces, ~, leftFaces, rightFaces, innerFaces] = findBoundaryFace2D(G, tol);
    bc = [];
    bc = addBC(bc, upperFaces, 'Pressure', 0.0);
    bc = addBC(bc, leftFaces, 'Pressure', (G.h+G.ME-G.faces.centroids(leftFaces,2))*rhoW*norm(gravity));
    bc = addBC(bc, rightFaces, 'Pressure', (G.h+G.ME-G.faces.centroids(rightFaces,2))*rhoW*norm(gravity));
    bc = addBC(bc, innerFaces, 'Pressure', 0.0);

    states = steadySinglePhaseFlowSolver(G, fluidModel, state, bc, false, solutionSavePath);
end