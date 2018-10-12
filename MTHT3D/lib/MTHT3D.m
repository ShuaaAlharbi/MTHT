function [Vmax,Nmax] = MTHT3D(im,s,no,beta,alpha,c,alfa)
%%
TH = zeros(size(im,1),size(im,2),size(im,3),no);
V = zeros(size(im,1),size(im,2),size(im,3),length(s));
N = zeros(size(im,1),size(im,2),size(im,3),length(s));
%% Point distribution on the sphere of unit radius
[p,ps,~] = SurfacesSpiralPoints3D(no);
orients = ps;
for i = 1:length(s)
    for j = 1:length(p)
        fprintf(['Scale: ' num2str(s(i)), '  oriantation: ' num2str(ps(j)) '\n']);
        se = Line3D(s(i),p(j,:),1,1,1); %3D line structuring element 
        TH(:,:,:,j) = im - imopen(im,se); 
    end
    %figure, imshow3D(TH);
    %% Tensor
    T = TensorForOrientedQuadratureFilters3D(TH,orients); 
    %% Eigen Matrix - values and vectors
    [L1,L2,L3] ...
    = EigenMatrix3x3M(T(:,:,:,1),T(:,:,:,2),T(:,:,:,3),...
                        T(:,:,:,4),T(:,:,:,5),T(:,:,:,6),...
                        T(:,:,:,7),T(:,:,:,8),T(:,:,:,9));
    [L1,L2,L3] = EigenSort3x3M(L1,L2,L3); % sort
    %% Vesselness
    imf1 = Vesselness3D(im,beta,alpha,c,L1,L2,L3);
    %% Neuritenees
    imf2 = Neuritenees3D(alfa,L1,L2,L3);
    %% Table of all enhanced image in each scale
    V(:,:,:,i) = imf1;
    N(:,:,:,i) = imf2; 
end
%% Calculate Maximum Image Over the Scales
if length(s)>1
   Vmax = squeeze(max(V,[],4));
   Nmax = squeeze(max(N,[],4));
else
   Vmax = squeeze(V);
   Nmax = squeeze(N);
end
end %End of function