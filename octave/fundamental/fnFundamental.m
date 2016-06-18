function [mat_fundamental] = fnFundamental(mat_rot, v_trans)

	mat_trans = fnSkewSymmetric(v_trans);
	mat_fundamental = mat_trans*mat_rot;
end
