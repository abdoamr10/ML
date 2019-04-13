function [mu sigma2] = estimateGaussian(X)

[m, n] = size(X);

% You should return these values correctly
mu = zeros(n, 1);
sigma2 = zeros(n, 1);



mu = 1/m * sum(X);

sigma2 = 1/m * sum((X - repmat(mu, m, 1)).^2);

% =============================================================


end