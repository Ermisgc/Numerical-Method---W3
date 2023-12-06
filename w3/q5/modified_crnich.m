function mesh_grid = modified_crnich(f_bottom,f_left,f_right,a,b,c,n,m)
%MODIFIED_CRNICH modified Program 10.3
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


for j = m - 1:-1:1
%   generate the linear system AX = B for every j:
%  -r     2+2r    -r
%          |
%  r      2-2r    r 
    A = zeros(n-2,n-2);
    A(1,1:2) = [2+2*r -r];
    A(n-2,n-3:n-2) = [-r 2+2*r];
    for i = 2:1:n-3
        A(i,i-1:i+1) = [-r 2+2*r -r];
    end

    B = zeros(n-2,1);
    B(1,1) = (2 - 2*r)*mesh_grid(j+1,2) + r*(mesh_grid(j+1,1)+mesh_grid(j+1,3)) + mesh_grid(j,1);
    B(n-2,1) = (2 - 2*r)*mesh_grid(j+1,n-1) + r*(mesh_grid(j+1,n-2)+mesh_grid(j+1,n)) + mesh_grid(j,n);
    for i = 2:1:n-3
        B(i,1) = (2 - 2*r)*mesh_grid(j+1,i+1) + r*(mesh_grid(j+1,i)+mesh_grid(j+1,i+2));
    end

    X = A\B;
    mesh_grid(j,2:n-1) = X';
end


end