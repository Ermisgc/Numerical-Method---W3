%Bottom_boundary function and left_boundary function are the same;
%Top_boundary function and right_boundary function are alse the same;
U = mydirich("bottom_boundary","top_boundary","bottom_boundary","top_boundary",1.5,1.5,0.5,1e-5,100);
[X,Y] = meshgrid(0:0.5:1.5,1.5:-0.5:0);

subplot(2,2,1);
surf(X,Y,U);
xlabel("x");
ylabel("y");
title("surf of the approximation result");
colorbar

% comparison
subplot(2,2,2);
Exact = zeros(4,4);
for i = 1:1:4
    for j = 1:1:4
        Exact(j,i) = power(X(1,i),4) - 6*power(X(1,i),2)*power(Y(j,1),2) + power(Y(j,1),4);
    end
end
surf(X,Y,Exact);
xlabel("x");
ylabel("y");
title("surf of the exact solution");
colorbar

Error = U - Exact;
subplot(2,2,3);
surf(X,Y,Error);
xlabel("x");
ylabel("y");
title("surf of the errors");
colorbar

subplot(2,2,4);
contour(X,Y,Error,'ShowText','on');
xlabel("x");
ylabel("y");
title("contour of the error");


