function imf = Neuritenees3D(alfa,L1,L2,L3)
L1p = L1 + alfa/2.*L2 + alfa/2.*L3;
L2p = L2 + alfa/2.*L1 + alfa/2.*L3;
L3p = L3 + alfa/2.*L1 + alfa/2.*L2;
L1 = L1p;
L2 = L2p;
L3 = L3p;
[L1,~,~] = EigenSort3x3M(L1,L2,L3);
Lmax = max(L1(:));
imf = zeros(size(L1));
imf(L1>0) = L1(L1>0)./Lmax;
end