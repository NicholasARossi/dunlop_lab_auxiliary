function [data, bestFctParams] = parse_experiment_data(data_dir, start_dir, end_dir, tricolor)
% If tricolor, gfp is cfp. Not explicityly labeled, it just corresponds to
% a column in the final data, so nbd (for now). TODO: make generic for
% arbitrary number of channels.

    data = [];
    bestFctParams = [];
    for iptg_count = start_dir:end_dir
        single_gfps = [];
        single_rfps = [];
        single_yfps = [];
        for xy_count = 1:5
            clist = load([data_dir, '/', num2str(iptg_count), '/xy', num2str(xy_count), '/clist.mat']);
            data3D = clist(1).data3D;
            for cell_count = 1:length(data3D(:,1))
                single_gfps = vertcat(single_gfps, data3D(cell_count, 6));
                single_rfps = vertcat(single_rfps, data3D(cell_count, 8));
                if tricolor
                    single_yfps = vertcat(single_yfps, data3D(cell_count, 10));
                end
            end        
        end
        if ~tricolor
            data = vertcat(data, [single_rfps, single_gfps]);
        else
            data = vertcat(data, [single_rfps, single_gfps, single_yfps]);
        end       
    end
    
    % fit data to activation curve for 2 channel data
    if ~tricolor
        bestFctParams = fitdata(data);
    end
end