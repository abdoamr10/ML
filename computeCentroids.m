function centroids = computeCentroids(X, idx, K)

[m n] = size(X);
centroids = zeros(K, n);

for k=1:K % for-loop over the centroids 
   centroids(k, :) = mean(X(idx==k, :));
end

end
