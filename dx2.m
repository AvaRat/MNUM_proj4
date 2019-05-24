function [y] = dx2(x1, x2)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
y = x2*(0.5-x1.^2 - x2.^2) - x1;
end

