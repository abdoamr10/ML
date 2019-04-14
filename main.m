clc
clear all
close all

ds = xlsread('house_prices_data_training_data.csv');
size(ds);


X = ds(:,4:21);
Corr_x = corr(X);
x_cov = cov(X);

%A correlation could be positive, meaning both variables move in the same direction, or negative, 
%meaning that when one variable’s value increases, the other variables’ values decrease.
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
approx = U(: , 1:k)* Reduced;
%error = 1/m * sum(approx-Reduced); 
    
%linear regression supply the Reduced data set as the data set for
%assignment 1

%part 2
% Main data
centroids = kMeansInitCentroids(X, 3);

for iter = 1:50 
    idx = findClosestCentroids(X , centroids);
    centroids = computeCentroids(X , idx , 3);
    for i=1:1:m
            J_cost(1,i) =  sum(X(i,:) - centroids(idx(i,1),:))^2;
        end
        J = (1/m)*sum(J_cost);
        if(iter == 1 )
            J_min = J;
            centroids_min = centroids;
            itr_min = iter;
        else
            if(J_min > J)
                J_min = J;
                centroids_min = centroids;
                
                itr_min = iter;
            end
        end    
end



% reduced data
% Reduced = Reduced';
% centroids = kMeansInitCentroids(Reduced, 2);
% 
% for iter = 1:50 
%     idx = findClosestCentroids(Reduced , centroids);
%     centroids = computeCentroids(Reduced , idx , 2);
%     for i=1:1:m
%             J_cost(1,i) =  sum(Reduced(i,:) - centroids(idx(i,1),:))^2;
%         end
%         J = (1/m)*sum(J_cost);
%         if(iter == 1 )
%             J_min = J;
%             centroids_min = centroids;
%             itr_min = iter;
%         else
%             if(J_min > J)
%                 J_min = J;
%                 centroids_min = centroids;
%                 
%                 itr_min = iter;
%             end
%         end    
% end



% part 3
mean = mean(X);
STD=std(X);

prod=1;
%for loop kol l houses
for i = 1:18
    CDF=normcdf(X(8,i),mean(i),STD(i));
    prod=prod*CDF;
end
if (prod>=0.999) || (prod<=0.009)
    fprintf('Anomalyxxxxxxxxxxxxxxxxxx')
end

