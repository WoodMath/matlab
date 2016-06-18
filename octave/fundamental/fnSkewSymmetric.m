function [mat_skew] = fnSkewSymmetric(v3)

	mat_skew = [0, -v3(3), v3(2);...
		    v3(3), 0, -v3(1);...
		    -v3(2), v3(1), 0];

end
