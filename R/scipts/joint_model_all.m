function [est] = joint_model_all(data, perceptual_config, response_config, optim_config,rate)

%% Run HGF multiple subjects and compare models
%%
% Initialize output - One model for each subject
%%
est = cell(size(data.u,2),length(perceptual_config));


for subject_idx=1:size(data.u,2);
        
        u(:,1) = data.u(:,subject_idx);
        u(:,2) = data.u_cues(:,subject_idx); %TGI
        des_prob = data.u_densProb(:,subject_idx);
        y = data.y(:,subject_idx);
        y(:,2) = sqrt(data.y_conf(:,rate,subject_idx));
        y(:,2) = (y(:,2)-nanmean(y(:,2)))/nanstd(y(:,2));
        y(:,3) = data.stim1(:,subject_idx);
        y(:,4) = data.y_conf_rts(:,rate,subject_idx);
        y(:,5) = data.predacc1(:,subject_idx);
        try
            est{subject_idx} = tapas_fitModel_joint(y, u, perceptual_config, response_config, optim_config);
            
        catch
            est{subject_idx} = NaN;
        end 
        h = subject_idx
    end


