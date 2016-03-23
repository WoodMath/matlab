function [mat_v] = fnBiCubicInterpolate(mat_points, mat_xy)
%% Based off of code from 
%% 	http://www.paulinternet.nl/?page=bicubic
%%	http://paulbourke.net/miscellaneous/interpolation/


	if(size(mat_xy,2) ~= 2)
		error(' Need two column matrix of points to interpolate ');
	end

	v_x = mat_xy(:,1);
	v_y = mat_xy(:,2);

	v_v = zeros(length(v_x),1);

	for i_inc = [1:length(v_v)]
		f_x = v_x(i_inc);
		f_y = v_y(i_inc);
		v_arr = zeros(4,1);
		v_arr(0) = fnCubicInterpolate(permute(mat_points(0,:), [2,1]), f_y);
		v_arr(1) = fnCubicInterpolate(permute(mat_points(1,:), [2,1]), f_y);
		v_arr(2) = fnCubicInterpolate(permute(mat_points(2,:), [2,1]), f_y);
		v_arr(3) = fnCubicInterpolate(permute(mat_points(3,:), [2,1]), f_y);
		
		v_v(i_inc) = fnCubicInterpolate(v_arr, f_x);
	end

	mat_v = reshape(v_v, size(mat_x,1), size(mat_x,2));

end
