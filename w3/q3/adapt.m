function [S, interval] = adapt(f,a,b,to1)
%   ���￼���õݹ��д��������
%   S�����յķ���ֵ
%   interval�����շ��ص�����

S_old = simpson(f,a,b);
S_new1 = simpson(f,a,(a + b)/2);
S_new2 = simpson(f,(a+b)/2,b);

%   �ݹ�Ļ�
if(abs(S_new1 + S_new2 - S_old) < 16*to1)
    S = S_new1 + S_new2;
    interval = [a b];
else
    [S1,interval1] = adapt(f,a,(a+b)/2,to1/2);
    [S2,interval2] = adapt(f,(a+b)/2,b,to1/2);
    % ƴ�����䣺
    interval_length = length(interval1) + length(interval2) - 1;
    interval = zeros(1,interval_length);
    interval(1:length(interval1)) = interval1;
    interval(length(interval1) + 1 : interval_length) = interval2(2:length(interval2));
    % �õ����
    S = S1 + S2;
end
