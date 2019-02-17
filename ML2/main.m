clc
clear all
close all

% Loading the dataset
dataSet = importdata('heart_DD.csv');

U1 = dataSet.data(:, 1:13); 
U2 = dataSet.data(:, 1:6); 
U3 = dataSet.data(:, 6:10); 
U4 = dataSet.data(:, 11:12);
U5=U1.^2;
U6=U3.^2;
y = dataSet.data(:, 14);

%constructing four diffrent hypothesis (will be tuned with normalization ,
%diffrent learning rates)
x1 = [ones(length(y), 1) U1];
x2 = [ones(length(y), 1) U5];
x3 = [ones(length(y), 1) U2 U6];
x4 = [ones(length(y), 1) U2 U3];

%  implement the cost and gradient for logistic regression.
%  Setup the data matrix appropriately, and add ones for the intercept term

[m1, n1] = size(x1);
[m2, n2] = size(x2);
[m3, n3] = size(x3);
[m5, n4] = size(x4);

% Initialize fitting parameters
initial_theta = zeros(n1, 1);

% Compute and display initial cost and gradient , cost subject to certain
% accuracy

[cost, grad] = cost(initial_theta, x1, y)

plot(cost)

