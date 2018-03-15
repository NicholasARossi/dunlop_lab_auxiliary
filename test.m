% Process data and fit to activation function
% TODO: don't call parse_experiment_data over and over - use some list of
% directories that can be passed in and have a larger struct that contains
% all the data. All subsequent function calls should be done iteratively
% instead of explicitly.

[marA_SAK_data, marA_SAK_bestFctParams] = parse_experiment_data('2_24_18/SAK/tiffs', 1, 6, false);
[soxS_SAK_data, soxS_SAK_bestFctParams] = parse_experiment_data('2_24_18/SAK/tiffs', 7, 12, false);

[marA_SFK_data, marA_SFK_bestFctParams] = parse_experiment_data('2_24_18/SFK/tiffs', 1, 6, false);
[soxS_SFK_data, soxS_SFK_bestFctParams] = parse_experiment_data('2_24_18/SFK/tiffs', 7, 12, false);

[marA_SIK_data, marA_SIK_bestFctParams] = parse_experiment_data('2_24_18/SIK/tiffs', 1, 6, false);
[soxS_SIK_data, soxS_SIK_bestFctParams] = parse_experiment_data('2_24_18/SIK/tiffs', 7, 12, false);

[marA_SMK_data, marA_SMK_bestFctParams] = parse_experiment_data('2_24_18/SMK/tiffs', 1, 6, false);
[soxS_SMK_data, soxS_SMK_bestFctParams] = parse_experiment_data('2_24_18/SMK/tiffs', 7, 12, false);

[marA_SSK_data, marA_SSK_bestFctParams] = parse_experiment_data('2_24_18/SSK/tiffs', 1, 6, false);
[soxS_SSK_data, soxS_SSK_bestFctParams] = parse_experiment_data('2_24_18/SSK/tiffs', 7, 12, false);

[marA_STK_data, marA_STK_bestFctParams] = parse_experiment_data('2_24_18/STK/tiffs', 1, 6, false);
[soxS_STK_data, soxS_STK_bestFctParams] = parse_experiment_data('2_24_18/STK/tiffs', 7, 12, false);

[marA_pFAI_data, marA_pFAI_iptg, bfp] = parse_experiment_data_struct('2_25_18/pFAI/tiffs', 1, 6, true);
[soxS_pFAI_data, soxS_pFAI_iptg, bfp] = parse_experiment_data_struct('2_25_18/pFAI/tiffs', 7, 12, true);
    
[marA_pPSF_data, marA_pPSF_iptg, bfp] = parse_experiment_data_struct('2_25_18/pPSF/tiffs', 1, 6, true);
[soxS_pPSF_data, soxS_pPSF_iptg, bfp] = parse_experiment_data_struct('2_25_18/pPSF/tiffs', 7, 12, true);

close all;

plot_activation_data(marA_SAK_data, soxS_SAK_data, marA_SAK_bestFctParams, soxS_SAK_bestFctParams, 'acrAB');
plot_activation_data(marA_SFK_data, soxS_SFK_data, marA_SFK_bestFctParams, soxS_SFK_bestFctParams, 'micF');
plot_activation_data(marA_SIK_data, soxS_SIK_data, marA_SIK_bestFctParams, soxS_SIK_bestFctParams, 'inaA');
plot_activation_data(marA_SMK_data, soxS_SMK_data, marA_SMK_bestFctParams, soxS_SMK_bestFctParams, 'marA');
plot_activation_data(marA_SSK_data, soxS_SSK_data, marA_SSK_bestFctParams, soxS_SSK_bestFctParams, 'sodA');
plot_activation_data(marA_STK_data, soxS_STK_data, marA_STK_bestFctParams, soxS_STK_bestFctParams, 'tolC');

% concatenate data for larger comparisons across group
all_marA = vertcat(marA_SAK_data, marA_SFK_data, marA_SIK_data, marA_SMK_data, marA_SSK_data, marA_STK_data);
all_soxS = vertcat(soxS_SAK_data, soxS_SFK_data, soxS_SIK_data, soxS_SMK_data, soxS_SSK_data, soxS_STK_data);
all_data = vertcat(all_marA, all_soxS);

% histograms
subplot(2, 3,  1);
activation_histogram(all_data, marA_SAK_data, soxS_SAK_data, 20, 20, 'acrAB');
subplot(2, 3,  2);
activation_histogram(all_data, marA_SFK_data, soxS_SFK_data, 20, 20, 'micF');
subplot(2, 3,  3);
activation_histogram(all_data, marA_SIK_data, soxS_SIK_data, 20, 20, 'inaA');
subplot(2, 3,  4);
activation_histogram(all_data, marA_SMK_data, soxS_SMK_data, 20, 20, 'marA');
subplot(2, 3,  5);
activation_histogram(all_data, marA_SSK_data, soxS_SSK_data, 20, 20, 'sodA');
subplot(2, 3,  6);
activation_histogram(all_data, marA_STK_data, soxS_STK_data, 20, 20, 'tolC');
% tricolor plots

% iptg vs fluor levels
plot_fluor_iptg(marA_pFAI_iptg, {'micF', 'acrAB', 'inaA'}, 'marA', 1);
plot_fluor_iptg(soxS_pFAI_iptg, {'micF', 'acrAB', 'inaA'}, 'soxS', 2);
plot_fluor_iptg(marA_pPSF_iptg, {'purA', 'famC', 'sodA'}, 'marA', 3);
plot_fluor_iptg(soxS_pPSF_iptg, {'purA', 'famC', 'sodA'}, 'soxS', 4);

% bin values by IPTG level, then plot against other gene 
tricolor_comparison_plot(marA_pFAI_data, marA_pFAI_iptg, soxS_pFAI_data, soxS_pFAI_iptg, {'micF', 'inaA', 'acrAB'});
tricolor_comparison_plot(marA_pPSF_data, marA_pPSF_iptg, soxS_pPSF_data, soxS_pPSF_iptg, {'purA', 'famC', 'sodA'});