function [data, data_iptg, bestFctParams] = parse_experiment_data_struct(data_dir, start_dir, end_dir, tricolor)
% If tricolor, gfp is cfp. Not explicityly labeled, it just corresponds to
% a columnb in the final data, so nbd (for now). TODO: make generic for
% arbitrary number of channels.

    data_iptg = struct();
    data = [];
    bestFctParams = [];
    count = 0;
    for iptg_count = start_dir:end_dir
        count = count + 1;
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
        
        data_iptg(count).gfp = single_gfps;
        data_iptg(count).rfp = single_rfps;
        if tricolor
            data_iptg(count).yfp = single_yfps;
        end
        if ~tricolor
            data = vertcat(data, [single_rfps, single_gfps]);
        else
            data = vertcat(data, [single_gfps, single_rfps, single_yfps]);
        end       
    end
    if ~tricolor
        bestFctParams = fitdata(data);
    end
end