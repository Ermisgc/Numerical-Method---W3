function mesh_grid = modified_forwdif(f_bottom,f_left,f_right,a,b,c,n,m)
%MODIFIED_FORWDIF Modified program 10.2
%   f_bottom the bottom boundary condition
%   f_left   the left boundary condition
%   f_right  the right boundary condition
%   a        the interval of x is [0,a]
%   b        the interval of t is [0,b]
%   c        the parameter of the equation
%   n and m  the number of grid points

%   preprocessor
h = a/(n-1);
k = b/(m-1);
r = (c^2)*k/(h^2);
%   mesh grid
%   noting that I wanna make this metrix correspond to the real rectangle so
%   x = (i-1) * h but y = (m - j) * k.
mesh_grid = zeros(m,n);
mesh_grid(m,:) = feval(f_bottom,linspace(0,a,n));
mesh_grid(:,1) = feval(f_left,linspace(b,0,m)');
mesh_grid(:,n) = feval(f_right,linspace(b,0,m)');


%   Process the inner points.
for j = m - 1:-1:1
    for i = 2:1:n-1
        mesh_grid(j,i) = (1-2*r)*mesh_grid(j+1,i)+r*(mesh_grid(j+1,i-1)+mesh_grid(j+1,i+1));
    end
end

end