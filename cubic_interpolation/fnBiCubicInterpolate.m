function [mat_v] = fnBiCubicInterpolate(mat_points, mat_x, mat_y)
%% Based off of code from 
%% 	http://www.paulinternet.nl/?page=bicubic
%%	http://paulbourke.net/miscellaneous/interpolation/

	v_x = reshape(mat_x, size(mat_x,1)*size(mat_x,2),1);
	v_y = reshape(mat_y, size(mat_y,1)*size(mat_y,2),1);

	if(length(v_x) ~= length(v_y))
		error(' Length of x and y vectors not the same ')
	end

	v_v = zeros(length(v_x),1);

	for i_inc = [1:length(v_v)]
		f_x = v_x[i_inc];
		f_y = v_y[i_inc];
		v_arr = zeros(1,4);
		v_arr[0] = fnCubicInterpolate(mat_points[0][:], f_y);
		v_arr[1] = fnCubicInterpolate(mat_points[1][:], f_y);
		v_arr[2] = fnCubicInterpolate(mat_points[2][:], f_y);
		v_arr[3] = fnCubicInterpolate(mat_points[3][:], f_y);
		
		v_v[i_inc] = fnCubicInterpolate(v_arr, f_x);
	end

	mat_v = resize(v_v, size(mat_x,1), size(mat_x,2));

end
