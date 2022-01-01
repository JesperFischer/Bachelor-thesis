
function [logp, yhat, res] = tgi_joint_main_effects_mu3(r, infStates, ptrans)
    % Evaluate log-likelihood of observations 
    
    % there have to be two columns -> [choice, RT]
%     assert(size(r.y, 2) > 2)
    
    % Extract and transform parameters to native space
%     tau = exp(ptrans(1));
    be0 = ptrans(1);
    be1 = ptrans(2);
    be2 = ptrans(3);
    be3 = ptrans(4);
    be4 = ptrans(5);
%     be5 = ptrans(7);
%     be6 = ptrans(8);
%     be7 = ptrans(9);
%     be8 = ptrans(10);
    sigma_rt = exp(ptrans(6));
     
    
    sa1hat = infStates(:,1,2);
    bernv = sa1hat;
    bernv(r.irr2) = [];
    % Initialize returned log-probabilities, predictions,
    % and residuals as NaNs so that NaN is returned for all
    % irregualar trials
    n = size(infStates,1);
    logp = NaN(n,1);
    yhat = NaN(n,2);
    res  = NaN(n,2);
    
mu3hat = infStates(:,3,1);
mu3hat(r.irr) = [];    
tau = exp(-mu3hat);
    
stim = r.y(:,3);
stim(r.irr2) = [];

for i = 1:length(stim);
if stim(i,1) == 0;
    stim(i,2) = 1;
    stim(i,3) = 0;
    stim(i,4) = 0;
elseif stim(i,1) == 1;
    stim(i,2) = 0;
    stim(i,3) = 1;
    stim(i,4) = 0;
else
    stim(i,2) = 0;
    stim(i,3) = 0;
    stim(i,4) = 1;
end
end

rts = r.y(:,4);
rts(r.irr2)=[];
    
    
    
x = infStates(:,1,1);
x(r.irr) = [];       
y1 = r.y(:,1);
y1(r.irr) = [];
y2 = r.y(:,2);
y2(r.irr2) = [];    


            
%             % choice
%             probc = exp(tau * x(t) - logsumexp(tau * [x(t), 1-x(t)]));
%             llc = log(binopdf(y(t,1), 1, probc));
%             yhat(t, 1) = y(t,1) * probc + (1 - y(t,1)) * (1 - probc);
%             res(t, 1) = (y(t,1) - yhat(t, 1)) / sqrt(yhat(t, 1) * (1 - yhat(t, 1)));

logx = log(x);
log1pxm1 = log1p(x-1);
logx(1-x<1e-4) = log1pxm1(1-x<1e-4);
log1mx = log(1-x);
log1pmx = log1p(-x);
log1mx(x<1e-4) = log1pmx(x<1e-4); 

% Calculate log-probabilities for non-irregular trials
reg = ~ismember(1:n,r.irr);
logp(reg) = y1.*tau.*(logx -log1mx) +tau.*log1mx -log((1-x).^tau +x.^tau);
yhat(reg) = x;
res(reg) = (y1-x)./sqrt(x.*(1-x));
            
%             % RT
%             eta = b0 + b1 * bernv(t);
% %           eta = b0;
%             llrt = log(normpdf(y(t,2), eta, sigma_rt));
%             yhat(t, 2) = eta;
%             res(t, 2) = (y2(t,2) - yhat(t,2)) / sqrt(sigma_rt);
%            
%             logp(t) = llc + llrt;
trial = 1:306;
trial = trial';
trial(r.irr2) = [];
logrt = be0+be1.*trial+be2*rts+be3.*stim(:,3)+be4.*stim(:,4);

% Calculate log-probabilities for non-irregular trials
% Note: 8*atan(1) == 2*pi (this is used to guard against
% errors resulting from having used pi as a variable).
reg = ~ismember(1:n,r.irr2);
logp(reg) = logp(reg)-1/2.*log(8*atan(1).*sigma_rt) -(y2-logrt).^2./(2.*sigma_rt);
yhat(reg,2) = logrt;
res(reg,2) = y2-logrt;




    return;
end

function rval = logsumexp(x)
    m = max(x);
    rval = m + log(sum(exp(x - m)));
end
