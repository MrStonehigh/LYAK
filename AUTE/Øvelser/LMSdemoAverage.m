% LMSdemoAverage.m
%
% average over M runs



%% 

N=3000; % number of samples
M=100; % number of runs
errorMatrix=zeros(N,M);

%% LMS algorithm parameters

Ntap=5;         % number of taps in the adaptive filter
mu=0.001;      % for this exercise: just guess a good value for mu


for m=1:M
    
    % reset data and filter 
    x=randn(N,1);
    d=filter([1 0.25 -0.5 0.2 0.3],1,x);
    %d=d+randn(N,1); % add noise

    w=zeros(Ntap,N);% nTap by N matrix, weight vector in columns
    e=zeros(N,1);   % array to store the error signal
    y=zeros(N,1);   % output array
    
    %% the LMS loop
    for k=Ntap:N
        xk=flipud(x(k-Ntap+1:k));      % extract x(k) with elements in the correct order
        y(k)=w(:,k)'*xk;               % do the FIR-filtering to get y(k)
        e(k)=d(k)-y(k);                % calculate the error
        w(:,k+1)=w(:,k)+2*mu*e(k)*xk; % update with LMS algorithm
    end
    
    errorMatrix(:,m)=e.^2;
    
end

%% plot the results

e=mean(errorMatrix,2);
figure(1)
plot(e)   % square the error to avoid alternating between + and -
xlabel('iteration number')
ylabel('error signal')
title('evolution of error signal')

%%
figure(2)
q=1:N;
plot(q,w(1,q),q,w(2,q),q,w(3,q))  % plot the 3 first w's
xlabel('iteration number')
ylabel('filter coefficients')
legend('w(0)','w(1)','w(2)')
title('evolution of filter coefficients')

