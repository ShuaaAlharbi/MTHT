function [Gxx,Gyy,Gzz,Gxy,Gxz,Gyz] = Gaussian2ndDerivatives3D(s) 
%%
if length(s)==1; s = s*ones(1,3); end
%% Grid coordinates
k = 3;
[x,y,z] = ndgrid(-round(k*s(1)):round(k*s(1)),-round(k*s(2)):round(k*s(2)),-round(k*s(3)):round(k*s(3)));
%% Gaussian 2nd derivatives
A = -(1/(((2*pi)^(3/2))*s(1)*s(2)*s(3)));
B = exp( -x.^2/(2*s(1)^2) -y.^2/(2*s(2)^2) -z.^2/(2*s(3)^2) );
Gxx =  A .* (x.^2/s(1)^4 - 1/s(1)^2) .* B;
Gyy =  A .* (y.^2/s(2)^4 - 1/s(2)^2) .* B;
Gzz =  A .* (z.^2/s(3)^4 - 1/s(3)^2) .* B;  
Gxy =  A .* (x.*y)/(s(1)^2.*s(2)^2) .* B;
Gxz =  A .* (x.*z)/(s(1)^2.*s(3)^2) .* B;
Gyz =  A .* (y.*z)/(s(2)^2.*s(3)^2) .* B;
end