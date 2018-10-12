function  V = Vesselness3D(im,beta,alpha,c,L1,L2,L3)
%%  Vesselness  
wb = false;
%L1(L1==0) = eps;
%L2(L2==0) = eps;
%Ralpha = abs(L2)./abs(L1);             % 1 -> plate;   0 -> line
%Rbeta = abs(L3)./sqrt(abs(L1.*L2));    % 1 -> blob;    0 -> line
Ralpha = abs(L2)./abs(L3);              % 1 -> plate;   0 -> line
Rbeta = abs(L1)./sqrt(abs(L2.*L3));     % 1 -> blob;    0 -> line
Ralpha(isnan(Ralpha)) = 0;
Rbeta(isnan(Rbeta)) = 0;
S = sqrt(L1.^2 + L2.^2 + L3.^2);     
V =  ( ones(size(im,1),size(im,2),size(im,3)) - exp(-(Ralpha.^2)/(2*alpha^2)) ) .*...
        exp(-(Rbeta.^2)/(2*beta^2)).*...
        ( ones(size(im,1),size(im,2),size(im,3)) - exp(-(S.^2)/(2*c^2)) );
%% TODO     half the value of the maximum Hessian norm has proven to work
%% If |lambda2 > 0| or |lambda2 < 0|  => Vo = 0
    if(wb)
        mask = L1>=0 | L2>=0 | L3>=0;
        V(mask) = 0;      
    else
        mask = L1<=0 | L2<=0 | L3<=0;
        V(mask) = 0;     
    end
    V = Normalize(V);
end  