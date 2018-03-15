function activation_histogram( all_data, marA_data, soxS_data, marA_bin, soxS_bin, gene )
    %figure();
    hold on;
    
    histogram(all_data, 20, 'Normalization', 'probability');    
    histogram(marA_data(:,1), marA_bin, 'Normalization', 'probability');
    histogram(soxS_data(:,1), soxS_bin, 'Normalization', 'probability');
    
%     histogram(all_data, 20);    
%     histogram(marA_data(:,1), marA_bin);
%     histogram(soxS_data(:,1), soxS_bin);
    
    title(gene);
    legend('All Data', 'marA', 'soxS');
    xlabel('RFP');
    ylabel('Fraction');

end

