mclassification = 'I:\Documents\MWMGEN\tiago_original\Mclassification\class_2322_29476_250_09_10_10_mr0-correct2\merged_1.mat';
output_file = 'I:\Documents\labels.csv';

load(mclassification);
labels = classification_configs.CLASSIFICATION.class_map';
segments = 1:length(labels);
segments = segments';
table = [num2cell(segments), num2cell(labels)];
tags = classification_configs.CLASSIFICATION_TAGS;
for i = 1:size(table,1)
    if table{i,2} > 0
        table{i,2} = tags{table{i,2}}{1};
    else
        table{i,2} = 'UD';
    end
end

VariableNames = cell(1,length(tags)+2);
VariableNames{1} = 'Segment';
for i = 2:length(VariableNames)
    VariableNames{i} = strcat('label',num2str(i-1));
end
table{1,length(VariableNames)} = [];
table = cell2table(table,'VariableNames',VariableNames);
writetable(table,output_file,'WriteVariableNames',1);

