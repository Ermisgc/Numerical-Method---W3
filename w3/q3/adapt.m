function [S, interval] = adapt(f,a,b,to1)
%   这里考虑用递归的写法来操作
%   S是最终的返回值
%   interval是最终返回的区间

S_old = simpson(f,a,b);
S_new1 = simpson(f,a,(a + b)/2);
S_new2 = simpson(f,(a+b)/2,b);

%   递归的基
if(abs(S_new1 + S_new2 - S_old) < 16*to1)
    S = S_new1 + S_new2;
    interval = [a b];
else
    [S1,interval1] = adapt(f,a,(a+b)/2,to1/2);
    [S2,interval2] = adapt(f,(a+b)/2,b,to1/2);
    % 拼接区间：
    interval_length = length(interval1) + length(interval2) - 1;
    interval = zeros(1,interval_length);
    interval(1:length(interval1)) = interval1;
    interval(length(interval1) + 1 : interval_length) = interval2(2:length(interval2));
    % 得到结果
    S = S1 + S2;
end
