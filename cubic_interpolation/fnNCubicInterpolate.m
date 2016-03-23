function [v_v] = fnNCubicInterpolate(i_n, mat_points, mat_n)
%% Based off of code from 
%% 	http://www.paulinternet.nl/?page=bicubic
%%	http://paulbourke.net/miscellaneous/interpolation/

	if(size(mat_n,2) ~= n)
		error(' Need matrix of points to interpolate to have same number of columns as supplied n');
	end



	v_v = zeros(size(mat_n,1),1);

	for i_inc = [1:length(v_v)]
		v_n = mat_n(i_inc,:);
        i_n_to_pass = i_n - 1;
        v_n_to_pass = v_n(2:length(v_n));
        dim_mat_to_pass = [1:i_n_to_pass]*0+4;
		v_arr = zeros(4,1);
		v_arr(0) = fnBiCubicInterpolate(i_n_to_pass, reshape(mat_points(0,:), dim_mat_to_pass), v_n_to_pass);
		v_arr(1) = fnBiCubicInterpolate(i_n_to_pass, reshape(mat_points(1,:), dim_mat_to_pass), v_n_to_pass);
		v_arr(2) = fnBiCubicInterpolate(i_n_to_pass, reshape(mat_points(2,:), dim_mat_to_pass), v_n_to_pass);
		v_arr(3) = fnBiCubicInterpolate(i_n_to_pass, reshape(mat_points(3,:), dim_mat_to_pass), v_n_to_pass);
		
		v_v(i_inc) = fnCubicInterpolate(v_arr, v_n(1));
    end

end