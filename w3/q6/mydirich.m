function U = mydirich(f_bottom,f_top,f_left,f_right,a,b,h,to1,max)
%MYDIRICH Dirichlet Mathod by myself
%   f-b/t/l/r   boundary functions.
%   a           the interval of x is [0,a];
%   b           the interval of y is [0,b];
%   h           step size
%   to1         target tolerance
%   max         the maximum iterating times.

n = a/h + 1;
m = b/h + 1;
aver = (a*(feval(f_bottom,0)+feval(f_top,0)) + b*(feval(f_left,0)+feval(f_right,0)))/(2*a+2*b);
U = aver * ones(m,n);
% noting that I make sure it is a normal rectangle
U(m,:) = feval(f_bottom, linspace(0,a,n));
U(1,:) = feval(f_top, linspace(0,a,n));
U(:,1) = feval(f_left, linspace(b,0,m)');
U(:,n) = feval(f_right, linspace(b,0,m)');

w = 4/(2+sqrt(4 - power(cos(pi/(n-1))+cos(pi/m-1),2)));
iter = 0;
err = 1.1 * to1;

while(err>to1 && iter < max)
    % compute residual
    for j = m-1:-1:2
        for i = 2:1:n-1
            residual = w*(U(j,i+1) + U(j,i-1) + U(j+1,i) + U(j-1,i) - 4*U(j,i))/4;
            err = residual;
            U(j,i) = U(j,i) + residual;
        end
    end
    iter = iter + 1;
end

end

