

	v3_point = [0,3,2];

	mat_rotate_Y = fnRotateY(90);
	v_translate = [1,0,1];
	mat_rotate = mat_rotate_Y;
	mat_F = fnFundamental(mat_rotate,v_translate);

	v3_epiLine = mat_F*(v3_point')
	v3_point_new = mat_rotate*v3_point'+v_translate'
	v3_epiLine'*v3_point_new

	fX=-2;
	fY=fnEpiLineY(fX,v3_epiLine);
	display(['[fX,fY,fZ] = [', num2str(fX), ',', num2str(fY), ',1] ']);

	fX=-1;
	fY=fnEpiLineY(fX,v3_epiLine);
	display(['[fX,fY,fZ] = [', num2str(fX), ',', num2str(fY), ',1] ']);

	fX=0;
	fY=fnEpiLineY(fX,v3_epiLine);
	display(['[fX,fY,fZ] = [', num2str(fX), ',', num2str(fY), ',1] ']);

	fX=1;
	fY=fnEpiLineY(fX,v3_epiLine);
	display(['[fX,fY,fZ] = [', num2str(fX), ',', num2str(fY), ',1] ']);

	fX=2;
	fY=fnEpiLineY(fX,v3_epiLine);
	display(['[fX,fY,fZ] = [', num2str(fX), ',', num2str(fY), ',1] ']);









