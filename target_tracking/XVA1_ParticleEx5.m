function [StdErr, EKFErr] = ParticleEx5

% EKF Particle filter example.
% Track a body falling through the atmosphere.
% This system is taken from [Jul00], which was based on [Ath68].
% Compare the particle filter with the EKF particle filter.

global rho0 g k dt

rho0 = 20; % lb-sec^2/ft^4
g = 3.2; % ft/sec^2
k = 5; % ft
R = 1; % measurement noise variance (ft^2)
Q = diag([0 0 0]); % process noise covariance
M = 100; % horizontal range of position sensor
a = 100; % altitude of position sensor
P = diag([1e6 4e6 10]); % initial estimation error covariance

x = [0;0;0]; % initial state
xhat = [0;0;0]; % initial state estimate

N = 200; % number of particles  

% Initialize the particle filter.
for i = 1 : N

    xhatplusEKF(:,i) =  x + sqrt(P) * [randn; randn; randn]; % EKF particle filter
    Pplus(:,:,i) = P; % initial EKF particle filter estimation error covariance
end

T = 0.5; % measurement time step
randn('state',sum(100*clock)); % random number generator seed

tf = 30; % simulation length (seconds)
dt = 0.5; % time step for integration (seconds)
xArray = x;
%xhatArray = xhat;
xhatEKFArray = xhat;

w=.1;
a=100;

for t = T : T : tf
    fprintf('.');
    % Simulate the system.
    for tau = dt : dt : T
        % Fourth order Runge Kutta ingegration
        [dx1, dx2, dx3, dx4] = RungeKutta(x);
        x = x + (dx1 + 2 * dx2 + 2 * dx3 + dx4) / 9;
        x = x + sqrt(dt * Q) * [randn; randn; randn] * dt;
    end
    
   x=[a*sin(w*t); a*w*cos(w*t)'; -a*w^2*sin(w*t)];
    
    % Simulate the noisy measurement.
    z = sqrt(M^2 + (x(1)-a)^2) + sqrt(R) * randn;
    % Simulate the continuous-time part of the particle filters (time update).
       xhatminusEKF = xhatplusEKF;
    for i = 1 : N
        for tau = dt : dt : T
            % Fourth order Runge Kutta ingegration
         
            [dx1, dx2, dx3, dx4] = RungeKutta(xhatminusEKF(:,i));
            xhatminusEKF(:,i) = xhatminusEKF(:,i) + (dx1 + 2 * dx2 + 2 * dx3 + dx4) / 6;
            xhatminusEKF(:,i) = xhatminusEKF(:,i) + sqrt(dt * Q) * [randn; randn; randn] * dt;
            xhatminusEKF(3,i) = max(0, xhatminusEKF(3,i)); % the ballistic coefficient cannot be negative
        end
        % standard particle filter
        %zhat = sqrt(M^2 + (xhatminus(1,i)-a)^2);
        
        
        %vhat(i) = z - zhat;
        % EKF particle filter
        zhatEKF = sqrt(M^2 + (xhatminusEKF(1,i)-a)^2);
        F = [0 1 0; -rho0 * exp(-xhatminusEKF(1,i)/k) * xhatminusEKF(2,i)^2 / 2 / k * xhatminusEKF(3,i) ...
            rho0 * exp(-xhatminusEKF(1,i)/k) * xhatminusEKF(2,i) * xhatminusEKF(3,i) ...
            rho0 * exp(-xhatminusEKF(1,i)/k) * xhatminusEKF(2,i)^2 / 2; ...
            0 0 0];
        H = [(xhatminusEKF(1,i) - a) / sqrt(M^2 + (xhatminusEKF(1,i)-a)^2) 0 0];
        Pminus(:,:,i) = F * Pplus(:,:,i) * F' + Q;
        K = Pminus(:,:,i) * H' * inv(H * Pminus(:,:,i) * H' + R);
        xhatminusEKF(:,i) = xhatminusEKF(:,i) + K * (z - zhatEKF);
        zhatEKF = sqrt(M^2 + (xhatminusEKF(1,i)-a)^2);
        vhatEKF(i) = z - zhatEKF;
    end
    % Note that we need to scale all of the q(i) probabilities in a way
    % that does not change their relative magnitudes.
    % Otherwise all of the q(i) elements will be zero because of the
    % large value of the exponential.

    vhatscaleEKF = max(abs(vhatEKF)) / 4;
    qsumEKF = 0;
    for i = 1 : N
        qEKF(i) = exp(-(vhatEKF(i)/vhatscaleEKF)^2);
        qsumEKF = qsumEKF + qEKF(i);
    end
    % Normalize the likelihood of each a priori estimate.
    for i = 1 : N
        qEKF(i) = qEKF(i) / qsumEKF;
    end

    Ptemp = Pplus;
    for i = 1 : N
        u = rand; % uniform random number between 0 and 1
        qtempsum = 0;
        for j = 1 : N
            qtempsum = qtempsum + qEKF(j);
            if qtempsum >= u
                %%apply constraints here
                
                xhatplusEKF(:,i) = xhatminusEKF(:,j);
                %xhatplusEKF(3,i) = max(0,xhatplusEKF(3,i)); % the ballistic coefficient cannot be negative
                Pplus(:,:,i) = Ptemp(:,:,j);
                break;
            end
        end
    end
    % The EKF particle filter estimate is the mean of the particles.
    xhatEKF = mean(xhatplusEKF')';
    % Save data for plotting.
    xArray = [xArray x];
    %xhatArray = [xhatArray xhat];
    xhatEKFArray = [xhatEKFArray xhatEKF];
end

close all;
t = 0 : T : tf;

figure;
plot(t, xArray(1,:),t,xhatEKFArray(1,:),'--');
set(gca,'FontSize',12); set(gcf,'Color','White');
xlabel('Seconds');
ylabel('True Position');


function [dx1, dx2, dx3, dx4] = RungeKutta(x)
% Fourth order Runge Kutta integration for the falling body system.
global rho0 g k dt
dx1(1,1) = x(2);
dx1(2,1) = rho0 * exp(-x(1)/k) * x(2)^2 / 2 * x(3) - g;
dx1(3,1) = 0;
dx1 = dx1 * dt;
xtemp = x + dx1 / 2;
dx2(1,1) = xtemp(2);
dx2(2,1) = rho0 * exp(-xtemp(1)/k) * xtemp(2)^2 / 2 * xtemp(3) - g;
dx2(3,1) = 0;
dx2 = dx2 * dt;
xtemp = x + dx2 / 2;
dx3(1,1) = xtemp(2);
dx3(2,1) = rho0 * exp(-xtemp(1)/k) * xtemp(2)^2 / 2 * xtemp(3) - g;
dx3(3,1) = 0;
dx3 = dx3 * dt;
xtemp = x + dx3;
dx4(1,1) = xtemp(2);
dx4(2,1) = rho0 * exp(-xtemp(1)/k) * xtemp(2)^2 / 2 * xtemp(3) - g;
dx4(3,1) = 0;
dx4 = dx4 * dt;
return;