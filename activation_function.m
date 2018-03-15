function r2 = activation_function(data , params)
    kd = params.kd(1);
    a = params.a(1);
    b = 1;
    c = params.c(1);
    n = params.n(1);
    
    r2 = 0;
    for i = 1:length(data(:,1))
        r2 = r2 + (data(i,2) - (a/b*((data(i,1)/kd)^n/(1+(data(i,1)/kd)^n)) + c/b))^2;
    end
end

