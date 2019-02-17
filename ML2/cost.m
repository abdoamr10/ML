function [J, grad] = cost(theta, X, y)

m = length(y); % number of training examples

grad = zeros(size(theta));
h = sigmoid(X * theta);
accuracyCost = [];
R=1;
while R == 1
    
    h = (X* theta - y)';
    theta = theta - (1/m) * h * X;
    J = -(1 / m) * sum( (y .* log(h)) + ((1 - y) .* log(1 - h)) );
    J
    accuracyCost(end+1)= J ;
    for i = 1 : size(theta, 1)
        grad(i) = (1 / m) * sum( (h - y) .* X(:, i) );
    end
if J <0.1;
    R=0;
end
end




end