function [states] = rectDomainWithoutTunnelWithoutFracturesBC1Solver(G, fluidModel, solutionSavePath)
    %% Steady state single phase flow solver for rectangular domain without tunnel without fractures

    %% Input
    % G: grid structure
    % fluidModel: fluid model
    % solutionSavePath: path to save the solution

    %% Output
    % states: solution

    %% Set up gravity
    gravity reset off;

    %% Set up initial and boundary conditions
    pRef = 1*barsa;
    deltaP = 1*barsa;

    % Initial condition
    state = initResSol(G, pRef);

    % Boundary condition
    tol = 1e-3;
    [~, ~, leftFaces, rightFaces, ~] = findBoundaryFace(G, tol);
    bc = [];
    bc = addBC(bc, leftFaces, 'Pressure', pRef);
    bc = addBC(bc, rightFaces, 'Pressure', pRef+deltaP);

    states = steadySinglePhaseFlowSolver(G, fluidModel, state, bc, false, solutionSavePath);
end