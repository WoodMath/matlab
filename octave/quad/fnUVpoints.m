function [c] = fnUVpoints(u,v,mat_arr)
% fnUVpoints performs bi-Linear interpolation
%	c is a 1-d point
%	mat_arr is a 2-d array of 1-d points

	c = [u 1]*[-1, 1; 1, 0]*mat_arr*[-1, 1; 1, 0]*[v; 1];

end
