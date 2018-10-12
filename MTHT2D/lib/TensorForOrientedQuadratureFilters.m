function T = TensorForOrientedQuadratureFilters(qi,angles)
%%  BOTensor - calculate 2D tensor
%   
%   REFERENCE:
%       Hans Knutsson, 
%       Representing local structure using tensors, 
%       The 6th Scandinavian Conference on Image Analysis, Oulu, Finland, 
%       June 1989
%
%   INPUT:
%       qi - 3D image (response of quadrature filter in each orientation)
%       angles - vector of angles
%
%   OUTPUT:
%       T  - 2D tensor
%
%   HELP:
%       T = SUMi(|qi|(nini' - I) 
%       where: 
%           qi - response of i-th quadrature filter in the spatial domain
%
%   USAGE:
%       T = TensorForOrientedQuadratureFilters(qi,angles)
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 07/12/2009 First implementation

%% Orientation vectors
angles = angles';
n = [cos(angles) sin(angles)];

%% Tensor
T = zeros(size(qi,1),size(qi,2),4);
for i=1:length(angles)
    nnT = kron(n(i,:),n(i,:)');
    %nnTI = (nnT-1/(4-1).*I); %alpha = 1/(m-1) where m = size of T
    %nnTI = (nnT-(1/(2-1)).*I); %alpha = 1/(m-1) where m = dimensionality of T    
    %nnTI = (nnT-(1/(length(ang)-1)).*I); %alpha = 1/(m-1) where m = nr of filters
    %nnTI = (nnT-(1/(2+1)).*I); %alpha = 1/(m+1) where m = dimensionality of T (A FRAMEWORK FOR ESTIMATION OF ORIENTATION AND VELOCITY)     
    nnTI =nnT;
    T(:,:,1) = T(:,:,1) + qi(:,:,i)*nnTI(1,1);
    T(:,:,2) = T(:,:,2) + qi(:,:,i)*nnTI(1,2);
    T(:,:,3) = T(:,:,3) + qi(:,:,i)*nnTI(2,1);
    T(:,:,4) = T(:,:,4) + qi(:,:,i)*nnTI(2,2);
end
%% 
end