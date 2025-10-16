function [states] = steadySinglePhaseFlowSolver(G, fluidModel, initialState, bc, isWithFractures, solutionSavePath)
    %% Steady state single phase flow solver
    
    %% Input
    % G: grid structure
    % fluidModel: fluid model
    % initialState: initial state
    % bc: boundary conditions
    % isWithFractures: boolean indicating if the domain has fractures
    % solutionSavePath: path to save the solution

    %% Output
    % states: solution

    %% Load relevant modules
    mrstModule add hfm 

    %% Set up fluid model
    if isWithFractures
        fluidModel.operators = setupEDFMOperatorsTPFA(G, G.rock, 1e-6);
    end
    fluidModel.stepFunctionIsLinear = true;

    %% Setup schedule
    % 1 second time step
    schedule = simpleSchedule(1, 'bc', bc);

    %% Solve the model
    [~, states, ~] = simulateScheduleAD(initialState, fluidModel, schedule);

    %% Save the solution
    if ~isempty(solutionSavePath)
        save(solutionSavePath, 'states');
    end
end