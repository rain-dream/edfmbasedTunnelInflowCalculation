function formatFigure(colorBarLim, colorBarTitle, xTicks, yTicks)
    %% Format the figure
    
    %% Input
    % colorBarLim: color bar limit
    % colorBarTitle: color bar title
    % xTicks: x-axis ticks
    % yTicks: y-axis ticks

    % figure("Unit", "centimeter","Position", [0 0 5 4]);

    %% Format the color axis
    if length(colorBarLim) == 2
        % caxis(colorBarLim);
        clim(colorBarLim);
    end

    %% Format the axes
    axis equal tight;
    box on;
    xticks(xTicks);
    yticks(yTicks);
    ax = gca;
    ax.XAxis.FontSize = 24;
    ax.YAxis.FontSize = 24;
    ax.XLabel.String = '{\it{x}} (m)';
    ax.XLabel.FontSize = 28;
    ax.YLabel.String = '{\it{y}} (m)';
    ax.YLabel.FontSize = 28;
    set(gca, 'FontName', 'Times New Roman');

    % axis tight;

    %% Format the color bar
    cb = colorbar('EastOutside');
    
    cb.Title.String = colorBarTitle;
    % cb.Position(1) = cb.Position(1)+0.003;
    cb.FontSize = 24;
    cb.FontName = 'Times New Roman';
    cb.Ticks = 0:2e5:8e5;
    % colorbar('ylim', colorBarLim);
    colormap('jet');
end