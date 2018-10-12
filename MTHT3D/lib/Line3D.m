function sel = Line3D(s,o,rx,ry,rz)  
%% BOLine3D - 3D line
%
%   INPUT:
%       s        - size
%       o        - orientation, unit vertor [1 0 0] 
%       rx,ry,rz - resolution in x, y and z
%
%   OUTPUT:
%       sej      - 3d line
%
%   AUTHOR:
%       Boguslaw Obara, http://boguslawobara.net/
%
%   VERSION:
%       0.1 - 28/02/2017 First implementation
%% Round 
sx = round(s*rx);
sy = round(s*ry);
sz = round(s*rz);
%% Mesh
[xg,yg,zg] = meshgrid(-sx:sx,-sy:sy,-sz:sz);
%% Ellipsoid
se = ( (xg/sx).^2 + (yg/sy).^2 + (zg/sz).^2 ) <= 1;
%% Normal Vector
p1 = [sx sy sz] .* o;
p2 = [sx sy sz] .* -o;
d1 = sqrt((p1(1)-xg).^2 + (p1(2)-yg).^2 + (p1(3)-zg).^2);
d2 = sqrt((p2(1)-xg).^2 + (p2(2)-yg).^2 + (p2(3)-zg).^2);
d1(~se) = inf;
d2(~se) = inf;
m1 = min(d1(:));
m2 = min(d2(:));
idx = find(se);
idx1 = find(d1==m1);
idx2 = find(d2==m2);
if ~ismember(idx1,idx) || ~ismember(idx2,idx) 
    error('not a member!!!');
end
x0 = sx + 1; y0 = sy + 1; z0 = sz + 1; 
[x1,y1,z1] = ind2sub(size(se),idx1);
[x2,y2,z2] = ind2sub(size(se),idx2);
%% Line
[cx1,cy1,cz1] = DrawLine3D(x0,y0,z0,x1,y1,z1);
[cx2,cy2,cz2] = DrawLine3D(x0,y0,z0,x2,y2,z2);
sel = zeros(size(se))==1; 
sel(sub2ind(size(se),cx1,cy1,cz1)) = 1;
sel(sub2ind(size(se),cx2,cy2,cz2)) = 1;
end