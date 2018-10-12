function T = TensorForOrientedQuadratureFilters3D(qi,angles)
%%  BOTensor - calculate 3D tensor of the image
%   
%   REFERENCE:
%       Hans Knutsson, 
%       Representing local structure using tensors, 
%       The 6th Scandinavian Conference on Image Analysis, Oulu, Finland, 
%       244�251, June 1989
%
%   INPUT:
%       qi - 3D image (response of quadrature filter in each orientation)
%       angles - vector of angles
%
%   OUTPUT:
%       T  - 3D tensor
%
%   HELP:
%       T = SUMi(|qi|(nini' - alphaI) 
%       where: 
%           qi - response of i-th quadrature filter in the spatial domain
%           alpha = 1/(m-1), m - dimensionality of T (2D -> m=4; 3D -> m=6)
%    
%
%   USAGE:
%       T = TensorForOrientedQuadratureFilters3D(qi,angles)
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 16/07/2012 First implementation

%% Tensor
T = zeros(size(qi,1),size(qi,2),size(qi,3),9);
for i=1:size(angles,1)
   nnT = kron(angles(i,:),angles(i,:)');
   %nnTI = (nnT-1/(4-1).*I); %alpha = 1/(m-1) where m = size of T
   %nnTI = (nnT-(1/(2-1)).*I); %alpha = 1/(m-1) where m = dimensionality of T    
   %nnTI = (nnT-(1/(length(ang)-1)).*I); %alpha = 1/(m-1) where m = nr of filters
   %nnTI = (nnT-(1/(2+1)).*I); %alpha = 1/(m+1) where m = dimensionality of T (A FRAMEWORK FOR ESTIMATION OF ORIENTATION AND VELOCITY)     
   
   nnTI = nnT;
   T(:,:,:,1) = T(:,:,:,1) + qi(:,:,:,i)*nnTI(1,1);
   T(:,:,:,2) = T(:,:,:,2) + qi(:,:,:,i)*nnTI(1,2);
   T(:,:,:,3) = T(:,:,:,3) + qi(:,:,:,i)*nnTI(1,3);
   
   T(:,:,:,4) = T(:,:,:,4) + qi(:,:,:,i)*nnTI(2,1);
   T(:,:,:,5) = T(:,:,:,5) + qi(:,:,:,i)*nnTI(2,2);
   T(:,:,:,6) = T(:,:,:,6) + qi(:,:,:,i)*nnTI(2,3);
   
   T(:,:,:,7) = T(:,:,:,7) + qi(:,:,:,i)*nnTI(3,1);
   T(:,:,:,8) = T(:,:,:,8) + qi(:,:,:,i)*nnTI(3,2);
   T(:,:,:,9) = T(:,:,:,9) + qi(:,:,:,i)*nnTI(3,3);    
end
%% 
end