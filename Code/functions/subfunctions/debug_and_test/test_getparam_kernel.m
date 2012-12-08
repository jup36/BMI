function [ h ] = test_getparam_kernel( act_neur, method, fig )
%TEST_GETPARAM_LL Summary of this function goes here
%   Detailed explanation goes here

if nargin<3
    fig=1;
end

[ param ] = getparam( act_neur, method );

n_t=size(act_neur,1);
n_a=size(act_neur,2);
n_n=size(act_neur,3);
n_T=size(act_neur,4);

sum_act=sum(act_neur,4);

% figure(fig);
% clf;

for i_a=1:n_a
    for i_n=1:n_n
        test=sum_act(:,i_a,i_n);
        [n_r, r]=hist(test,min(test):1:max(test));
        figure(fig*10+i_n); % MULTI WINDOWS version
        subplot(2,4,i_a);
        % subplot(n_n,n_a,(i_n-1)*n_a+i_a); % ONE WINDOW version
        %DEBUG: title(['i_n ' num2str(i_n) ',i_a ' num2str(i_a) ]); 
        hold on
        bar(r,n_r);
        switch param.method
            case 'kgauss'
                plot(param.coeff{i_n,i_a}(1,:),param.coeff{i_n,i_a}(2,:)*100);
        end
    end
end   


end

