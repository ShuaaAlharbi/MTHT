function [p,ps,dm] = SurfacesSpiralPoints3D(n)
%% Origin
pn = [1 0 0];
pn = pn/norm(pn);
%% Spiral points
p = sphere_spiralpoints(1,zeros(3,1),n)';
%% which uses longitudes and latitudes to create grids of points, 
% lines, and quadrilaterals over the surface of a sphere in 3D.
% pc(1,1:3) = [ 0.0, 0.0, 0.0 ];
% p = sphere_llq_grid_points(10,pc,11,12,n+4);
%% vornoi 
% which computes the Voronoi diagram of points on the unit sphere
% seed = 123456789;
% [ p, ~ ] = uniform_on_sphere01_map ( 3, n, seed );
% for i = 1 : 50
% 
%     centroid = sphere_cvt_step ( n, p );
% 
%     p(1:3,1:n) = centroid(1:3,1:n);
% end
% p=p';
% figure; 
% scatter3(p(:,1),p(:,2),p(:,3),'MarkerEdgeColor','k','MarkerFaceColor',[0 .75 .75]);  hold on; grid on; box on;ax = gca; ax.BoxStyle = 'full'; axis equal;

%  p = sphere_llq_grid_points ( r, pc, lat_num, long_num, point_num )
%% Angle & Distance
a1 = zeros(size(p,1),size(p,1)); %PxP
a2 = zeros(size(p,1),1);         %Px1
d = zeros(size(p,1),size(p,1));
for i=1:size(p,1)
    for j=1:size(p,1)
        if i~=j
            a1(i,j) = VectorVectorAngle3D(p(i,1),p(i,2),p(i,3),p(j,1),p(j,2),p(j,3));
            d(i,j) = norm(p(i,:)-p(j,:));
        end
    end
    a2(i) = VectorVectorAngle3D(p(i,1),p(i,2),p(i,3),pn(1),pn(2),pn(3));
end
%% Min Distance
dm = [];
for i=1:size(p,1)
    idx = 1:size(p,1);
    idx(i) = [];
    dm(i) = min(d(i,idx));
end
%% Prune half of the points
idx = find(a2>pi/2);
%% Prune 2pi
[xi,yi] = find(a1==pi);
if ~isempty(xi)
    xi(ismember(xi,idx)) = [];
    xi = xi(1:length(xi)/2);
    idx = [idx; xi];
end
%% Prune
ps = p;
ps(idx,:) = [];
dm(idx) = [];
%% End
end