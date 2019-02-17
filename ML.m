clc
clear all
close all

% Loading the dataset

dataSet = importdata('house_prices_data_training_data.csv');

% Storing the values in seperate matrices
prices = dataSet.data(:, 1);

bedroom = dataSet.data(:, 2);
bathroom = dataSet.data(:, 3);
year = dataSet.data(:, 13);
U1=dataSet.data(:,2:19);
U2=dataSet.data(:,17:18);
U3=dataSet.data(:,11:15);
U4=U1.^2;
U5=U3.^2;

%constructing four diffrent hypothesis (will be tuned with normalization ,
%diffrent learning rates)
x1 = [ones(length(prices), 1) year bedroom bathroom];
x2 = [ones(length(prices), 1) U1];
x3 = [ones(length(prices), 1) U4];
x4 = [ones(length(prices), 1) U2 U3 U5];

% Applying mean normalization to the variables of the hypothesis and the
% prices
% how come diffrent normalization is working?????
max0 = max(prices);
min0 = min(prices);
prices = (prices - max0) / (max0 - min0);

n1=length(x1(1,:));
for w=2:n1
    if max(abs(x1(:,w)))~=0
    x1(:,w)=(x1(:,w)-mean((x1(:,w))))./std(x1(:,w));
    end
end

n2=length(x2(1,:));
for w=2:n2
    if max(abs(x2(:,w)))~=0
    x2(:,w)=(x2(:,w)-mean((x2(:,w))))./std(x2(:,w));
    end
end

n3=length(x3(1,:));
for w=2:n3
    if max(abs(x3(:,w)))~=0
    x3(:,w)=(x3(:,w)-mean((x3(:,w))))./std(x3(:,w));
    end
end

n4=length(x4(1,:));
for w=2:n4
    if max(abs(x4(:,w)))~=0
    x4(:,w)=(x4(:,w)-mean((x4(:,w))))./std(x4(:,w));
    end
end
 

% Running gradient descent on the data
% 'parameters' is a matrix containing our thetas

% first hypothesis
parameters = zeros(n1,1);
learningRate = 0.1;
repetition = 1000;
[parameters, costHistory1] = gradient(x1, prices , parameters, learningRate, repetition);

% second hypothesis
parameters = zeros(n2,1);
learningRate = 0.01;
repetition = 1000;
[parameters, costHistory2] = gradient(x2, prices , parameters, learningRate, repetition);

% third hypothesis
parameters = zeros(n3,1);
learningRate = 1;
repetition = 1000;
[parameters, costHistory3] = gradient(x3, prices , parameters, learningRate, repetition);

% fourth hypothesis
parameters = zeros(n4,1);
learningRate = 0.1;
repetition = 50;
[parameters, costHistory4] = gradient(x4, prices , parameters, learningRate, repetition);

% Plotting our final hypothesis
figure(1);
plot(costHistory1) 

figure(2);
plot(costHistory2)

figure(3);
plot(costHistory3)

figure(4);
plot(costHistory4)

% using normal equation method
thetanew = inv(x1'*x1)*x1'*prices;
