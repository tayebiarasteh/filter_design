%Created on June 2016.

%https://github.com/starasteh/
%%
function [y,n] = sigfold(x,n)
% Time reversal
% implements y(n) = x(-n)
% -----------------------
% [y,n] = sigfold(x,n)
%
y = fliplr(x); n = -fliplr(n);
