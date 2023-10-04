
% P20A HW3: Intake of survey responses, analysis, and saved data
% Author: Katherine Tearse UID 906065514
% Date: 4/25/2023

clear %clear previously defined variables from memory
clc %clear command window

%%GET SURVEY RESPONSES

% Initialize a column vector of empty cells
responseCell = cell(4, 1);

% Assigns input to individual cells in responseCell
responseCell{1} = input('\nWhat is your favorite color? \n', 's');
responseCell{2} = input('\nWhat is your favorite style of music? \n', 's');
responseCell{3} = input('\nWhat is your favorite movie? \n', 's');
responseCell{4} = input('\nDescribe your current mood in words. \n', 's');

% Print message
fprintf("\nThe survey is complete.\nThank you for participating!\n")

% Convert responseCell vector to responseStruct structure, each cell becomes
% a labeled field
responseStruct = cell2struct(responseCell, {'faveColor' 'faveMusic' 'faveMovie'
'mood'});

%%ANALYZE RESPONSES

% Creates a new field (responseNumChar) in responseStruct, containing the length of each
% survey response
responseStruct.responseNumChar = strlength(responseCell)';

% Creates a new field (moodCharNoSpace) in responseStruct, containing the length of the last
% survey response, excluding spaces
responseStruct.moodCharNoSpace = strlength(strjoin(strsplit(responseStruct.mood, ""), ""));

% Creates a new field (moodNumI) in responseStruct, containing the number of i's in
% the mood response, not case-sensitive
% mechanism: 1. makes mood lowercase
% 2. creates a vector containing the positions of i's
% 3. finds the length of that vector to count the # of i's
responseStruct.moodNumI = length(strfind(lower(responseStruct.mood), 'i'));

% Creates a new field in (moodNumWords) in responseStruct, containing the
% number of words in the mood response
% mechanism: 1. turn mood into a string
% 2. split the string into a string vector
% 3. find the length of that vector to count the # of words
responseStruct.moodNumWords = length(strsplit(string(responseStruct.mood), [" ", ","]));

%%SAVE DATA

% Saves responseStruct as psych20ahw3data.mat
save('psych20ahw3data.mat', 'responseStruct')

% Creates and writes into a text file psych20ahw3mood.txt
load("psych20ahw3data.mat", "responseStruct")
fileID = fopen('psych20ahw3mood.txt', 'w');
fprintf(fileID, ['Mood response:\n\"' responseStruct.mood '\"']);
type psych20ahw3mood.txt

% Closes psych20ahw3mood.txt
fclose(fileID);
