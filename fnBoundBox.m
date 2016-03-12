function [ vMin, vMax ] = fnBoundBox( mat_input, varargin )


    minRow = sum(mat_input(1,:)');
    maxRow = sum(mat_input(size(mat_input,1),:)');
    minCol = sum(mat_input(:,1));
    maxCol = sum(mat_input(:,size(mat_input,2)));
    if(minRow > 0 & maxRow > 0 & minCol > 0 & maxCol)
        vMin = [1, 1];
        vMax = size(mat_input);
        return;
    end;
        

    % base call
    thisParam = 'h';    % division parameter for this level deep    
    callParam = 'v';    % division parameter for next level deep

    if(nargin == 2)
       if(ischar(varargin{1}))
           if(varargin{1}=='h')
               thisParam = 'h';
               callParam = 'v';
           end
           if(varargin{1}=='v')
               thisParam = 'v';                   
               callParam = 'h';                   
           end

       end

    end
    
    v2_size = size(mat_input);
    
    if(v2_size(1) == 1 | v2_size(2) == 1)
        % if one of the dimensions is thin
        % force behavior for this call
        % and next call
        lDim = length(mat_input);
        if(size(mat_input,1) == lDim)
            % if rows are longer dimension
            % should be use 'Vertical' next time
            thisParam = 'v';
        end
        if(size(mat_input,2) == lDim)
            % if cols are longer dimension
            % should be use 'Horizontl' next time
            thisParam = 'h';
        end
        callParam = thisParam;
    end
  
    
    if(thisParam == 'h')
    %   Horizontal division
    %    +---+---+
    %    | 1 | 2 |
    %    +---+---+
        
        v2_region_one_min = [1,1];
        v2_region_one_max = [v2_size(1), bitshift(v2_size(2),-1)];

        v2_region_two_min = [1,v2_region_one_max(2)+1];        
        v2_region_two_max = v2_size;
        
    end

    if(thisParam == 'v')
    %   Vertical division
    %    +---+
    %    | 1 |
    %    +---+
    %    | 2 |
    %    +---+
        
        v2_region_one_min = [1,1];
        v2_region_one_max = [bitshift(v2_size(1),-1), v2_size(2)];

        v2_region_two_min = [v2_region_one_max(1)+1,1];        
        v2_region_two_max = v2_size;
        
    end    


    
    
    callRegion_One = mat_input(v2_region_one_min(1):v2_region_one_max(1), v2_region_one_min(2):v2_region_one_max(2));
    callRegion_Two = mat_input(v2_region_two_min(1):v2_region_two_max(1), v2_region_two_min(2):v2_region_two_max(2));

    v2_size_one = size(callRegion_One);
    v2_size_two = size(callRegion_Two);
    
    iAreaOne = v2_size_one(1)*v2_size_one(2);
    iAreaTwo = v2_size_two(1)*v2_size_two(2);
    
    sumRegion_One = sum(sum(callRegion_One));
    sumRegion_Two = sum(sum(callRegion_Two));
    
%     figure(100); imagesc(callRegion_One);
%     figure(200); imagesc(callRegion_Two);
%     figure(300); imagesc(mat_input);
    
    bUseR1 = 0;
    bUseR2 = 0;
    
    % will not even attempt to call "empty" regions"
    if(sumRegion_One)
        [r1_min, r1_max] = fnBoundBox(callRegion_One, callParam);
        bUseR1 = 1;
    end
    
    % will not even attempt to call "empty" regions"    
    if(sumRegion_Two)
        [r2_min, r2_max] = fnBoundBox(callRegion_Two, callParam);
        
        % shift forward number of columns
        if(thisParam == 'h')
            r2_min(2) = r2_min(2) + v2_size_one(2);
            r2_max(2) = r2_max(2) + v2_size_one(2);
        end
        
        % shift forward number of rows
        if(thisParam == 'v')
            r2_min(1) = r2_min(1) + v2_size_one(1);
            r2_max(1) = r2_max(1) + v2_size_one(1);
        end
        bUseR2 = 1;
    end

%     figure(100); imagesc(callRegion_One);
%     figure(200); imagesc(callRegion_Two);
%     figure(300); imagesc(mat_input);
    
    
    if((bUseR1 * bUseR2) > 0)
        % if both regions are use
        vMin = [min(r1_min(1), r2_min(1)), min(r1_min(2), r2_min(2))];
        vMax = [max(r1_max(1), r2_max(1)), max(r1_max(2), r2_max(2))];
        
    else
        if(bUseR1)
            vMin = r1_min;
            vMax = r1_max;
        end
        if(bUseR2)
            vMin = r2_min;
            vMax = r2_max;            
        end
    end
        
        


end

