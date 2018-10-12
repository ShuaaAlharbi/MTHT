function [L1,L2,V1,V2,V3,V4] = EigenMatrix2x2M(a,b,c,d)
%% Matlab version
L1 = zeros(size(a));
L2 = zeros(size(a));
V1 = zeros(size(a));
V2 = zeros(size(a));
V3 = zeros(size(a));
V4 = zeros(size(a));
for i=1:size(a,1)
    for j=1:size(a,2)
        [V,D] = eig([a(i,j) b(i,j); c(i,j) d(i,j)]);
        L1(i,j) = D(1,1);
        L2(i,j) = D(2,2);
        V1(i,j) = V(1,1);
        V2(i,j) = V(2,1);
        V3(i,j) = V(1,2);
        V4(i,j) = V(2,2);
    end
end
%% End
end