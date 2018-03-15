function [ analytical_output ] = get_analytical_output_activation( bestFctParams , range)
% Returns data over supplied range of the activation function
    analytical_output = [];
    kd = bestFctParams.kd;
    a = bestFctParams.a;
    b = 1;
    n = bestFctParams.n;
    c = bestFctParams.c;
    for i = 1:length(range)
        av = a/b*((range(i)/kd)^n/(1+(range(i)/kd)^n)) + c/b;
        analytical_output = vertcat(analytical_output, av); 
    end

end

