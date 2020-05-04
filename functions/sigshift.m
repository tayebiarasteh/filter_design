%Created on June 2016.

%https://github.com/starasteh/
%%
function [y,n] = sigshift(x,m,k)
% Time shifting
% implements y(n) = x(n-k)
% -------------------------
% [y,n] = sigshift(x,m,k)
%
n = m + k; y = x;
