%(a) modified programs are modified_forwdif and modified_crnich
%(b) use modified programs to solve the heat equations
% h = 0.1; k = 0.01; r = 1; x [0,1] t [0 0.1]
n = 1/0.1+1;
m = 0.1/0.01+1;
c = sqrt(1 * 0.1 * 0.1/0.01);
U1_f = modified_forwdif("funq5_1","left_boundary","right_boundary",1,0.1,c,n,m);
U1_c = modified_crnich("funq5_1","left_boundary","right_boundary",1,0.1,c,n,m);

U2_f = modified_forwdif("funq5_2","left_boundary","right_boundary",1,0.1,c,n,m);
U2_c = modified_crnich("funq5_2","left_boundary","right_boundary",1,0.1,c,n,m);

%(c) use surf and contour to plot the result
[X,Y] = meshgrid(0:0.1:1,0.1:-0.01:0);
subplot(2,2,1);
surf(X,Y,U1_c);
colorbar
xlabel("x");
ylabel("t");
title("surf when f(x) = sin(pi*x + 2pi*x)")

subplot(2,2,2);
contour(X,Y,U1_c,'ShowText','on');
xlabel("x");
ylabel("t");
title("contour when f(x) = sin(pi*x + 2pi*x)")

subplot(2,2,3);
surf(X,Y,U2_c);
colorbar
xlabel("x");
ylabel("t");
title("surf when f(x) = 3-|3x-1|-|3x-2|")

subplot(2,2,4);
contour(X,Y,U2_c,'ShowText','on');
xlabel("x");
ylabel("t");
title("contour when y = 3-|3x-1|-|3x-2|")