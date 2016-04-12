function [ mat_correct, i_correct, f_correct] = fnCrossValidate( mat_train, v_class, v_model, i_fold, i_count_classes, i_count_samples)
%fnCrossValidate Summary of this function goes here
%   Detailed explanation goes here

    b_svm = v_model(1);
    b_knn = v_model(2);
    i_k = v_model(3);
    b_cm = v_model(4);
    b_lr = v_model(5);

    i_train_points_count = size(mat_train,1);    
    if(size(v_class,1)~=1 && size(v_class,2)~=1)
        error('The class list must be a 1-dimensional vector');
    end
    
    v_train_points_count = double([1:i_train_points_count]);
    i_subset_size = double(round(i_train_points_count/i_fold));
    

    [cell_subsets, cell_indices] = fnSubsetIndices(v_class, i_fold, i_count_classes, i_count_samples);

    i_correct_svm = 0;
    i_correct_knn = 0;
    i_correct_cm = 0;
    i_correct_lr = 0;
    
    mat_correct = zeros(i_fold, 4);
    
    display(' ');
    for i_inc = 1:i_fold
        
        display([' Fold = ',num2str(i_inc),' / ', num2str(i_fold)]);
        %% Establish indictor vectors for which data to include in new training and test vectors
        v_test = logical(cell_indices{i_inc,1})';
        v_train = not(v_test);

        %% Establish cross validation test and training data
        mat_test_use = mat_train(v_test,:);
        mat_train_use = mat_train(v_train,:);
        v_test_class = v_class(v_test);
        v_train_class = v_class(v_train);

        %% vectors to test for equivalence with 'v_test_class'
        v_class_svm = v_test_class*0+-1;
        v_class_knn = v_test_class*0+-1;
        v_class_cm = v_test_class*0+-1;
        v_class_lr = v_test_class*0+-1;
        
        if logical(b_svm)
            v_class_svm = fnSVM( mat_test_use, mat_train_use, v_train_class );            
        end

        if logical(b_knn)
           v_class_knn = fnKNN( mat_test_use, mat_train_use, v_train_class, i_k );
        end

        if logical(b_cm)
            v_class_cm = fnCentroidMethod( mat_test_use, mat_train_use, v_train_class );
        end

        if logical(b_lr)
            v_class_lr = fnLinearRegression( mat_test_use, mat_train_use, v_train_class );
        end
        

        mat_correct(i_inc,1) = sum(v_class_svm == v_test_class);
        mat_correct(i_inc,2) = sum(v_class_knn == v_test_class);
        mat_correct(i_inc,3) = sum(v_class_cm == v_test_class);
        mat_correct(i_inc,4) = sum(v_class_lr == v_test_class);
    end
    
    i_correct = sum(mat_correct);
    f_correct = i_correct / i_count_classes / i_count_samples;
    
end