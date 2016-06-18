function [mat_c] = fnUVarr(u,v,mat_arr)
% fnUVarr performs bi-Linear interpolation
%	c is a 1-d point
%	mat_arr is a 3-d array of n-d points

	u_arr = [u 1];
	v_arr = [v 1];
	z_arr = zeros(1,2);
	blend_arr = [-1, 1; 1, 0];
	zero_arr = zeros(2,2);

	mat_u = [u_arr, z_arr; z_arr, u_arr]
	mat_v = [v_arr, z_arr; z_arr, v_arr]
	mat_blend = [ blend_arr, zero_arr; zero_arr, blend_arr]
	mat_arr_use = [mat_arr(:,:,1), zero_arr; zero_arr, mat_arr(:,:,2)]
	mat_c = mat_u*mat_blend*mat_arr_use*mat_blend*mat_v';

end
