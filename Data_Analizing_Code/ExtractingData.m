% https://www.mathworks.com/help/matlab/ref/numel.html

clear all
clc

%% Import data from text file.
% function importDataFileFunc(fileName, endRow)
% Script for importing data from the file indicated in filename argument

folder_name = 'Experiment_5/Trial_27';

mat_file_name = regexprep(folder_name,'\/','_')

for k=890:930

file_name = sprintf('./%s/%d.txt', folder_name, k)

%% Initialize variables.
delimiter = ' ';

% Identify when script will stop
% if nargin<2
    endRow = inf;
% end



%% Open the text file.
input_file = fopen(file_name,'r');

%% Read trace log file.
data_line =  fgetl(input_file); % Read first line of file, removing newline characters

i = 1;  % index of data line

% Loop to read data lines
while ischar(data_line) & (i <= endRow)
    
    % if (mod(i,10000) == 0) disp(['Processing line -> ' int2str(i)]); end % Notify user
    % if (mod(i,1000) == 0) fprintf('.'); end % Notify user
    
    token_idx = 1;  % Index of string in data line
    remain = data_line;
    
    % Read until reaches end of line
    while true

        [str, remain] = strtok(remain, delimiter); % Select parts of string
        
        if isempty(str)
            break;
        else
            all_strings{i} = str;  
            i = i + 1;  % Increase index of string
        end          
    end
    
    data_line = fgetl(input_file);  % Read next line of file, removing newline characters
end
    
%% Close the text file.
fclose(input_file);

%% Convert a matrix of hex to a matrix of bin
% Each hex will be converted to 16-bit vector
bit_strings = hexToBinaryVector(all_strings, 16); 


%% Convert a 2D-array to vector
bit_strings = transpose(bit_strings);
bit_sequence(k-889,:) = reshape(bit_strings,1,[]);

end

disp(' Done!!! ')

%% Analyzing data
[width,height] = size(bit_sequence); % Get the size of matrix

zeros_sequence = zeros(1,height); % Generate a zeros-binary sequence

for i=1:width
    mean_values{i} = mae(zeros_sequence - bit_sequence(i,:)); % mean(abs(A-B))
end

prob = cell2mat(mean_values); % Convert cell array to matrix

% Plot the graph

labels = cellstr(num2str([890:930]'));
plot([890:930],prob,'-o');
text([890:930],prob,labels);
title(folder_name, 'Interpreter', 'none');
set(gca,'FontName','Times New Roman',  'FontSize', [12], 'LineWidth', 1);
xlabel('Timeline','FontName','Times New Roman', 'FontSize', 12)
ylabel('Probability', 'FontName','Times New Roman', 'FontSize', 12);
set(gca,'FontName','Times New Roman',  'FontSize', [12], 'LineWidth', 1);
% set(gca, 'XLim', [300 400],'XTick',[300:20:400]);
% set(gca, 'YLim', [0 1], 'YTick', [0:0.2:1]);
set(gca, 'Ygrid', 'on', 'Xgrid', 'on' );
set(gcf, 'Position', [0 0 900 700]);
print(mat_file_name,'-dpdf');
%% Clear temporary variables
% clearvars bit_strings all_strings i k delimiter startRow endRow fileID ans dataLine i remain str token_idx fileName inputFile;

%% Save workspace
% save (strcat(fileName,'_imported.mat'));
save(mat_file_name, 'bit_sequence');
