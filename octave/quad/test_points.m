

	mat_x = [2.5, 9.5; 0.5, 4.5];
	mat_y = [0.5, 2.5; 8.5, 9.5];

	mat_pass = cat(3,mat_x,mat_y);

	%%%%%%%%%%

	u = 1.00;
	v = 0.50;

	x_uv = fnUVpoints(u,v,mat_x);
	y_uv = fnUVpoints(u,v,mat_y);

	[x_uv, y_uv]

	mat_uv = fnUVarr(u,v,mat_pass);

	[mat_uv]
	
