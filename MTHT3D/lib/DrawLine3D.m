function [Cx,Cy,Cz] = DrawLine3D(x0,y0,z0,x1,y1,z1)
%% HELP
%https://en.wikipedia.org/wiki/Bresenham's_line_algorithm

%% Init
Cx = [];
Cy = [];
Cz = [];

%% 'steep' xy Line, make longest delta x plane  
swap_xy = abs(y1 - y0) > abs(x1 - x0);
if swap_xy
    [x0,y0] = Swap(x0,y0);
    [x1,y1] = Swap(x1,y1);
end

%% do same for xz
swap_xz = abs(z1 - z0) > abs(x1 - x0);
if swap_xz
    [x0,z0] = Swap(x0,z0);
    [x1,z1] = Swap(x1,z1);
end

%% delta is Length in each plane
delta_x = abs(x1 - x0);
delta_y = abs(y1 - y0);
delta_z = abs(z1 - z0);

%% drift controls when to step in 'shallow' planes
%% starting value keeps Line centred
drift_xy = (delta_x / 2);
drift_xz = (delta_x / 2);

%% direction of line
step_x = 1;  if (x0 > x1); step_x = -1; end
step_y = 1;  if (y0 > y1); step_y = -1; end
step_z = 1;  if (z0 > z1); step_z = -1; end

%% starting point
y = y0;
z = z0;

%% step through longest delta (which we have swapped to x)
for x = x0:step_x:x1
    %% copy position
    cx = x;    cy = y;    cz = z;

    %% unswap (in reverse)
    if swap_xz; [cx,cz] = Swap(cx,cz); end
    if swap_xy; [cx,cy] = Swap(cx,cy); end

    %% passes through this point
    % debugmsg(":" + cx + ", " + cy + ", " + cz)
    Cx = [Cx; cx];
    Cy = [Cy; cy];
    Cz = [Cz; cz];

    %% update progress in other planes
    drift_xy = drift_xy - delta_y;
    drift_xz = drift_xz - delta_z;

    %% step in y plane
    if drift_xy < 0 
        y = y + step_y;
        drift_xy = drift_xy + delta_x;
    end
    
    %% same in z
    if drift_xz < 0 
        z = z + step_z;
        drift_xz = drift_xz + delta_x;
    end
end
%% End
end

function [a,b] = Swap(a,b)
c = a;
a = b;
b = c;
end