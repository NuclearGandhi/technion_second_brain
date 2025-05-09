Eyy=handles_ncorr.data_dic.strains(14).plot_eyy_ref_formatted; % the 16th Eyy field 
% caused by the maximal load (think why 16th and not 17th)

% Plot only the range from x=372 to x=470
plot(Eyy(225, 372:470),'*-'); % The strain along a certain line on the tensile 
% specimen (here the line corresponds to the 88th raw of the 16th Eyy matrix)

ylabel('$\varepsilon_{yy}$','Interpreter','latex','FontWeight','bold','FontSize',18)
xlabel('$x(y=225)$','Interpreter','latex','FontWeight','bold','FontSize',18)
ax = gca;
ax.FontSize = 18;
xlim([1 length(372:470)]);
xticks(1:20:length(372:470));
xticklabels(372:20:470);

% Save the figure
fig = gcf;
fig.Position = [100, 100, 600, 400]; % Set a good size for the figure
saveas(fig, 'eyy_x372_to_x470.png');
saveas(fig, 'eyy_x372_to_x470.fig'); % Also save as MATLAB figure for future editing

