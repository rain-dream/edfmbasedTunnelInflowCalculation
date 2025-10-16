function [fracPlanes] = generateEDFMFracplanesFromFraclines(fracLines, fracPlanesSaveMatPath)
    %% Generate EDFM fracture planes from fracture lines

    %% Input
    % fracLines: endpoint coordinates of fracture lines
    % fracPlanesSaveMatPath: path of the mat file to save fracture planes

    %% Output
    % fracPlanes: fracture planes

    fracPlanes = struct('points', []);

    for i = 1:length(fracLines)
        % fracPlanes(i).points = [round(fracLines(i).points(1, 1), 2), round(fracLines(i).points(1, 2), 2), 0.00;
        %                         round(fracLines(i).points(2, 1), 2), round(fracLines(i).points(2, 2), 2), 0.00;
        %                         round(fracLines(i).points(2, 1), 2), round(fracLines(i).points(2, 2), 2), 1.00;
        %                         round(fracLines(i).points(1, 1), 2), round(fracLines(i).points(1, 2), 2), 1.00];
        fracPlanes(i).points = [fracLines(i).points(1, 1), fracLines(i).points(1, 2), 0.00;
                                fracLines(i).points(2, 1), fracLines(i).points(2, 2), 0.00;
                                fracLines(i).points(2, 1), fracLines(i).points(2, 2), 1.00;
                                fracLines(i).points(1, 1), fracLines(i).points(1, 2), 1.00];
    end

    if ~isempty(fracPlanesSaveMatPath)
        save(fracPlanesSaveMatPath, 'fracPlanes');
    end
end