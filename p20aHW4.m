% P20A HW4: Script for addition or subtraction quiz
% Author: Katherine Tearse UID 906065514
% Date: 4/30/2023

clear %clear previously defined variables from memory
clc   %clear command window

%% DEFINE QUESTION VALUES

% Creates a matrix containing number for quiz
questionValues = [ 4 8
                   3 9
                   7 7
                   5 6
                   9 4
                   8 7
                   6 3
                   4 5];

% Define variable containing the number of columns
numQuestions = height(questionValues);

%% QUIZ-TYPE SELECTION

% User's response stored in testType. Will continue to prompt if entry is
% not a valid option
testType = input('\n\nType \"a\" to practice addition or \"m\" to practice multiplication: ', 's') ;
while strcmpi(testType, 'a') == 0 && strcmpi(testType, 'm') == 0
    testType = input('\n\nType \"a\" to practice addition or \"m\" to practice multiplication: ', 's') ;
end


% Create answer key based on user response to type of test (+ or *)
answerKey = [];
if testType == 'a' || testType == 'A' 
    answerKey = sum(questionValues,2);
elseif testType == 'm' || testType == 'M' 
    answerKey = prod(questionValues, 2);
end

%% GIVE QUIZ

% Creates a counter variable for the number of correct answers
numCorrect = 0;

% Creates responses 8x1 column vector to store user input
responses = cell(length(answerKey), 1);

% Presents user with questions based on testType selection, keeps track of
% number of correct answers, responds with appropriate grading of answer,
% and quits if 'stop' is entered
if testType == 'a' || testType == 'A' 
    for i = 1:length(answerKey)
        sentence = "\n\nWhat is " + num2str(questionValues(i,1)) + " plus " + num2str(questionValues(i,2)) + "? ";
        responses{i} = input(sentence, 's');
        if strcmpi(responses{i}, 'stop') == 1
            fprintf('\n\nTest aborted.\n\n')
            return
        elseif str2double(responses{i}) == answerKey(i)
            fprintf("\n\nCorrect!")
            numCorrect = numCorrect + 1;
        elseif isnan(str2double(responses{i}))
            fprintf("\n\nInvalid answer.")
        else
            fprintf("\n\nIncorrect!")
        end
    end
elseif testType == 'm' || testType == 'M' 
    for i = 1:length(answerKey)
        sentence = "\n\nWhat is " + num2str(questionValues(i,1)) + " times " + num2str(questionValues(i,2)) + "? ";
        responses{i} = input(sentence, 's');
        if strcmpi(responses{i}, 'stop') == 1
            fprintf('\n\nTest aborted.\n\n')
            return
        elseif str2double(responses{i}) == answerKey(i)
            fprintf("\n\nCorrect!")
            numCorrect = numCorrect + 1;
        elseif isnan(str2double(responses{i}))
            fprintf("\n\nInvalid answer.")
        else
            fprintf("\n\nIncorrect!")
        end
    end
end


%% REPORT & SAVE

% Reports results of the quiz
response = "\n\nYou got " + numCorrect + " out of " + numQuestions + " correct.\n\n";
fprintf(response)

% Saves all objects into psych20ahw4data’
save ("psych20ahw4data.mat")