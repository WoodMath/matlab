function [mat_v] = fnBiCubicInterpolate(v_points, mat_x, mat_y)
%% Based off of code from 
%% 	http://www.paulinternet.nl/?page=bicubic
%%	http://paulbourke.net/miscellaneous/interpolation/

double bicubicInterpolate (double p[4][4], double x, double y) {
	double arr[4];
	arr[0] = cubicInterpolate(p[0], y);
	arr[1] = cubicInterpolate(p[1], y);
	arr[2] = cubicInterpolate(p[2], y);
	arr[3] = cubicInterpolate(p[3], y);
	return cubicInterpolate(arr, x);
}


	v_x = reshape(mat_x, size(mat_x,1)*size(mat_x,2),1);
	v_y = reshape(mat_y, size(mat_y,1)*size(mat_y,2),2);

	if(length(v_x) ~= length(v_y))
		error(' length of x and y vectors not the same ')
	end

	v_v = zeros(length(v_x),1);
	mat_v = resize(v_v, size(mat_x,1), size(mat_x,2));

end
