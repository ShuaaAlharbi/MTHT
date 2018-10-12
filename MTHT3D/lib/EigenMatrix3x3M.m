function [L1,L2,L3,V1,V2,V3,V4,V5,V6,V7,V8,V9] ...
    = EigenMatrix3x3M(x1,x2,x3,x4,x5,x6,x7,x8,x9)
%% Matlab version
L1 = zeros(size(x1));
L2 = zeros(size(x1));
L3 = zeros(size(x1));
V1 = zeros(size(x1));
V2 = zeros(size(x1));
V3 = zeros(size(x1));
V4 = zeros(size(x1));
V5 = zeros(size(x1));
V6 = zeros(size(x1));
V7 = zeros(size(x1));
V8 = zeros(size(x1));
V9 = zeros(size(x1));
for i=1:size(x1,1)
    for j=1:size(x1,2)
        for k=1:size(x1,3)
            [V,D] = eig([x1(i,j,k) x2(i,j,k) x3(i,j,k); x4(i,j,k) x5(i,j,k) x6(i,j,k); x7(i,j,k) x8(i,j,k) x9(i,j,k)]);
            L1(i,j,k) = D(1,1);
            L2(i,j,k) = D(2,2);
            L3(i,j,k) = D(3,3);            
            V1(i,j,k) = V(1,1);
            V2(i,j,k) = V(2,1);
            V3(i,j,k) = V(3,1);
            V4(i,j,k) = V(1,2);
            V5(i,j,k) = V(2,2);
            V6(i,j,k) = V(3,2);
            V7(i,j,k) = V(1,3);
            V8(i,j,k) = V(2,3);
            V9(i,j,k) = V(3,3);
        end
    end
end
%% End
end