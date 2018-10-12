function  V = Vesselness2D(im,beta,c,L1,L2)
%% 
index = abs(L1)>abs(L2); 
L1s = L1; 
L2s = L2;
L1s(index) = L2(index);
L2s(index) = L1(index);
L1 = L1s;
L2 = L2s;
L2(L2==0) = eps;
%Compute Filtered Image    
Rbeta = L1./L2;
S = sqrt(L1.^2 + L2.^2);     
V = exp(-(Rbeta.^2)/(2*beta^2)).*(ones(size(im))-exp(-(S.^2)/(2*c^2))); 
V = Normalize(V);
end