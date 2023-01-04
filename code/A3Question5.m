%% Question 5 - pattern-forming instability
% Clear
clear all, close all, clc

% functions
mu      = @(a,c) (a+sqrt(a^2-4.*c^2))/(2.*c);
tau   = @(k,a,b,c) -1 +c + i.*b.*k-k.^2-mu(a,c).^2;
delta   = @(k,a,b,c) k.^(2) .* (1- i.*b.*k + mu(a,c).^2)
                            + c.*(-1+i.*b.*k+mu(a,c).^2);
lambda1 = @(k,a,b,c) (tau(k,a,b,c)-sqrt(tau(k,a,b,c).^2
                                - 4.*delta(k,a,b,c)))/2;
lambda2 = @(k,a,b,c) (tau(k,a,b,c)+sqrt(tau(k,a,b,c).^2
                                - 4.*delta(k,a,b,c)))/2;

rel1 = @(k,a,b,c) real(lambda1(k,a,b,c));
rel2 = @(k,a,b,c) real(lambda2(k,a,b,c));
imag1 = @(k,a,b,c) imag(lambda1(k,a,b,c));
imag2 = @(k,a,b,c) imag(lambda2(k,a,b,c));

% set parameters,
p=[20,2]; % beta , gamma
alpha=[7,8]; %alpha
k=linspace(-2,2,1000);

%
 figure, hold on;
 plot(k,rel2(k,alpha(1),p(1),p(2)),'DisplayName','Re \lambda_2 with \alpha=7');  
 plot(k,rel2(k,alpha(2),p(1),p(2)),'DisplayName','Re \lambda_2 with \alpha=8');
 plot(k,imag2(k,alpha(1),p(1),p(2)),'DisplayName','Im \lambda_2 with \alpha=7');
 plot(k,imag2(k,alpha(2),p(1),p(2)),'DisplayName','Im \lambda_2 with \alpha=8');
 plot(k,zeros(1,1000),'DisplayName','zero axis');
 hold off; grid on; ylim([-3 2]); xlabel('k');
 lgd = legend; lgd.Location = 'northoutside'; lgd.NumColumns = 3;
 drawnow;

% Find when k such that lambda 2 obtains local max on [0,2]
maxrel1 = @(x) rel2(x,alpha(1),p(1),p(2));
[~,kMax] =fminmax(maxrel1 , 0, 2);
lambda2Max = lambda2(kMax, alpha(1),p(1),p(2));

% Wave length 
waveLength = 2*pi / kMax
% Wave propagation 
wavePropagation = - imag(lambda2Max) / kMax 
% function to find max and min of a function 
function [min, max] = fminmax(f, lowerbound, upperbound)
    min = fminbnd(f, lowerbound, upperbound);
    max = fminbnd(@(x) -f(x), lowerbound, upperbound);
end

