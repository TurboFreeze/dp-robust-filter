% from "Privacy-preserving Statistical Estimation with Optimal Convergence
% Rates"
% implementation of  PrivateQuantile

function [ privQuantile ] = privateQuantile(Z, alpha, epsilon, Lambda)
    Zsorted = sort(Z);
    % winsorize
    Zsorted(Zsorted < -Lambda / 2) = -Lambda / 2;
    Zsorted(Zsorted > Lambda / 2) = Lambda / 2;
    k = length(Zsorted);
    Zsorted = [-Lambda/2 Zsorted Lambda/2];

    % probability for draws
    y = (Zsorted(2:end) - Zsorted(1:end-1)).*exp(-epsilon * abs((0:k) - alpha * k));
    loc = randsample(k + 1, 1, true, y);
    
    privQuantile = (Zsorted(loc + 1) - Zsorted(loc)) * rand(1) + Zsorted(loc);
    