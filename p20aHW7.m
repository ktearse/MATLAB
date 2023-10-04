% P20A HW6: Drug efficency calculations and graphs
% Author: Katherine Tearse UID 906065514
% Date: 5/21/2023

% This program will perform statistics on drug efficacy data and make
% graphs. Coding is as follows: 1=treatment group, 0=placebo group

% Required data file: fakeMemoryData2022.csv
% Created image files: 
%% SETUP

clc % clear variables
close all % close figures
colorTreat = [0.9 0.8 0.1]; %light orange RGB triplet
colorPlacebo = [0.4 0.8 1 ]; %light blue RGB triplet


%% IMPORT & EXTRACT DATA

% Import table from file
dataTable = readtable('fakeMemoryData2022.csv');

% Digit-span scores for treatment group 
scoreTreatDigit = dataTable{dataTable{:, "Condition"} == 1, "DigitScore"};

% Object recognition scores for treatment group 
scoreTreatObject = dataTable{dataTable{:, "Condition"} == 1, "ObjectScore"};

% Digit-span scores for placebo group 
scorePlaceboDigit = dataTable{dataTable{:, "Condition"} == 0, "DigitScore"};

% Object recognition scores for placebo group
scorePlaceboObject = dataTable{dataTable{:, "Condition"} == 0, "ObjectScore"};


%% STATISTICS

% Mean digit-span score in treatment group 
meanTreatDigit = mean(scoreTreatDigit); 

% Mean object-recognition score in treatment group
meanTreatObject = mean(scoreTreatObject);

% Mean digit-span scores in placebo group
meanPlaceboDigit = mean(scorePlaceboDigit);

% Mean object-recognition scores in placebo group
meanPlaceboObject = mean(scorePlaceboObject);


% Standard deviation of digit-span scores in treatment group 
sdTreatDigit= std(scoreTreatDigit);

% Standard deviation  object-recognition scores in treatment group
sdTreatObject= std(scoreTreatObject);

% Standard deviation of digit-span scores in placebo group 
sdPlaceboDigit= std(scorePlaceboDigit);

% Standard deviation of object-recognition scores in placebo group
sdPlaceboObject = std(scorePlaceboObject);


% SEM of digit-span scores in treatment group 
semTreatDigit = sdTreatDigit ./ sqrt(length(scoreTreatDigit));

% SEM of object-recognition scores in treatment group 
semTreatObject = sdTreatObject ./ sqrt(length(scoreTreatObject));

% SEM of digit-span scores in placebo group
semPlaceboDigit = sdPlaceboDigit ./ sqrt(length(scorePlaceboDigit));

% SEM of object-recognition scores in placebo group 
semPlaceboObject = sdPlaceboObject ./ sqrt(length(scorePlaceboObject));


%% FIGURE 1 – HISTOGRAMS
figure(1) % open figure 1

subplot(2,2,1)
histogram(scoreTreatDigit, 'FaceColor', colorTreat)
title({'Treatment Group' 'Digit-Span Scores'}) % title 
xlabel('Score')                        % x-axis label
ylabel('Count')                        % y-axis label
alpha(1)                               % opacity level
xlim([40 90])                         % x-axis limits
ylim([0 6])                           % y-axis limits

subplot(2,2,2)
histogram(scoreTreatObject, 'FaceColor', colorTreat)
title({'Treatment Group' 'Object-Recognition Scores'}) % title 
xlabel('Score')                        % x-axis label
ylabel('Count')                        % y-axis label
alpha(1)                               % opacity level
xlim([40 90])                          % x-axis limits
ylim([0 6])                            % y-axis limits

subplot(2,2,3)
histogram(scorePlaceboDigit, 'FaceColor', colorPlacebo)
title({'Placebo Group' 'Digit-Span Scores'}) % title 
xlabel('Score')                        % x-axis label
ylabel('Count')                        % y-axis label
alpha(1)                               % opacity level
xlim([40 90])                          % x-axis limits
ylim([0 6])                            % y-axis limits

subplot(2,2,4)
histogram(scorePlaceboObject, 'FaceColor', colorPlacebo)
title({'Placebo Group' 'Object-Recognition Scores'}) % title
xlabel('Score')                        % x-axis label
ylabel('Count')                        % y-axis label
alpha(1)                               % opacity level
xlim([40 90])                          % x-axis limits
ylim([0 6])                            % y-axis limits


%% FIGURE 2 – GROUPED BAR GRAPH
figure(2) %open figure 2

% Creates grouped bar graph
meanTreat = [meanTreatDigit meanTreatObject];
meanPlacebo = [meanPlaceboDigit meanPlaceboObject];
scoreBarGraphGrouped = bar(1:2, [meanTreat' meanPlacebo'], 'FaceColor', 'flat');
scoreBarGraphGrouped(1,1).CData = colorTreat;
scoreBarGraphGrouped(1,2).CData = colorPlacebo;


% Add labels
title('Mean Memory Scores', 'FontWeight','bold');             % title
xlabel('Memory Test Type', 'FontWeight','bold');              % x-axis label
ylabel('Memory Score', 'FontWeight','bold');                  % y-axis label
set(gca, 'XTick', 1:2);                                       % specify where to put tick-mark locations on x-axis
set(gca, 'XTickLabel', ["Digit-Span" "Object-Recognition"]);  % labels
set(gca, 'YGrid', 'on')                                       % Adds horizontal lines
ylim([0 70])

% Add error bars
semTreat = [semTreatDigit semTreatObject];
semPlacebo = [semPlaceboDigit semPlaceboObject];

hold on
errorbar((1:2)-0.15, meanTreat, semTreat, 'black', 'LineStyle', 'none')
hold off

hold on
errorbar((1:2)+0.15, meanPlacebo, semPlacebo, 'black', 'LineStyle', 'none')
hold off

% Add legend and error bar label
text(2.6, 55, {'Error bars' 'indicate' [char(177) '1 SEM'] }, 'FontSize', 10)
legend('Treatment', 'Placebo', 'location', 'northeastoutside')


%% FIGURE 3 – SCATTER PLOT
figure(3)                                                   %open figure 3

% Create scatterplots
scatter(scoreTreatDigit, scoreTreatObject, '^black','MarkerFaceColor', colorTreat)
hold on
scatter(scorePlaceboDigit, scorePlaceboObject, 'oblack', 'MarkerFaceColor', colorPlacebo)
hold off

% Add labels and limits
legend('Treatment', 'Placebo', 'location', 'northwest')       % Add legend
title({'Object-Recognition Score ' 'vs. Digit-Span Score'})   % add title
xlabel('Digit-Span Score', 'FontWeight','bold');              % x-axis label
ylabel('Object-Recognition Score', 'FontWeight','bold');      % y-axis label
xlim([40 90])                                                 % x-axis limits
ylim([40 90])                                                 % y-axis limits
set(gca, 'YTick', [40 50 60 70 80 90]) 

% Adds grid
grid on                                                       

% Make graph square
axis square

% Add box around graph
box on

%% SAVE FIGURES

saveas(1, 'psych20ahw7fig1.pdf')
saveas(2, 'psych20ahw7fig2.pdf')
saveas(3, 'psych20ahw7fig3.pdf')
