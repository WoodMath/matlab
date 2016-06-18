

clear all;
mat_x = reshape(1:20,[5,4]);

mat_x = mat_x + norminv(rand(size(mat_x)),0,1);
scatter(mat_x(:,1),mat_x(:,2))

mat_mean = repmat(mean(mat_x,2), [1,size(mat_x,2)]);
% mat_x_lm = (mat_x - mat_mean)/(size(mat_x,2)-1);
mat_x_lm = mat_x - mat_mean;

disp('*******')
[mat_U_svd, mat_S_svd, mat_V_svd] = svd(mat_x_lm);
% mat_U_svd = mat_U_svd ./ repmat(sum(mat_U_svd.^2), [size(mat_U_svd,1), 1])
mat_U_svd
mat_S_svd = mat_S_svd.^2

disp('*******')
[mat_U_econ, mat_S_econ, mat_V_econ] = svd(mat_x_lm,'econ');
% mat_U_econ = mat_U_econ ./ repmat(sum(mat_U_econ.^2), [size(mat_U_econ,1), 1])
mat_U_econ
mat_S_econ = mat_S_econ.^2

disp('*******')
[mat_V_eig, mat_D_eig] = eig(mat_x_lm*mat_x_lm');
% mat_V_eig = mat_V_eig./repmat(sum(mat_V_eig.^2),[size(mat_V_eig,1), 1]);

mat_V_eig = mat_V_eig(:, [size(mat_V_eig, 2):-1:1]) 
mat_D_eig = mat_D_eig(:, [size(mat_D_eig, 2):-1:1]); 
mat_D_eig = mat_D_eig([size(mat_D_eig, 1):-1:1], :) 
