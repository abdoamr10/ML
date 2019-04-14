function idx = findClosestCentroids(X, centroids)

K = size(centroids, 1);
idx = zeros(size(X,1), 1);
m = size(X,1);

for i = 1:m
    distance_array = zeros(1,K);
    for j = 1:K
        distance_array(1,j) = sqrt(sum(power((X(i,:)-centroids(j,:)),2)));
    end
    [~, d_idx] = min(distance_array);
    idx(i,1) = d_idx;
end

end