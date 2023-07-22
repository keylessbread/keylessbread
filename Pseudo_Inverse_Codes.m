%Homework 2 functions:
classdef HW3
    methods
%Design Matrix X
        function [X] = dummy_mtx(x)
            X = [ones(1,12);x']';
        end

%Psuedo-Inverse of X;
        function [w_0,w_1] = psuedo_inv(X)
            w=pinv((X'*X))*X'*t;
            w_0 = w(1);
            w_1 = w(2);
        end

%Correlation between 2 columns
        function [C] = corr(x,t) 
            E_xt=cov(x,t);
            sd_x=sqrt(var(x));
            sd_t=sqrt(var(t));
            C=(E_xt)/(sd_x*sd_t);
        end
%Variance 
        function [E_2]= var_pred (x,w)
            (w(1)+w(2)*x);
            var_pred=sum((y_pred-t).^(2))/length(x);
        end
    end
end

