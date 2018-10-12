function N = Neuritenees2D(alfa,L1,L2)
%%
L1t = L1;
L2t = L2;
L1 = L1t + alfa*L2t;
L2 = L2t + alfa*L1t;
% Sort L1s > L2s
index = abs(L1)<abs(L2);
L1s = L1; 
L1s(index) = L2(index);
%Compute Filtered Image
Lmax = max(L1s(:));
N = zeros(size(L1));
N(L1s>0) = L1s(L1s>0)./Lmax;
end