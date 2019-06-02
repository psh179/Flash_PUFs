for i = 1:28
   HamDis(i) = sum(abs(bit_sequence_trial1(i,:) - bit_sequence_trial2(i,:))) 
end


% sum(abs(bit_sequence_trial1(16,:) - bit_sequence_trial2(16,:)))