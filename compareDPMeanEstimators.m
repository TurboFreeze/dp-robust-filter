%Generates Figure 1 from paper
clear
eps = 0.1;
cher = 2.5;

C = 0.5;
dpeps = 1.0;

dpFilterErr = [];
dpWinsorizeErr = [];
sampErr = [];
noisySampErr = [];
ds = 100:50:400;

N = 100000;
for d = ds
    fprintf('Training with dimension = %d, number of samples = %d \n', d, round(N, 0))
    sumDPFilterErr = 0;
    sumDPWinsorizeErr = 0;
    sumSampErr = 0;
    sumNoisySampErr = 0;
    
    % set tau
    tau = 1 / N;

    X =  mvnrnd(zeros(1,d), eye(d), round((1-eps)*N)) + ones(round((1-eps)*N), d);

    fprintf('Sampling Error w/o noise...');
    sumSampErr = sumSampErr + norm(mean(X) - ones(1,d));
    fprintf('done\n')

    Y1 = randi([0 1], round(0.5*eps*N), d); 
    Y2 = [12*ones(round(0.5*eps*N),1), -2 * ones(round(0.5*eps*N), 1), zeros(round(0.5 * eps * N), d-2)];
    X = [X; Y1; Y2];

    fprintf('Sampling Error with noise...');
    sumNoisySampErr = sumNoisySampErr + norm(mean(X) - ones(1,d));
    fprintf('done\n')
    
    
    fprintf('DP Winsorized...')
    winsorizeOut = [];
    for col=1:d
        winsorizeOut = [winsorizeOut dpWinsorizedMean(X(:, col).', dpeps / d, 100000)];
    end
    sumDPWinsorizeErr = sumDPWinsorizeErr + norm(winsorizeOut - ones(1, d));
    fprintf('done\n')
    
    fprintf('DP Filter...')
    sumDPFilterErr = sumDPFilterErr + norm(dpFilterGaussianMean(X, eps, tau, cher, C, dpeps) - ones(1, d));
    fprintf('done\n')

    dpFilterErr = [dpFilterErr sumDPFilterErr];
    dpWinsorizeErr = [dpWinsorizeErr sumDPWinsorizeErr];
    sampErr = [sampErr sumSampErr];
    noisySampErr = [noisySampErr sumNoisySampErr];
end

dpFilterErr = dpFilterErr - sampErr;
dpWinsorizeErr = dpWinsorizeErr - sampErr;
noisySampErr = noisySampErr - sampErr;

semilogy(ds, dpFilterErr, '-ro', ds, dpWinsorizeErr, '-.b', 'LineWidth', 2)
title(strcat('Size: ', num2str(N), ', Gamma: ', num2str(eps)))
xlabel('Dimension')
ylabel('Excess L2 error')
legend('DP Filter', 'DP Winsorized') %'Sampling Error (with noise)',