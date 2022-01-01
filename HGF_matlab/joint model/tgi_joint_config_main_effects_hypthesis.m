

function c = tgi_joint_config_main_effects_hypthesis(m)
    c = struct;

    % Model name
    c.model = 'tgi_joint';
   
    %
    % Choice model
    %
    % tau: inverse-temperature
    c.logtaumu = log(5);
    c.logtausa = 2;
    
    %
    % RT model
    %
% Beta_0
c.be0mu = -0.2529; 
c.be0sa = 1.5;

%Beta_1
c.be1mu = 0.57;
c.be1sa = 0.93;

% % Beta_2
c.be2mu = -0.24; 
c.be2sa = 0.85;
% 
% % % Beta_3
c.be3mu = -0.2; 
c.be3sa = 1;
% 
% Beta_4
c.be4mu = 0.15; 
c.be4sa = 1.07;

% Beta_5
c.be5mu = 0.01; 
c.be5sa = 0.49;

% Beta_6
c.be6mu = -0.62; 
c.be6sa = 2.4;

% Beta_7
c.be7mu = 0.06; 
c.be7sa = 0.38;

% Beta_8
c.be8mu = -0.13; 
c.be8sa = 0.45;

% Beta_9
c.be9mu = 0.08; 
c.be9sa = 0.56;

% Beta_10
c.be10mu = -0.4; 
c.be10sa = 1.7;

% Beta_11
c.be11mu = -0.06; 
c.be11sa = 1.6;

% Beta_12
c.be12mu = -0.17; 
c.be12sa = 2;



% sigma_rt: intercept
c.logsigma_rtmu = log(0.5);
c.logsigma_rtsa = 0.7;
    
    
% Gather prior settings in vectors
c.priormus = [
    c.logtaumu,...
    c.be0mu,...
    c.be1mu,...
    c.be2mu,...
    c.be3mu,...
    c.be4mu,...
    c.be5mu,...
    c.be6mu,...
    c.be7mu,...
    c.be8mu,...
    c.be9mu,...
    c.be10mu,...
    c.be11mu,...
    c.be12mu,...
    c.logsigma_rtmu
         ];

c.priorsas = [
    c.logtausa,...
    c.be0sa,...
    c.be1sa,...
    c.be2sa,...
    c.be3sa,...
    c.be4sa,...
    c.be5sa,...
    c.be6sa,...
    c.be7sa,...
    c.be8sa,...
    c.be9sa,...
    c.be10sa,...
    c.be11sa,...
    c.be12sa,...
    c.logsigma_rtsa
         ];
   
    
    % Model filehandle
    c.obs_fun = @tgi_joint_main_effects_tgi_hypthesis;
    % Handle to function that transforms observation parameters to their native space
    % from the space they are estimated in
    c.transp_obs_fun = @tgi_joint_transp_main_effects_hypthesis;
    return;
end
