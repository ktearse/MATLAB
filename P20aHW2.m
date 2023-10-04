% P20A HW2: Organization and statistics of fake heart-rate and memory data for five subjects
% Author: Katherine Tearse UID 906065514
% Date: 4/16/2023


clear %clear previously defined variables from memory
clc   %clear command window

%% RAW DATA
% Heart-rate data is in beats-per-minute, memory score data is on a 1-10
% scale

% Data of 1st subject: heart-rate measurements and memory scores
dataSubj1 = [69 7
             84 6
             83 8
             77 7];


% Data of 2nd subject: heart-rate measurements and memory scores
dataSubj2 = [83 6
             80 5
             90 7
             85 7];

% Data of 3rd subject: heart-rate measurements and memory scores
dataSubj3 = [75 8
             82 5
             70 7
             78 8];

% Data of 4th subject: heart-rate measurements and memory scores
dataSubj4 = [88 5
             83 7
             89 6
             80 6];

% Data of 5th subject: heart-rate measurements and memory scores
dataSubj5 = [78 8
             85 8
             76 9
             87 8];

% 3D array containing all of the subjects' data
dataAll = cat(3,dataSubj1, dataSubj2, dataSubj3, dataSubj4, dataSubj5);

%% BASIC STATISTICS

% Number of subjects
numSubjects = size(dataAll, 3);

% Means of heart-rate and memory score across subjects, by day
meansAcrossSubjects = mean(dataAll, 3);

% Means of heart-rate and memory score across days, by subject
meansAcrossDays = mean(dataAll, 1);
meansAcrossDays = reshape(meansAcrossDays, [], 5);
meansAcrossDays = meansAcrossDays';

% Grand mean of heart-rate across all days and subjects
totalMeans = mean(meansAcrossSubjects, 1);
grandMeanHeartRate = totalMeans(1, 1);

% Grand mean of memory score across all days and subjects
grandMeanMemoryScore = totalMeans(1, 2);
