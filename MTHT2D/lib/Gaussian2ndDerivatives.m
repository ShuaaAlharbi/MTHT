function [Gxx,Gxy,Gyy] = Gaussian2ndDerivatives(s) 
%% Grid coordinates
[x,y]   = ndgrid(-round(3*s):round(3*s));
%% Gaussian 2nd derivatives
Gxx = 1/(2*pi*s^4) * (x.^2/s^2 - 1) .* exp(-(x.^2 + y.^2)/(2*s^2));
Gxy = 1/(2*pi*s^6) * (x .* y)       .* exp(-(x.^2 + y.^2)/(2*s^2));
Gyy = Gxx';
%% End
end