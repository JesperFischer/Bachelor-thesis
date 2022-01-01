

function c = tgi_joint_config_main_effects_surprise2(m)
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
c.be0mu = -0.37; 
c.be0sa = 0.74;

%Beta_1
c.be1mu = 0.5;
c.be1sa = 1;

% % Beta_2
c.be2mu = -0.17; 
c.be2sa = 0.65;
% 
% % % Beta_3
c.be3mu = -0.57; 
c.be3sa = 0.59;
% 
% Beta_4
c.be4mu = 0.37; 
c.be4sa = 0.72;

% Beta_5
c.be5mu = -0.01; 
c.be5sa = 0.36;

% Beta_6
c.be6mu = -0.02; 
c.be6sa = 0.75;

% Beta_7
c.be7mu = 0.02; 
c.be7sa = 0.61;

% Beta_8
c.be8mu = -0.004; 
c.be8sa = 0.76;

% % Beta_9
% c.be9mu = 0; 
% c.be9sa = 2;
% 
% % Beta_10
% c.be10mu = 0; 
% c.be10sa = 2;
% 
% % Beta_11
% c.be11mu = 0; 
% c.be11sa = 2;
% 
% % Beta_12
% c.be12mu = 0; 
% c.be12sa = 2;



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
    c.logsigma_rtsa
         ];
   
    
    % Model filehandle
    c.obs_fun = @tgi_joint_main_effects_tgi_surprise2;
    % Handle to function that transforms observation parameters to their native space
    % from the space they are estimated in
    c.transp_obs_fun = @tgi_joint_transp_main_effects_sa3hat;
    return;
end
