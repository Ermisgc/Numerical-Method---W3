function S = simpson(f,a,b)
%SIMPSON 
h = (b - a)/2;
c = (a + b)/2;

sk = zeros(1,3);
sk(1) = feval(f,a);
sk(2) = feval(f,c);
sk(3) = feval(f,b);
S = h * (sk(1) + 4 * sk(2) + sk(3))/3;

end