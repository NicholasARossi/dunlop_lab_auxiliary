function plot_activation_data( marA_data, soxS_data, marA_bestFctParams, soxS_bestFctParams, gene_title)
    analytical_x = 0:max([max(marA_data(:,1)), max(soxS_data(:,1))])+5000;

    marA_analytical = get_analytical_output_activation(marA_bestFctParams, analytical_x);
    soxS_analytical = get_analytical_output_activation(soxS_bestFctParams, analytical_x);

    figure();
    hold on;
    scatter(marA_data(:,1), marA_data(:,2), 'r.', 'MarkerFaceAlpha', .15, 'MarkerEdgeAlpha', .15);
    scatter(soxS_data(:,1), soxS_data(:,2), 'k.', 'MarkerFaceAlpha', .15, 'MarkerEdgeAlpha', .15);
    plot(analytical_x, marA_analytical, 'r', 'LineWidth', 2);
    plot(analytical_x, soxS_analytical, 'k', 'LineWidth', 2);
    set(gca,'xscale','log');
    set(gca,'yscale','log');
    title(['Activation of ', gene_title]);
    xlabel('Input: RFP (au)');
    ylabel('Output: GFP (au)');
    legend('marA Data', 'soxS Data', 'marA Fit', 'soxS Fit');
    
    figure();
    hold on; 
    plot(marA_analytical, soxS_analytical, 'LineWidth', 2);
    max_val = max([marA_analytical, soxS_analytical]);
    one_to_one = 1:max_val;
    plot(one_to_one, one_to_one, 'r--');
    xlabel('Value of marA fit function');
    ylabel('Value of soxS fit function');
    title(['marA and soxS activation of ', gene_title]);
    legend('Function Data', 'Line slope 1');
end

