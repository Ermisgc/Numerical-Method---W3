format long

% ��һ����Central-Difference Formulas���㣬�ܼ�
df = zeros(3,1);

df(1,1) = (1.13140 - 1.06471)/(2*0.1);
df(2,1) = (1.10194 - 1.09527)/(2*0.01);
df(3,1) = (1.09895 - 1.09828)/(2*0.001);

% �ڶ��������
error = df - 1/3;  
% ����һ�ʹ۲쵽����������

% �������������
h = [0.1;0.01;0.001];
emax = 0.000005;
bound = emax./h + power(h,2)./(3*power(3-h,3));


