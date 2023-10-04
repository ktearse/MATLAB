% P20A HW1: Computations on fake resting heart rate data
% Author: Katherine Tearse UID 906065514
% Date: 4/6/2023

clear  %clear previously defined variables from memory
clc    %clear command window

% Ages of 10 subjects in years
ageYears = [19, 24, 20, 21, 18, 21, 23, 19, 20, 23];

% Day1 heartrates of subjects in beats-per-minute
beatsPerMinDay1 = [65.8, 80.2, 78.4, 69.5, 79.7, 82.3, 69.4, 97.8, 53.8, 105.4];

% Day 2 heartrates of subjects in beats-per-minute
beatsPerMinDay2 = [55.7, 78.2, 77.2, 66.0, 81.8, 62.5, 78.9, 92.3, 56.3, 103.8];

% Day 1 heartrates of subjects in beats-per-second
beatsPerSecDay1 = beatsPerMinDay1 / 60;

% Day 2 heartrates of subjects in beats-per-second
beatsPerSecDay2 = beatsPerMinDay2 / 60;

% Day 1 mean heart-rate in beats-per-minute
meanBeatsPerMinDay1 = mean(beatsPerMinDay1);

% Day 2 mean heart-rate in beats-per-minute
meanBeatsPerMinDay2 = mean(beatsPerMinDay2);

% Day 1 minimum heart-rate in beats-per-minute
minBeatsPerMinDay1 = min(beatsPerMinDay1);

% Day 2 minimum heart-rate in beats-per-minute
minBeatsPerMinDay2 = min(beatsPerMinDay2);

% Difference between heart-rates on Day 2 in comparison to Day 1, in
% beats-per-minute
beatsPerMinDiff = beatsPerMinDay2 - beatsPerMinDay1;

% Difference between heart-rates on Day 2 in comparison to Day 1, in
% beats-per-minute for subjects who are at least 20 years old
beatsPerMinDiffAgeAtLeast20 = beatsPerMinDiff (ageYears > 19);

% Proportion of subjects with lower heart-rate on Day 2
propHeartRateDecrease = mean(beatsPerMinDiff < 0);

% Position of subejcts with higher heart-rate on Day 2
whichSubjectHeartRateIncrease = find(beatsPerMinDiff > 0);

% Number of heat-rates on Day 1 <60 beats-per-minute or >95
% beats-per-minute
numUnusualHeartRateDay1 = sum(beatsPerMinDay1 < 60 | beatsPerMinDay1 > 95);

% Number of heat-rates on Day 2 <60 beats-per-minute or >95
% beats-per-minute
numUnusualHeartRateDay2 = sum(beatsPerMinDay2 < 60 | beatsPerMinDay2 > 95);

% Proportion of subjects whose heart-rates have an absolute difference
%between Day 1 and 2 of 8 beats-per-minute or more
propHeartRateBigDiff = mean(abs(beatsPerMinDiff) > 7);

% Vector with the first 5 elements from beatsPerMinDiff
beatsPerMinDiffFirst5 = beatsPerMinDiff(1:5);

