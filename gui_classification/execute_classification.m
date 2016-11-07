function error = execute_classification(project_path,seg_name,lab_name,num_clusters)
%EXECUTE_CLASSIFICATION 

    error = 1;
    project_path = char_project_path(project_path);

    %% Load segmentation_config and labels
    labels = fullfile(project_path,'labels',lab_name);
    try
        load(labels)
    catch
        errordlg('Cannot load labels','Error');
        return
    end  
    segs = fullfile(project_path,'segmentation',seg_name);
    try
        load(segs)
    catch
        errordlg('Cannot load segmentation','Error');
        return
    end
    
     %% Parse the names
    [segs,len,ovl,ppath] = split_segmentation_name(segs);
    [labs,lenl,ovll,note,~] = split_labels_name(labels);
    if ~isequal(len,lenl) || ~isequal(ovl,ovll)
        errordlg('The selected segmentation and labels do not match','Error');
        return
    end
    
    %% Form tha names and make the dirs
    % project path, labels used, number of segments, segments length,
    % segments ovelap and labels note (if applicant)
    [class_folder,error] = build_classification_folder(ppath,'class',labs,segs,len,ovl,note);
    if error
        errordlg('Cannot create classification folder','Error');
        return        
    end   
    
    %% Generate the classifiers
    error = generate_classifiers(class_folder, num_clusters, segmentation_configs, LABELLING_MAP, ALL_TAGS, CLASSIFICATION_TAGS);
    if error
        return;
    else
        error = 0;
    end
end
