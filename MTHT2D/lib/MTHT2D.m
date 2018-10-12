function [Vmax,Nmax] = MTHT2D(im,o,s,no,beta,c,alfa)
%%
angles = ((1:no)-1)*pi/no;
TH = zeros(size(im,1),size(im,2),length(o));
V = zeros(size(im,1),size(im,2),length(s));
N = zeros(size(im,1),size(im,2),length(s));
for i=1:length(s)
    for j=1:length(o)
        fprintf(['Scale: ' num2str(s(i)), '  orientation: ' num2str(o(j)) '\n']);
        se = strel('line',s(i),o(j)); %line structuring element 
        TH(:,:,j) = im - imopen(im,se); %top-hat images
        %figure; imagesc(TH(:,:,j)); title(['Scale: ' num2str(s(i)), '  orientation: ' num2str(o(j))]); colormap jet; axis off; axis equal; axis tight;
        %autoArrangeFigures
    end
    %% Tensor
    T = TensorForOrientedQuadratureFilters(TH,angles); 
    %% Eigen Matrix - values and vectors
    [L1,L2] = EigenMatrix2x2M(T(:,:,1),T(:,:,2),T(:,:,3),T(:,:,4));
    %% Vesselness
    imf1 = Vesselness2D(im,beta,c,L1,L2);
    %% Neuritenees
    imf2 = Neuritenees2D(alfa,L1,L2);
    %% Table of all enhanced image in each scale
    V(:,:,i) = imf1;
    N(:,:,i) = imf2; 
end
%% Calculate Maximum Image Over the Scales
if length(s)>1
   Vmax = max(V,[],3);
   Nmax = max(N,[],3);
else
   Vmax = V;
   Nmax = N;
end
end %End of function