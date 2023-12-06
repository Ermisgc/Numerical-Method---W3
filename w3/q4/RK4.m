function y = RK4(f,x0,xmax,h,y0)
%RK4 N = 4的Runge-Kutta方法
%   迭代公式为：
%   yk+1 = yk + h(f1 + 2f2 + 2f3 + f4)/6

cnt = (xmax - x0)/h + 1;
y = zeros(1,cnt);
y(1,1) = y0;

for i = 1:1:cnt-1
    xk = x0 + (i-1) * h;
    f1 = feval(f, xk, y(1,i));
    f2 = feval(f, xk + 0.5 * h, y(i) + 0.5 * h * f1);
    f3 = feval(f, xk + 0.5 * h, y(i) + 0.5 * h * f2);
    f4 = feval(f, xk + h, y(i) + h * f3);
    y(1,i+1) = y(1,i) + h * (f1 + 2*f2 + 2*f3 +f4)/6;
end

end