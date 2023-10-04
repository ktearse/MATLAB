% P20A HW5: Script for free association exercise
% Author: Katherine Tearse UID 906065514
% Date: 5/7/2023

% necessary file:
% free association word list.csv

% created files: 
% psych20ahw5data.mat
% psych20ahw5results.csv

%% SETUP

clear       % clear previously defined variables from memory
clc         % clear command window
rng shuffle % shuffle random number generator


%% PREPARE WORD-PROMPTS

% Imports the list of adjectives and nonadjectives, initializes # of
% prompts. Column 1 is the word, Column 2 indicates if the word is an
% adjective (1) or not (0)
wordTable = readtable('free association word list.csv');
numPrompts = 10;

% Creates 2 vectors (one for nonadjectives, one for Adjectives)
nonAdjectives = wordTable{wordTable{ :, 'IsAdjective'} == 0, 'Word'};
yesAdjectives = wordTable{wordTable{ :, 'IsAdjective'} == 1, 'Word'};

% Samples 5 random words from each vector, into prompts cell array
prompts = cell(2, 5);
prompts(1, :) = randsample(nonAdjectives, numPrompts/2); %row 1 contains 5 random non-adjectives
prompts(2, :) = randsample(yesAdjectives, numPrompts/2); %row 2 contains 5 random adjectives


%% FREE-ASSOCIATION EXERCISE

% Creates responses column-vector of cells to store user responses and
% responseSecs to store response times to each prompt
responses = cell(numPrompts, 1);
responseSecs = NaN(numPrompts, 1);

fprintf(['*** FREE-ASSOCIATION EXERCISE ***\n\nAfter each presented word, type' ...
    ' the first word that comes to mind in response.\nType your answer as quickly' ...
    ' as possible without thinking about it, and then press Return.\n\nPress any key to begin.\n'])
pause 

% Presents users with word prompts, records their response time, continues
% to ask for input if user input is empty and quits program if user chooses
% to abort
for i = 1:numPrompts
    clc
    message = "" + prompts(i) + "\n";
    tic
    responses{i}= input(message, 's');
    responseSecs(i) = toc;
    while isempty(responses{i}) == 1
        tic
        responses{i}= input(message, 's');
        responseSecs(i) = toc;
    end
    if strcmpi(responses{i}, 'abort exercise') == 1
        fprintf('Exercise aborted.')
        return
    end
end


%% REPORT

% Reshapes prompts and responses to fit into matrix
prompts = reshape(string(prompts), numPrompts, 1);
responses = reshape(string(responses), numPrompts, 1);
intermediateMatrix = cat(2, prompts, responses);

% Creates resultsTable from intermediateMatrix, with columns for prompts
% asked and responses given
resultsTable = array2table(intermediateMatrix, 'VariableNames', ["Prompts" "Response"]);

% Adds Seconds column to resultsTable
resultsTable{:, "Seconds"} = responseSecs;

% Displays resultsTable and prints message
clc
disp(resultsTable)
fprintf('Exercise complete!')


%% SAVE

% Saves prompts, responses, and responseSecs to sych20ahw5data.mat data
% file
save("psych20ahw5data.mat", 'prompts', 'responses', 'responseSecs')

% Exports resultsTable to psych20ahw5results.csv csv file
writetable(resultsTable, 'psych20ahw5results.csv')
