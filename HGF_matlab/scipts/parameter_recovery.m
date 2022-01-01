%% Recovery of parameters given subject data
function [sim, difomega2, difomega3,difdn] = parameter_recovery(results, perceptual, response,perceptual_config,response_config,n)

n1 = 1:n
sim = cell(length(results),length(n1));
difomega2 = zeros(length(results),length(n1));
difomega3 = zeros(length(results),length(n1));
difdn = zeros(length(results),length(n1));

for k = 1:n
    display(k)
    
    for i = 1:size(results)
       
        try
            sim1 = tapas_simModel(results{i,1}.u, perceptual, [NaN 0 1 NaN 1 1 NaN 0 0 1 1 NaN results{i, 1}.p_prc.om(2) results{i, 1}.p_prc.om(3)], response, results{i, 1}.p_obs.ze);
            sim{i,k} = tapas_fitModel(sim1.y,sim1.u,perceptual_config,response_config,tapas_quasinewton_optim_config);
            
            
            difomega2(i,k) = results{i, 1}.p_prc.om(2)-sim{i, k}.p_prc.om(2);
            difomega3(i,k) = results{i, 1}.p_prc.om(3)-sim{i, k}.p_prc.om(3);
            difdn(i,k) = results{i, 1}.p_obs.ze-sim{i, k}.p_obs.ze;
            
        catch
            sim{i,k} = NaN;
        end
       
        
 end
end
end