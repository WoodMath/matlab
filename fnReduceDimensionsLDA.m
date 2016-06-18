function [ mat_new, mat_U, mat_Xdlm_ito_eigU, mat_mean, v_mean ] = fnReduceDimensionsLDA( mat_data, i_count_classes, i_count_samples, i_reduce_count )
%fnReduceDimensions reduces data
%   takes data from 'mat_data' and reduces it to 'i_reduce_count')











    

    mat_data = mat_data';                                   %% Put data in
    i_count_dimensions = size(mat_data,1);
    v_mean = mean(mat_data,2);                              %% Need mean
    mat_mean = repmat(v_mean, [1, size(mat_data,2)]);       %% in order to
    mat_data_less_mean = mat_data-mat_mean;                 %% center Data

    mat_class_means = zeros(size(mat_data,1),i_count_classes);   %% Will be used for Sb
    mat_point_data_less_class_mean = zeros(size(mat_data));
    mat_Sw = zeros(size(mat_data,1),size(mat_data,1));
    % mat_Sb = zeros(size(mat_data,1),size(mat_data,1));


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %% Get class means
    % for i_inc = 1:i_count_classes
    %    
    %     v_class_ind = v_class==i_inc;
    %     mat_class_data = mat_data(:,v_class_ind);
    %     v_class_mean = mean(mat_class_data,2);
    %     mat_class_mean = repmat(v_class_mean, [1,i_count_samples]);
    %     mat_class_data_less_class_mean = mat_class_data - mat_class_mean;
    % 
    %     %% Assign class mean to column
    %     mat_class_means(:,i_inc) = sum(mat_class_data_less_class_mean,2);
    % 
    %     i_point_start = i_count_samples*(i_inc - 1) + 1;
    %     i_point_stop = i_point_start + i_count_samples - 1;  
    %     mat_point_data_less_class_mean(:,i_point_start:i_point_stop) = mat_class_data_less_class_mean;
    % 
    %     
    % end

    %% Makes data into 644x10x40 array
    mat_class_data = reshape(mat_data, [size(mat_data,1), i_count_samples, i_count_classes]);
    v_class_mean = mean(mat_class_data,2);
    mat_class_means = reshape(v_class_mean, [i_count_dimensions, i_count_classes]);
    mat_class_mean = repmat(v_class_mean, [1,i_count_samples,1]);
    mat_class_data_less_class_mean = mat_class_data - mat_class_mean;

    %% Makes data backingto 644x400 array
    mat_point_data_less_class_mean = reshape(mat_class_data_less_class_mean, size(mat_data));

    % clear mat_class_data_less_class_mean
    % clear mat_class_mean
    % clear mat_class_data
    % clear mat_data
    % clear mat_mean

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    %% Populate Sw
    for i_point = 1:(i_count_samples*i_count_classes)

        mat_Sw = mat_Sw + mat_point_data_less_class_mean(:,i_point)*mat_point_data_less_class_mean(:,i_point)';

    end

    % mat_point_data_lcm_perm_vert = reshape(mat_point_data_less_class_mean, [i_count_dimensions, 1, i_count_classes*i_count_samples]);
    % mat_point_data_lcm_perm_horz = reshape(mat_point_data_less_class_mean, [1, i_count_dimensions, i_count_classes*i_count_samples]);
    % 
    % mat_point_data_lcm_perm_vert = repmat(mat_point_data_lcm_perm_vert, [1, i_count_dimensions, 1]);
    % mat_point_data_lcm_perm_horz = repmat(mat_point_data_lcm_perm_horz, [i_count_dimensions, 1, 1]);
    % 
    % mat_Sw_dim = mat_point_data_lcm_perm_vert .* mat_point_data_lcm_perm_horz;
    % mat_Sw = sum(mat_Sw_dim,3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Pouplate Sb
    mat_class_means_less_mean = mat_class_means - repmat(v_mean, [1,size(mat_class_means,2)]);

    % for i_class = 1:i_count_classes
    %     
    %     mat_Sb = mat_Sb + mat_class_means_less_mean(:,i_class)*mat_class_means_less_mean(:,i_class)';
    % end

    mat_class_means_lm_perm_vert = reshape(mat_class_means_less_mean, [i_count_dimensions, 1, i_count_classes]);
    mat_class_means_lm_perm_horz = reshape(mat_class_means_less_mean, [1, i_count_dimensions, i_count_classes]);

    mat_class_means_lm_perm_vert = repmat(mat_class_means_lm_perm_vert, [1, i_count_dimensions, 1]);
    mat_class_means_lm_perm_horz = repmat(mat_class_means_lm_perm_horz, [i_count_dimensions, 1, 1]);

    mat_Sb_dim = mat_class_means_lm_perm_vert .* mat_class_means_lm_perm_horz;
    mat_Sb = sum(mat_Sb_dim,3);

%     mat_eigen = (mat_Sw+0.000000001*eye(length(mat_Sw)))\mat_Sb;
    mat_eigen = (mat_Sw+0.000000001*eye(length(mat_Sw)))\mat_Sb;

    [mat_eigen_V, mat_eigen_D] = eig(mat_eigen);
    [mat_eigen_V_new, mat_eigen_D_new] = cdf2rdf(mat_eigen_V, mat_eigen_D);

    


    v_S = zeros(1,length(mat_eigen));

    for i_inc = 1:length(v_S)

        v_eigen = mat_eigen_V_new(:,i_inc);
        v_S(i_inc) = (v_eigen'*mat_Sb*v_eigen)/(v_eigen'*mat_Sw*v_eigen);
    end

    %% Sort by values to get most relevant Basis (and those that are Orthogonal)
    v_Sort = [v_S;[1:length(v_S)]]';
    v_Sort = sortrows(v_Sort);
    v_Sort = v_Sort([size(v_Sort,1):-1:1],:);
    v_Cols = v_Sort(:,2)';

%     i_Reduce_Count = 5;

    v_Cols = v_Cols(1:i_reduce_count);

    % v_Discriminator_ind = find(abs(v_S)==max(abs(v_S)))
    % v_Discriminator_ind = find(v_S==max(v_S));
    % 
    % v_Discriminator = mat_eigen_V_new(:,v_Discriminator_ind);
    % v_Discriminator_norm = v_Discriminator/norm(v_Discriminator);

    v_Discriminator = mat_eigen_V_new(:,v_Cols);
    v_Discriminator_sq = v_Discriminator.^2;
    v_Discriminator_Norm = repmat(sum(v_Discriminator_sq,1), [size(v_Discriminator,1),1]);
    v_Discriminator_Norm = v_Discriminator./v_Discriminator_Norm;

    mat_Upper = mat_eigen_V_new' * mat_Sb * mat_eigen_V_new ;
    mat_Lower = mat_eigen_V_new' * mat_Sw * mat_eigen_V_new;


    %% U is the New basis
    mat_U = v_Discriminator_Norm;

    %% Find data points 'mat_X' in terms of Eigen vectors, rather
    %% find 'mat_Xdlm_ito_eigU' in 
    %% mat_data_less_mean = mat_U * mat_Xdlm_ito_eigU;   
    %% Because 'mat_Xdlm_ito_eigU' is we cannot find an inverse.
    %% So we get pseudo inversoe of
    %% mat_data_less_mean = mat_U * mat_Xdlm_ito_eigU;
    %% mat_U' * mat_data_less_mean = mat_U' * mat_U * mat_Xtlm_ito_eigU
    %% inv(mat_U' * mat_U) * mat_U' * mat_data_less_mean = inv(mat_U' * mat_U) * (mat_U' * mat_U) * mat_Xdlm_ito_eigU = mat_Xdlm_ito_eigU
%     mat_Xdlm_ito_eigU = inv(mat_U' * mat_U) * mat_U' * mat_data_less_mean;
    mat_Xdlm_ito_eigU = fnXitoU(mat_data_less_mean, mat_U, i_reduce_count);
    
    %% Get first 'i_reduce_count' Eigen vectors - mat_U(:, [1:i_reduce_count])
    %% and the first 'i_reduce_count' vector components - mat_Xdlm_ito_eigU([1:i_reduce_count], :)
    %% and add back the mean
    mat_new = mat_U * mat_Xdlm_ito_eigU + mat_mean;

    %% previous will be 644x400
    %% Make it 400x644
    mat_new = mat_new';
    mat_mean = mat_mean';




    return


    %% Input will be 400x644
    %% Make it 644x400 To perform analysis
    mat_data = mat_data';


    %% Using SVD
    v_mean = mean(mat_data,2);                              %% Need mean
    mat_mean = repmat(v_mean, [1, size(mat_data,2)]);       %% in order to
    mat_data_less_mean = mat_data-mat_mean;                 %% center Data

    v_var = var(mat_data,1,2);                              %% Will need
    mat_var = repmat(v_var, [1, size(mat_data,2)]);         %% Standard
    mat_stdev = mat_var.^0.5;                               %% Deviation

    %% Create a data matrix X such that the r-th Row, c-th Column of
    %% X*(X^T) will give the correlation (per class instruction) of the
    %% r-th and c-th variable. Do this by making r-th Row, c-th Column
    %% equal to SumAllXsubR(x_R-Mu_R) * SumAllXsubC(x_C-Mu_C) / (stdev(x_R) * stdev(x_C))
    mat_X = mat_data_less_mean./mat_stdev;

    %% Instead of using PCA to get Eigen vectors of 'mat_X*mat_X^T'
    %% We only need use SVD on 'mat_X' to get Eigen vectors

    [mat_U, mat_S, mat_V] = svd(mat_X,'econ');
    %% Find mat_Xdlm_ito_eigU st it is 400x400
    %% mat_data_less_mean = mat_U * mat_Xdlm_ito_eigU;
    %% mat_U' * mat_data_less_mean = mat_U' * mat_U * mat_Xtlm_ito_eigU
    %% inv(mat_U' * mat_U) * mat_U' * mat_data_less_mean = inv(mat_U' * mat_U) * (mat_U' * mat_U) * mat_Xdlm_ito_eigU
    % pinv(mat_U') * mat_U' * mat_data_less_mean = inv(mat_U' * mat_U) * (mat_U' * mat_U) * mat_Xdlm_ito_eigU

    %% Only first 'i_reduce_count' dimensions are needed
    mat_U = mat_U(:, [1:i_reduce_count]);
    
    
    
    %% Find data points 'mat_X' in terms of Eigen vectors, rather
    %% find 'mat_Xdlm_ito_eigU' in 
    %% mat_data_less_mean = mat_U * mat_Xdlm_ito_eigU;   
    %% Because 'mat_Xdlm_ito_eigU' is we cannot find an inverse.
    %% So we get pseudo inversoe of
    %% mat_data_less_mean = mat_U * mat_Xdlm_ito_eigU;
    %% mat_U' * mat_data_less_mean = mat_U' * mat_U * mat_Xtlm_ito_eigU
    %% inv(mat_U' * mat_U) * mat_U' * mat_data_less_mean = inv(mat_U' * mat_U) * (mat_U' * mat_U) * mat_Xdlm_ito_eigU = mat_Xdlm_ito_eigU
%     mat_Xdlm_ito_eigU = inv(mat_U' * mat_U) * mat_U' * mat_data_less_mean;
    mat_Xdlm_ito_eigU = fnXitoU(mat_data_less_mean, mat_U, i_reduce_count);
    
    %% Get first 'i_reduce_count' Eigen vectors - mat_U(:, [1:i_reduce_count])
    %% and the first 'i_reduce_count' vector components - mat_Xdlm_ito_eigU([1:i_reduce_count], :)
    %% and add back the mean
    mat_new = mat_U * mat_Xdlm_ito_eigU + mat_mean;

    %% previous will be 644x400
    %% Make it 400x644
    mat_new = mat_new';
    mat_mean = mat_mean';


end

