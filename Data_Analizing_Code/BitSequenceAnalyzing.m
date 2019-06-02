clear all

load('Experiment_5_Trial_3.mat');
bit_sequence_1 = bit_sequence;
load('Experiment_5_Trial_6.mat');
bit_sequence_2 = bit_sequence;

%% Analyzing the bit sequence

clear num_pos_1 num_pos_2

start_idx = 15;
stop_idx = 28;

cond_check = 0;

for i=start_idx:stop_idx
    num_pos_1(i) = length(find(bit_sequence_1(i,:) == cond_check));
    num_pos_2(i) = length(find(bit_sequence_2(i,:) == cond_check));
end

plot([start_idx+973:stop_idx+973],num_pos_1([start_idx:stop_idx]),'r-o');
hold on;
plot([start_idx+973:stop_idx+973],num_pos_2([start_idx:stop_idx]),'b-+');
hold off;

% title('Stability of bit positions', 'Interpreter', 'none');
set(gca,'FontName','Times New Roman',  'FontSize', [12], 'LineWidth', 1);
xlabel('Timeline (us)','FontName','Times New Roman', 'FontSize', 12)
ylabel('Number of bits "0"', 'FontName','Times New Roman', 'FontSize', 12);
set(gca,'FontName','Times New Roman',  'FontSize', [12], 'LineWidth', 1);
set(gca, 'Ygrid', 'on', 'Xgrid', 'on' );
set(gcf, 'Position', [0 0 900 700]);

%% Checking stability of bit positions
clear pos_1 pos_2

pos_1 = find(bit_sequence_1(15,:) == cond_check);
pos_2 = find(bit_sequence_2(15,:) == cond_check);

% labels = cellstr(num2str([1 30]'));
plot([1:30],pos_1,'r-o','LineWidth',2);
hold on;
% text([1 30],pos_1,labels);
plot([1:30],pos_2,'b-+','LineWidth',2);
hold off;

title('Stability of bit positions', 'Interpreter', 'none');
set(gca,'FontName','Times New Roman',  'FontSize', [12], 'LineWidth', 1);
xlabel('Order of bits "0" in bit sequence','FontName','Times New Roman', 'FontSize', 12)
ylabel('Position of bits "0" in bit sequence', 'FontName','Times New Roman', 'FontSize', 12);
set(gca,'FontName','Times New Roman',  'FontSize', [12], 'LineWidth', 1);
set(gca, 'Ygrid', 'on', 'Xgrid', 'on' );
set(gcf, 'Position', [0 0 900 700]);

%% Check randomness of bit strings

bin_str_1 = de2bi(pos_1,'left-msb');
bin_str_2 = de2bi(pos_2,'left-msb');

bin_str_1 = reshape(bin_str_1',1,[]);
bin_str_2 = reshape(bin_str_2',1,[]);

[h,p] = runstest(bin_str_1)
[h,p] = runstest(bin_str_2)

%% 

[h,p] = ttest2(pos_1, pos_2)
