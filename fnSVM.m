function [ v_nearest_class ] = fnSVM( mat_test, mat_train, v_class )
% fnSVM Summary of this function goes here
%   Detailed explanation goes here



    if(size(mat_test,2) ~= size(mat_train,2))
        error(['Dimensions of points in test data (',size(mat_test,2),') is not same as those in training data (',size(mat_train,2),')']);
    end
    i_dimensions_count = size(mat_test,2);
    if(size(mat_train,1) ~= size(v_class,1))
        error(['Number of points in training data (',size(mat_train,1),') does not equal the number of points for classes provided (',len(v_class),')']);
    end
    i_train_points_count = size(mat_train,1);    
    if(size(v_class,1)~=1 && size(v_class,2)~=1)
        error('The class list must be a 1-dimensional vector');
    end
    v_class = reshape(v_class, [length(v_class),1]);
    i_test_points_count = size(mat_test,1);
        
    % Get information about unique classes
    v_unique = sort(unique(v_class))';
    i_unique_classes_count = length(v_unique);
    i_classes_count = max(v_unique);

% % % % matlab> model = svmtrain(training_label_vector, training_instance_matrix [, 'libsvm_options']);
% % % % 
% % % %         -training_label_vector:
% % % %             An m by 1 vector of training labels (type must be double).
% % % %         -training_instance_matrix:
% % % %             An m by n matrix of m training instances with n features.
% % % %             It can be dense or sparse (type must be double).
% % % %         -libsvm_options:
% % % %             A string of training options in the same format as that of LIBSVM.
% % % % 
% % % % matlab> [predicted_label, accuracy, decision_values/prob_estimates] = svmpredict(testing_label_vector, testing_instance_matrix, model [, 'libsvm_options']);
% % % % matlab> [predicted_label] = svmpredict(testing_label_vector, testing_instance_matrix, model [, 'libsvm_options']);
% % % % 
% % % %         -testing_label_vector:
% % % %             An m by 1 vector of prediction labels. If labels of test
% % % %             data are unknown, simply use any random values. (type must be double)
% % % %         -testing_instance_matrix:
% % % %             An m by n matrix of m testing instances with n features.
% % % %             It can be dense or sparse. (type must be double)
% % % %         -model:
% % % %             The output of svmtrain.
% % % %         -libsvm_options:
% % % %             A string of testing options in the same format as that of LIBSVM.    


    mat_test = double(mat_test);
    mat_train = double(mat_train);
    v_class = double(v_class);
    v_test = double(zeros(size(mat_test,1), 1));

    svm_model = svmtrain(v_class,mat_train);
    v_predicted_label = svmpredict(v_test, mat_test, svm_model);
    v_nearest_class = v_predicted_label;
    
    return;

    %% Code below uses SVM on binary data
    %% It also uses MatLab default 'svmtrain' which is different from libSVM version of 'svmtrain'
    %% If code belo results in error, move the libSVM mex files to a different location, so MatLab version becomes default
    mat_results = zeros(i_test_points_count, i_classes_count);
    
    %% Group indictors by uinique class
    for i_class = v_unique
        v_class_ind = (i_class == v_class);
        svm_model = svmtrain(mat_train, v_class_ind);
        svm_results = svmclassify(svm_model, mat_test);
        mat_results(:,i_class) = svm_results;
    end
    
    %% Map indictor back to appropriate class
    v_count = sum(mat_results, 2);
    mat_mult = repmat([1:i_classes_count], i_test_points_count, 1);
    v_nearest_class = sum(mat_mult.*mat_results, 2);
    
    
    
    
    
end

