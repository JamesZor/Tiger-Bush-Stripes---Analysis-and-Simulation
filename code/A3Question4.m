%clear
clear all, close all, clc
% Question 4.
% function
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

% set parametes
p=[8,20,2];
k= linspace(-2,2,1000);
% Plot dispersion relation (with inset around k=0);
 figure, hold on;
 plot(k,rel1(k,p(1),p(2),p(3)),'DisplayName','Re \lambda_1');  
 plot(k,rel2(k,p(1),p(2),p(3)),'DisplayName','Re \lambda_2');
 plot(k,imag1(k,p(1),p(2),p(3)),'DisplayName','Im \lambda_1');
 plot(k,imag2(k,p(1),p(2),p(3)),'DisplayName','Im \lambda_2');
 hold off; grid on; ylim([-4 4]); xlabel('k');
 lgd = legend; lgd.Location = 'northoutside'; lgd.NumColumns = 3;
 drawnow;
%
% Fin
