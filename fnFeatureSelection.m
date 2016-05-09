function [ v_indices ] = fnFeatureSelection( mat_data, v_class, i_count_classes, i_count_samples, i_reduce_count )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    mat_data = mat_data';                                   %% Put data in
    i_count_dimensions = size(mat_data,1);
    v_mean = mean(mat_data,2);                              %% Need mean
    mat_mean = repmat(v_mean, [1, size(mat_data,2)]);       %% in order to
    mat_data_less_mean = mat_data-mat_mean;                 %% center Data

    mat_class_means = zeros(size(mat_data,1),i_count_classes);   %% Will be used for Sb
    mat_point_data_less_class_mean = zeros(size(mat_data));
    mat_Sw = zeros(size(mat_data,1),size(mat_data,1));
    % mat_Sb = zeros(size(mat_data,1),size(mat_data,1));
    
    i_N = i_count_classes * i_count_samples;
    i_K = i_count_classes;


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

    %% Makes data back in to 644x400 array
    mat_point_data_less_class_mean = reshape(mat_class_data_less_class_mean, size(mat_data));
    
    %% Get Sum of Squares for Ingroup variation
    mat_SSw = mat_point_data_less_class_mean.^2;
    v_Vw = sum(mat_SSw,2)/(i_N-i_K);

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



    
    %% Pouplate Sb
    mat_class_means_less_mean = mat_class_means - repmat(v_mean, [1,size(mat_class_means,2)]);
    mat_SSb = i_count_samples*(mat_class_means_less_mean.^2);
    v_Vb = sum(mat_SSb,2)/(i_K-1);
    
    v_FStat = (v_Vb./v_Vw);
    mat_FStat = [v_FStat,[1:length(v_FStat)]'];
    
    mat_Sorted_FStat = sortrows(mat_FStat);
    mat_Sorted_FStat = mat_Sorted_FStat([size(mat_FStat,1):-1:1],:);
    
    v_indices = mat_Sorted_FStat(1:i_reduce_count,2);
    
    return
    
    mat_sub_data = mat_data(v_indices,:);
    
    %% Solve 'mat_sub_data = mat_U * mat_data' for 'mat_U'
    %% 'mat_sub_data = mat_U * mat_data'
    %% 'mat_sub_data * mat_data^T = mat_U * mat_data * mat_data^T'
    %% 'mat_sub_data * mat_data^T * inv(mat_data * mat_data^T) = mat_U * mat_data * mat_data^T * inv(mat_data * mat_data^T) = mat_U'
    mat_data_sq = mat_data * mat_data';
    mat_data_sq = mat_data_sq + 0.0000000*eye(length(mat_data_sq));
    mat_U = mat_sub_data * mat_data' /mat_data_sq;
    
end

