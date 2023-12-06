% 对于Natural Cubic Spline，这里的m0 = mn = 0;
% 头部递归公式为：2(h0 + h1)m1 + h1m2 = u1;
% 尾部递归公式为：hn-2 * mn-2 + 2(hn-2 + hn-1) * mn-1 = un-1;

% 对应下标k：
%    0 1 2 3 4 5 6 7 8 9  10 11(n)
t = [1;2;3;4;5;6;7;8;9;10;11;12];
deg = [58;58;58;58;57;57;57;58;60;64;67;68];

h = 1;  % 这里定步长为1

% 求dk = (yk+1 - yk)/h 序列,只用前11个即可
d = (deg(2:12,1) - deg(1:11,1))./h;
% d索引是0 1 2 3 4 5 6 7 8 9 10

% 求uk = dk -dk-1序列，这时只能求出10个：
u = d(2:11,1) - d(1:10,1);
%u的索引是1 2 3 4 5 6 7 8 9 10

% 下面要尝试构造方程HM = V;
% 这里的步长h是固定的，因此比较好求H的系数
% bk = 2 * (hk + hk-1) = 2*(1+1) = 4;
% ak = hk-1 = 1;
% ck = hk = 1
H = zeros(10,10);
H(1,1:2) = [4 1];
H(10,9:10) = [1 4];
for i = 2:9
    H(i,i-1:i+1) = [1 4 1];
end

V = 6 .* u;

% 反解出M矩阵的第2到倒数第二个数：
M = H\V;
m = zeros(12,1);
m(2:11,1) = M;
% m的索引是 0 1 2 3 4 5 6 7 8 9 10 11

% 下一步根据m求出11段三次样条曲线的系数：
% 每一个段曲线的系数占用一行，总共11行
S = zeros(11,4);

% 第一个系数就是函数值
S(:,1) = deg(1:11);

% 第二个系数：dk - hk(2*mk + mk+1)/6
S(:,2) = d - (2*m(1:11) + m(2:12))/6;

% 第三个系数：mk/2
S(:,3) = m(1:11)./2;

% 第四个系数：(mk+1 - mk)/6hk
S(:,4) = (m(2:12) - m(1:11))/6;

% 至此，第一问结束



% 第二问就是画图：
% 首先画出数据的散点图：
scatter(t,deg,36,'black','filled');
xlabel("hours");
ylabel("temperature(F)");
title("cubic natural spline");
hold on

% 对每一段设置具体的区间和曲线
for i = 1:11
    x = linspace(t(i,1),t(i+1,1),100);
    plot(x,S(i,1) + S(i,2)*(x-t(i,1)) + S(i,3)*power((x-t(i,1)),2) + S(i,4)*power((x-t(i,1)),3),'LineWidth',1.2);
end
% 至此，第二问结束



% 第三问应该就是求积分公式然后除以区间长度
% Exercise12 得到的求积公式是：int(Sk(x),xk->xk+1) = sk0 * h + sk1 * h^2/2 + sk2 *
% h^3/3 + sk3 * h^4/4;
integral_matrix = zeros(11,4);
integral_matrix(:,1) = S(:,1) * 1;
integral_matrix(:,2) = S(:,2) * 1/2;
integral_matrix(:,3) = S(:,3) * 1/3;
integral_matrix(:,4) = S(:,4) * 1/4;

integral = sum(sum(integral_matrix));
aver = integral/11;
% 可以看到温度的平均值为60，而我们的积分公式结果是59.7231，差别不大