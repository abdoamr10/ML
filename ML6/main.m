clc
clear all
close all

ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',17999);
T = read(ds);
size(T);


X = T{:,4:21};
Corr_x = corr(X);
x_cov = cov(X);

%A correlation could be positive, meaning both variables move in the same direction, or negative, 
%meaning that when one variable�s value increases, the other variables� values decrease.
%Correlation can also be neural or zero, meaning that the variables are unrelated.

%Positive Correlation: both variables change in the same direction.
%Neutral Correlation: No relationship in the change of the variables.
%Negative Correlation: variables change in opposite directions.

[U S V] =  svd(x_cov);

eigenvalues = diag(S)'; 
b = sum(eigenvalues);
m = length(eigenvalues);
k = 0;
a = 0 ;

for c = 1:length(eigenvalues)
    
    k = k + 1;
    a = a + eigenvalues(c);
    alpha = 1 - (a/b);
    if alpha <0.001
    break;
    end
    
end

Reduced = U(: , 1:k)'*X';
Reduced = Reduced';
approx = Reduced*U(1:k , 1:k);


error = 1/m * sum(approx-Reduced); 
    
%linear regression supply the Reduced data set as the data set for
%assignment 1

%part 2

% Main data
centroids = kMeansInitCentroids(X, 2);

for iter = 1:10 
    idx = findClosestCentroids(X , centroids);
    centroids = computeCentroids(X , idx , 2);
end


% reduced data
centroids = kMeansInitCentroids(Reduced, 2);

for iter = 1:10 
    idx = findClosestCentroids(Reduced , centroids);
    centroids = computeCentroids(Reduced , idx , 2);
end


% part 3

[mu sigma2] = estimateGaussian(X);
p = multivariateGaussian(X, mu, sigma2);
% loop to get cv 
[epsilon F1] = selectThreshold(X , p);
