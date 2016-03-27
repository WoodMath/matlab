function [ ] = fnPlotBasis( mat_basis )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    hFigure = figure();
    aAxis = axes('Parent', hFigure);
    hold on;

    v_red = mat_basis(:,1);
    v_green = mat_basis(:,2);
    v_blue = mat_basis(:,3);
    
    v_zero = [0,0,0];
    
    v_basis = reshape(mat_basis,size(mat_basis,1)*size(mat_basis,2),1);
    f_max_abs_basis = max(abs(v_basis));
    f_extend = 2.0;

    v_x = [1,0,0]*f_max_abs_basis*f_extend; 
    v_y = [0,1,0]*f_max_abs_basis*f_extend; 
    v_z = [0,0,1]*f_max_abs_basis*f_extend;
    
    mat_x = vertcat(v_zero,v_x);
    mat_y = vertcat(v_zero,v_y);
    mat_z = vertcat(v_zero,v_z);
    
    
    
    mat_red = vertcat(zeros(1,length(v_red)),v_red');
    mat_green = vertcat(zeros(1,length(v_green)),v_green');
    mat_blue = vertcat(zeros(1,length(v_blue)),v_blue');
    
    plot3(mat_red(:,1),mat_red(:,2),mat_red(:,3),'Color','Red','LineWidth',2.5);
    plot3(mat_green(:,1),mat_green(:,2),mat_green(:,3),'Color','Green','LineWidth',2.5);
    plot3(mat_blue(:,1),mat_blue(:,2),mat_blue(:,3),'Color','Blue','LineWidth',2.5);

    plot3(mat_x(:,1),mat_x(:,2),mat_x(:,3),'Color','Black','LineWidth',1.0);
    plot3(mat_y(:,1),mat_y(:,2),mat_y(:,3),'Color','Black','LineWidth',1.0);
    plot3(mat_z(:,1),mat_z(:,2),mat_z(:,3),'Color','Black','LineWidth',1.0);

    
    box(aAxis, 'on');
    grid(aAxis, 'on');
    hold(aAxis, 'all');

end

