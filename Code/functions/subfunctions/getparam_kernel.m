function [ param ] = getparam_kernel( act_neur, method )
%GETPARAM_LL extracts the parameters from the neurons that caracterise
%prior knowledge. The output is a structure, needed as an input of the
%"decode" function. This is a private version that regroups all the
%getparam functions which are used for the ,aximum Likelyhood decoding
%method ("LL").
%   This structure encapsulates two type of information. The first
%   information is the method which will be used for decoding, and is the
%   input argument of "method" of this function. The second information is
%   the actual coefficients that are extracted from the activity of the
%   recorded neurons. An additional information caracterises the precision
%   of the method that we use for parametrisation of prior knowlledge.
%   - act_neur is a n_t*n_a*n_n*n_T matrix whith the activity of n_n neurons
%   through n_T bins of time (here, n_T=300), for n_t trials
%   - method is a string that caracterises the method that will be used for
%   further decoding, on which the parametrisation of the prior knowledge
%   depends.
%   The coefficient table records the parameters (dim3) for the 10 neurons (dim 1)
%    and 8 angles(dim2).
%
%   Copyright A.L @ Mashed_Potatoes @ ICL. 01/03/12

n_t=size(act_neur,1);
n_a=size(act_neur,2);
n_n=size(act_neur,3);
n_T=size(act_neur,4);

if n_T~=300 && n_n~=10;
    warning('the input may not fit the classical data used for this experiment (10 neurons, 300 ms)');
end

sum_act=sum(act_neur,4);
%USELESS: mean_act=permute(mean_act, [3 2 1]); % Permute the matrix to work in the right dimensions.

% Specifying the number of paramters depending on the method used :

coeff=cell(n_n,n_a);

for i_a=1:n_a
    for i_n=1:n_n % 80 iterations is small enough to avoid any search of array optimisation
        test=sum_act(:,i_a,i_n);
        % USEFUL FOR LATER: [n_r, r]=hist(test,min(test):1:max(test));
        switch method
            case 'kgauss'
                [p_ker act_ker]=ksdensity(test);
        end
        coeff{i_n,i_a}=[act_ker; p_ker];
    end
end

param=struct('method',{method},'coeff',{coeff},'imp',{[]});

end

