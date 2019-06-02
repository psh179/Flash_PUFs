%% Calculate hamming distance between two strings

clear all
clc

load('Experiment_5_Trial_1.mat');
bit_sequence_1 = bit_sequence;
load('Experiment_5_Trial_2.mat');
bit_sequence_2 = bit_sequence;

clear 'bit_sequence';

for i=1:41
    %mean_values{i} = mae(bit_sequence_1(i,:) - bit_sequence_2(i,:)); % mean(abs(A-B))
    HD_values{i} = sum(abs(bit_sequence_1(i,:) - bit_sequence_2(i,:))); % mean(abs(A-B))
    p_1{i} = sum(bit_sequence_1(i,:))/length(bit_sequence_1(i,:));
    p_2{i} = sum(bit_sequence_2(i,:))/length(bit_sequence_2(i,:));
end

HD = cell2mat(HD_values); % Convert cell array to matrix
prob_1 = cell2mat(p_1);
prob_2 = cell2mat(p_2);

% Plot the graph

plot([890:930],HD,'-o');
% scatter([974:1001],HD);
hold on
plot([890:930],prob_1,'-^', [890:930],prob_2,'-v');
set(gca,'FontName','Times New Roman',  'FontSize', [12], 'LineWidth', 1);
xlabel('Timeline','FontName','Times New Roman', 'FontSize', 12)
ylabel('Hamming Distance', 'FontName','Times New Roman', 'FontSize', 12);
hold off