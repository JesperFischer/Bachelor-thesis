function y = tgi_joint_sim(r, infStates, p)
% Simulates observations from joint model
    
    % Extract parameters
    tau = p(1);
    b0 = p(2);
    b1 = p(3);
    b2 = p(4);
    sigma_rt = p(5);
       
    % Assumed structure of infStates:
    % dim 1: time (ie, input sequence number)
    % dim 2: HGF level
    % dim 3: 1: muhat, 2: sahat, 3: mu, 4: sa
    % Belief trajectories at 1st level
    x = infStates(:,1,1); 
    n = size(infStates, 1);
    y = NaN(n,2);
 
    % Initialize random number generator
    if isnan(r.c_sim.seed)
        rng('shuffle');
    else
        rng(r.c_sim.seed);
    end
   
    
    for t=1:n
        % choice
        probc = exp(tau * x(t) - logsumexp(tau * [x(t), 1-x(t)]));
        y(t, 1) = binornd(1, probc);

        % RT
        eta = b0 + b1 * (probc - .5)^2 + b2 * t/n;
        y(t,2) = normrnd(eta, sigma_rt);
    end
    return;
end

function rval = logsumexp(x)
    m = max(x);
    rval = m + log(sum(exp(x - m)));
end

