%Created on June 2016.

%https://github.com/starasteh/
%%
function [xe, xo, m] = conjsymetricanti(x,n)
% Real signal decomposition into even and odd parts
% -------------------------------------------------
% [xe, xo, m] = evenodd(x,n)
%

m  = -fliplr(n);
m1 = min([m,n]); m2 = max([m,n]); m = m1:m2;
nm = n(1)-m(1); n1 = 1:length(n);
x1 = zeros(1,length(m)); x1(n1+nm) = x;
x  = x1;
a=fliplr(x);
xe = 0.5*(x + conj(a)); xo = 0.5*(x - conj(a));
