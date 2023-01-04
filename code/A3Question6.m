%% Question 6
%clear
clear all, close all, clc
L=15.7;
p=[7,20,2];

% Instantiating periodic differentiation matrix
nx = 1500; [x,Dx,Dxx] = PeriodicDiffMat([-L,L],nx);

% % Initial condition (steady state + perburbation)
e = ones(size(x)); z0 = [p(1)*e; e/p(1)];
% z0 = z0 + 0.01*[sin(2*pi/10*x); sin(2*pi/20*x)];
z0 = z0 + 1*[cos(4*pi/L*x); e];
%
% % Time step
 rhs = @(t,z) tigerbush(z,p,Dx,Dxx);
jac = @(t,z) tigerbushJacobian(z,p,Dx,Dxx);
opts = odeset('Jacobian',jac);
tSpan = [0:0.1:50];
[t,ZHist] = ode15s(rhs,tSpan,z0,opts);

% Space-time plot
 PlotHistory(x,t,ZHist,p,[]);
%
% Plot final state
figure; title('Final state');
plot(x,ZHist(end,1:nx),x,ZHist(end,nx+1:2*nx));
xlabel('x'); legend({'V','W'});

function [F, DFDZ] = tigerbush(z, p,Dx, Dxx)

      % Rename parameters
      a =p(1); b=p(2); c=p(3);

      % Ancillary variables and solution split
      nx=length(z)/2;
      iU=1:nx;
      iV=nx+iU;
      v = z(iU);
      w = z(iV);
      
      % Function handles
      f     = @(v,w) - v.*c + w.*v.^2;
      dfdv  = @(v,w) -c + 2.* w.*v;
      dfdw  = @(v,w) v.^2;
      
      g     =@(v,w) a-w-w.*v.^2;
      dgdv  =@(v,w) -2.*w.*v;
      dgdw  =@(v,w) -1-v.^2;

      % Right-hand side
      F=zeros(size(z));
      F(iU) = Dxx*v + f(v,w);
      F(iV) = b*Dx*w + g(v,w);

  if nargout > 1
    DFDZ = spdiags([],[],2*nx,2*nx);
    DFDZ(iU,iU) =   Dxx + spdiags(dfdv(v,w),0,nx,nx);
    DFDZ(iU,iV) =         spdiags(dfdw(v,w),0,nx,nx);
    DFDZ(iV,iU) =         spdiags(dgdv(v,w),0,nx,nx);
    DFDZ(iV,iV) = b*Dx + spdiags(dgdw(v,w),0,nx,nx);
  end
end

function DFDZ = tigerbushJacobian(z,p,Dx, Dxx)
      [~, DFDZ ] =tigerbush(z,p,Dx,Dxx);
end
function [x,Dx,Dxx] = PeriodicDiffMat(xSpan,nx)

      % Gridpoints
      a = xSpan(1); b = xSpan(2);
      hx = (b-a)/nx;
      x = a+[0:nx-1]'*hx;

      % Auxiliary vecor
      e = ones(nx,1);

      % First order differentiation matrix
      Dx = spdiags([-e e],[-1 1],nx,nx);
      Dx(1,nx) =  -1; Dx(nx,1) = 1;
      Dx = Dx/(2*hx);
 
      % Second order differentiation matrix
      Dxx = spdiags([e -2*e e],-1:1,nx,nx);
      Dxx(1,nx) = 1; Dxx(nx,1) = 1; 
      Dxx = Dxx/(hx^2);

end

function plotHandle = PlotHistory(x,t,U,p,parentHandle)

  numComp = 2;
  nx = size(U,2)/2;

  %% Assign solution label
  solLabel(1).name = "U";
  solLabel(2).name = "V";

   %% Position and eventually grab figure
   if isempty(parentHandle)
     %scrsz = get(0,'ScreenSize');
     % plotHandle = figure('Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/4 scrsz(4)/4]);
     plotHandle = figure();
     parentHandle = plotHandle;
    else
      plotHandle = parentHandle;
   end
   figure(parentHandle);

   %% Grid
   [T,X] = meshgrid(t,x);

   %% Plots
   for k = 1:numComp
     subplot(1,numComp,k)
     % pcolor(X,T,U(:,idx(:,k))'); shading interp; view([0 90]);
     surf(X,T,U(:,nx*(k-1)+[1:nx])'); shading interp; view([0 90]);
     title(solLabel(k).name);
     xlabel('x'); ylabel('t');
   end

   %% Save
   % print -dtiff history.tiff

end

