img_blackboard = imread('blackboard_before.png');
imshow(img_blackboard);
hold on


v2_in_orig = [100, 0; 0, 0; 0, 100; 100, 100];
v2_out_orig = [197, 110; 18, 119; 56, 195; 160, 192];

v2_in = transpose(v2_in_orig);
v2_out = transpose(v2_out_orig);






v3_in = vertcat(v2_in,ones(1,size(v2_in,2)));
v3_out = vertcat(v2_out,ones(1,size(v2_out,2)));
mat_trans = v3_out*transpose(v3_in)*inv(v3_in*transpose(v3_in));

v3_in_verify = inv(mat_trans)*v3_out;
v3_out_verify = mat_trans*v3_in;


% % v3_in_plot_x = transpose(v3_in(2,:));
% % v3_in_plot_y = transpose(v3_in(1,:));
% % 
% % v3_out_plot_x = transpose(v3_out(2,:));
% % v3_out_plot_y = transpose(v3_out(1,:));
% % 
% % v3_in_verify_plot_x = transpose(v3_in_verify(2,:));
% % v3_in_verify_plot_y = transpose(v3_in_verify(1,:));
% % 
% % v3_out_verify_plot_x = transpose(v3_out_verify(2,:));
% % v3_out_verify_plot_y = transpose(v3_out_verify(1,:));

v3_in_plot_x = transpose([v3_in(2,:),v3_in(2,1)]);
v3_in_plot_y = transpose([v3_in(1,:),v3_in(1,1)]);

v3_out_plot_x = transpose([v3_out(2,:),v3_out(2,1)]);
v3_out_plot_y = transpose([v3_out(1,:),v3_out(1,1)]);

v3_in_verify_plot_x = transpose([v3_in_verify(2,:),v3_in_verify(2,1)]);
v3_in_verify_plot_y = transpose([v3_in_verify(1,:),v3_in_verify(1,1)]);

v3_out_verify_plot_x = transpose([v3_out_verify(2,:),v3_out_verify(2,1)]);
v3_out_verify_plot_y = transpose([v3_out_verify(1,:),v3_out_verify(1,1)]);

% % http://www.csi.ucd.ie/staff/hcarr/home/teaching/comp3003/slides/09_perspective.pdf
% % http://en.wikipedia.org/wiki/3D_projection#Perspective_projection
% % http://en.wikipedia.org/wiki/Transformation_matrix
% % http://en.wikipedia.org/wiki/Camera_matrix
% % http://en.wikipedia.org/wiki/Cross-ratio
% % http://en.wikipedia.org/wiki/Perspectivity#Perspective_collineations
% % http://en.wikipedia.org/wiki/Projective_coordinates

T = maketform('projective',v2_in_orig,v2_out_orig);
T_trans = transpose(T.tdata.T);
v3_test_new = T_trans*v3_in;
%% Make homogeneous
v3_test_compare = v3_test_new./repmat(v3_test_new(3,:),size(v3_test_new,1),1);
%% The Documentation version
% % 
% % Note:   An affine or projective transformation can also be expressed like this, for a 3-by-2 A:
% % 
% % [X Y]'  =  A' * [U V 1] ' 
% % 
% % Or, like this, for a 3-by-3 A:
% % 
% % [X Y 1]'  =  A' * [U V 1]'

plot(v3_in_plot_x, v3_in_plot_y,'linestyle','-','color','r');
hold on
plot(v3_out_plot_x, v3_out_plot_y,'linestyle','-','color','b');
hold on
plot(v3_in_verify_plot_x, v3_in_verify_plot_y,'linestyle','-','color','g');
hold on
plot(v3_out_verify_plot_x, v3_out_verify_plot_y,'linestyle','-','color','y');
