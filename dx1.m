function [y] = dx1(x1, x2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
y = x1*(0.5-x1.^2 - x2.^2) + x2;
end

