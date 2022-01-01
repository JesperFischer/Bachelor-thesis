%% paths:
addpath('C:\Users\Jespe\OneDrive\Skrivebord\HGF_wksh\HGF_wksh\modified_perceptual_model')
addpath('C:\Users\Jespe\OneDrive\Skrivebord\HGF_wksh\HGF_wksh\Perceptual_model_scripts')
addpath('C:\Users\Jespe\OneDrive\Skrivebord\HGF_wksh\HGF_wksh\Niia\HGFscripts_works\Perceptual model')
addpath('C:\Users\Jespe\OneDrive\Skrivebord\HGF_wksh\HGF_wksh\Perceptual_model_scripts')
addpath('C:\Users\Jespe\OneDrive\Skrivebord\tapas\tapas-master\HGF')
addpath('C:\Users\Jespe\OneDrive\Skrivebord\response models\firstmodel')
addpath('C:\Users\Jespe\OneDrive\Skrivebord\HGF_wksh\HGF_wksh\prepared_data')
addpath('C:\Users\Jespe\OneDrive\Skrivebord\HGF_wksh\HGF_wksh\my joint model')

%% data preperation and analysis
%loading the data:
%two different contingencies wether one has a even or uneven stormdb
%number, further two way to incode TGI trials either as 1's and 0's and
%oppisite of the binary choice responses or as 0.5. We'll use the 1's and
%0's

%code to make data from raw files this is where tgi trials are u != y:
%prep_hgf_data_pain_learning_test_tgi10(74)

%if one wants to use the coding 0.5 for the tgi trials use:
% prep_hgf_data_pain_learning_real_y(74)
%this is where the ratings determine the u for tgi-trial
%then load the files that was created

removers = readmatrix('C:\Users\Jespe\OneDrive\Dokumenter\GitHub\bachelor data analyse\removers_train.csv')
removers = removers(:,2)

prep_hgf_data_pain_learning_dif(74,removers)
%%
data1 = load('C:\Users\Jespe\OneDrive\Skrivebord\TPL\HGF analysis\HGFwksh_TPL_multsub_TGI.mat')
%%
%% Model comparison tool:
p = genpath('C:\Users\Jespe\OneDrive\Skrivebord\HGF_wksh\vba\VBA-toolbox-master')
addpath(p)

%% now that the data is in we can see the two different contingency spaces:
%people with uneven stormdb numbers
plot(data.u(:,1), '.', 'Color', [0 0.6 0], 'MarkerSize', 11)
xlabel('Trial number')
ylabel('u')
axis([1, 320, -0.1, 1.1])
%%
%people with even
plot(data.u(:,2), '.', 'Color', [0 0.6 0], 'MarkerSize', 11)
xlabel('Trial number')
ylabel('u')
axis([1, 320, -0.1, 1.1])

%% checking bayse-optimal
%change id to 2 to see the other contingency space
id = 1;
u2 = data.u(:,id);
u2(:,2) = data.u_cues(:,id);
est = tapas_fitModel([], u2, tapas_hgf_binary_pu_tgi_config_test_demo_kap,tapas_bayes_optimal_binary_config, tapas_quasinewton_optim_config);

tapas_hgf_binary_pu_tgi_plotTraj(est)
%%
id = 1;
u1 = data.u(:,id);
u1(:,2) = data.u_cues(:,id);
%%
id = 2;
u2 = data.u(:,id);
u2(:,2) = data.u_cues(:,id);

%% omega parameter
%deciding upon the best mean for the two contingency space:
plot_means_w2(u1,50)
%% omega parameter
plot_means_w2(u2,50)
%% theta parameter
plot_means_w3(u1,50)
%% theta parameter
plot_means_w3(u2,50)
%% zeta parameter 
plot_zeta(u2,1)
%% pp_check observational parameters
pp_check_obs(u1,10,tapas_hgf_binary_pu_tgi_config_test, tapas_hgf_binary_pu_tgi_config_test_optimal)
%% pp_check response parameter
pp_check(u1,1,tapas_hgf_binary_pu_tgi_config_test,tapas_unitsq_sgm_config, tapas_hgf_binary_pu_tgi_config_test_optimal)
%%
%now we might want to fit our model the participants' actual responses:
id = 1;
u1 = data.u(:,id);
u1(:,2) = data.u_cues(:,id);
y = data.y(:,id);
est = tapas_fitModel(y, u1, tapas_hgf_binary_pu_tgi_config_test,tapas_unitsq_sgm_config, tapas_quasinewton_optim_config);

tapas_hgf_binary_pu_tgi_plotTraj(est)
%% Fitting binary and continous responses at once: (unit_square)
id = 3;
rating = 3; %1 = cold, 2 = warm and 3 = burning
u1 = data.u(:,id);
u1(:,2) = data.u_cues(:,id);
%binary responses
y1 = data.y(:,id);
%ratings
y1(:,2) = sqrt(data.y_conf(:,rating,id));
%z-score standardize ratings
y1(:,2) = (y1(:,2)-nanmean(y1(:,2)))/nanstd(y1(:,2));
%get stimuli
y1(:,3) = data.stim1(:,id);
%get rts for the given rating
y1(:,4) = data.y_conf_rts(:,rating,id);
%this is not nessecary just to check their number
y1(:,5) = data.predacc1(:,id);
storm = data.stormdb1(id);


est = tapas_fitModel_joint(y1, u1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_sa3hat1, tapas_quasinewton_optim_config)
%plotting the trajectory
tapas_hgf_binary_pu_tgi_plotTraj(est)
hold on
plot(1:length(data.u_densProb(:,id)), data.u_densProb(:,id), '-k', 'LineWidth', 2)
%%
tapas_rw_binary_plotTraj(est)
%%
%only binary reponse model:
results_cohort1 = fit_hgf_subject_model_final_with_tgi_all1(data1, {'tapas_hgf_binary_pu_tgi_config_test'}, tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
%%
[sim_cohort1,difomega2_cohort1, difomega3_cohort1,difdn_cohort1] = parameter_recovery(results_cohort1, 'tapas_hgf_binary_pu_tgi_test', 'tapas_unitsq_sgm',tapas_hgf_binary_pu_tgi_config_test, tapas_unitsq_sgm_config,10)

%% data to make the parameter recovery plots
%writematrix(omega2_cohort1,"aomega2_cohort1.csv")
%writematrix(omega3_cohort1,"aomega3_cohort1.csv")
%writematrix(dn_cohort1,"adn_cohort1.csv")   
%writematrix(difomega2_cohort1,"parametr_recovery_omega2_cohort1_dif.csv")
%writematrix(difomega3_cohort1,"parametr_recovery_omega3_cohort1_dif.csv")
%writematrix(difdn_cohort1,"parametr_recovery_dn_cohort1_dif.csv")

%% looking at the predictions of the model vs the actual responses
hist(est.optim.yhat(:,2))
hold on
histogram(est.y(:,2),'FaceColor','r')
%% looking at the residuals
hist(est.optim.res(:,2))

%% Fitting multiple binary decision models
unit_nokap = fit_hgf_subject_model_final_with_tgi(data1, "tapas_hgf_binary_pu_tgi_config_test", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
unit_kap = fit_hgf_subject_model_final_with_tgi(data1, "tapas_hgf_binary_pu_tgi_config_test_kap", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
rw = fit_hgf_subject_model_final_with_tgi(data1, "tapas_rw_binary_config", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
sk = fit_hgf_subject_model_final_with_tgi(data1, "tapas_sutton_k1_binary_config", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());

bor = unit_nokap
bor(:,2) = unit_kap
bor(:,3) = rw
bor(:,4) = sk
[posterior,out] = model_compar(bor)

%%
%writing it to csv to plot in R
qq(:,1) = out.Ef
qq(:,2) = out.ep
csvwrite('qq_cohort1.csv',qq)

%% function to loop through all subjects the last parameter is 1 = ColdRating, 2 = WarmRating 3 = BurnRating.
%the joint (binary and continous) response model is the unit-sqaure
%(binary) and prediction uncertainty on first level predicting the rating you decide upon (continous). 
% est = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config,tapas_quasinewton_optim_config,3)
estmain_unit_rts_trial = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects,tapas_quasinewton_optim_config,3)
estmain_unit_rts = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects2,tapas_quasinewton_optim_config,3)
estmain_unit_stim = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects22,tapas_quasinewton_optim_config,3)
estmain_null = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_null,tapas_quasinewton_optim_config,3)
%% Model comparison for main effects
clear bor
bor = estmain_null
bor(:,2) = estmain_unit_stim
bor(:,3) = estmain_unit_rts
bor(:,4) = estmain_unit_rts_trial
clear lmes
lmes = model_compar(bor)
% therefore no trial only stim and RTS
%% models run on cohort 1
est_unit_sa3hat1 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_sa3hat1,tapas_quasinewton_optim_config,3)
est_unit_sa2hat_envi2 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_sa2hat_envi,tapas_quasinewton_optim_config,3)
est_unit_sa2hat_esti2 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_sa2hat_esti,tapas_quasinewton_optim_config,3)
est_unit_sa1hat1 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config,tgi_joint_config_main_effects_sa3hat1,tapas_quasinewton_optim_config,3)
est_unit_sa2hat1 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_sa2hat1,tapas_quasinewton_optim_config,3)
est_unit_surprise1 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_surprise2,tapas_quasinewton_optim_config,3)
est_unit_mu3 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_mu,tapas_quasinewton_optim_config,3)
est_unit_muhat3 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_mu3hat,tapas_quasinewton_optim_config,3);
est_unit_surprise2 = joint_model_all(data1,tapas_hgf_binary_pu_tgi_config_test,tgi_joint_config_main_effects_surprise2,tapas_quasinewton_optim_config,3)

%% lets look at the omegas (from the perceptual) and the beta estimates from the response model
% what the different beta estimates mean can be seen in the tgi_joint_config_file that made them
beta = beta_main_int(est_unit_sa2hat_envi2)
%%
%seems to be the case that people rate the tgi's a bit higher on the
%burning rating when they get the stimuli while rating (NS)
[h,p,ci,stats] = ttest2(beta(1:34,9),beta(35:58,9))
[h,p,ci,stats] = ttest2(beta(1:34,7),beta(35:58,7))
[h,p,ci,stats] = ttest2(beta(1:34,8),beta(35:58,8))

%% testing cold against warm and cold against tgi and lastly warm against tgi
[h,p,ci,stats] = ttest(beta(:,9),beta(:,7))
[h,p,ci,stats] = ttest(beta(:,9),beta(:,8))
[h,p,ci,stats] = ttest(beta(:,8),beta(:,7))

%% testing interations against 0
[h,p,ci,stats] = ttest(beta(:,9))
[h,p,ci,stats] = ttest(beta(:,8))
[h,p,ci,stats] = ttest(beta(:,7))

%% Cohort 2 and 3
%making csv files to find the outliers in R
make_csv_files_all(274)
%% loading the removers file
removers = readmatrix('C:\Users\Jespe\OneDrive\Dokumenter\GitHub\bachelor data analyse\removers_all.csv')
removers = removers(:,2)
prep_hgf_data_pain_learning_dif1(200,removers)
%%
data = load('C:\Users\Jespe\OneDrive\Skrivebord\TPL\HGF analysis\HGFwksh_TPL_multsub_TGI.mat')

%% fitting multiple binary decision models to find the best
% Different perceptual models only on the binary responses:
unit_nokap_all = fit_hgf_subject_model_final_with_tgi(data, "tapas_hgf_binary_pu_tgi_config_test", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
rw_all = fit_hgf_subject_model_final_with_tgi(data, "tapas_rw_binary_config", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
sk_all = fit_hgf_subject_model_final_with_tgi(data, "tapas_sutton_k1_binary_config", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
unit_kap_all = fit_hgf_subject_model_final_with_tgi(data, "tapas_hgf_binary_pu_tgi_config_test_kap", tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());


bor = unit_nokap_all
bor(:,2) = unit_kap_all
bor(:,3) = rw_all
bor(:,4) = sk_all
clear lmes
[posterior,out] = model_compar(bor)

qq(:,1) = out.Ef
qq(:,2) = out.ep
csvwrite('qq_all.csv',qq)

%% run perceptual model to check the parameter recovery:
results = fit_hgf_subject_model_final_with_tgi_all(data, {'tapas_hgf_binary_pu_tgi_config_all'}, tapas_unitsq_sgm_config(), tapas_quasinewton_optim_config());
%% for multiple participants Results should not come from the joint model :)
[sim,difomega2, difomega3,difdn] = parameter_recovery(results, 'tapas_hgf_binary_pu_tgi_test', 'tapas_unitsq_sgm',tapas_hgf_binary_pu_tgi_config_all, tapas_unitsq_sgm_config_all,10)
%%
for i = 1:length(results)
    omega2(i) = results1{i,1}.p_prc.om(2)
    omega3(i) = results{i,1}.p_prc.om(3)
    dn(i) = results{i,1}.p_obs.ze
end

%%
%writematrix(omega2,"aomega2.csv")
%writematrix(omega3,"aomega3.csv")
%writematrix(dn,"adn.csv")
%writematrix(difomega2,"parametr_recovery_om2_all.csv")
%writematrix(difomega3,"parametr_recovery_om3_all.csv")
%writematrix(difdn,"parametr_recovery_dn_all.csv")


%% Models to be run: firstly the model with both surprise and enviromental uncertainty. 
% OBS remember to change the tau prior and the beta priors! 
est_unit_sa2hat_all = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_all,tgi_joint_config_main_effects_sa2hat_all,tapas_quasinewton_optim_config,3)
est_unit_sa2hat_esti2_all = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_all,tgi_joint_config_main_effects_sa2hat_esti2,tapas_quasinewton_optim_config,3)
est_unit_sa2hat_envi2_all = joint_model_all(data,tapas_hgf_binary_pu_tgi_config_all,tgi_joint_config_main_effects_sa2hat_envi2,tapas_quasinewton_optim_config,3)

%% first column is decision noise, second is omega, third is theta
sa2hat = omega(est_unit_sa2hat_all)
esti = omega(est_unit_sa2hat_esti2_all)
envi = omega(est_unit_sa2hat_envi2_all)
%%
mean(sa2hat(:,1))
std(sa2hat(:,1))

%% wrting the csv files to R to test the hypothese
betasa = beta_main_int(est_unit_sa2hat_all)
betaesti = beta_main_int(est_unit_sa2hat_esti2_all)
betaenvi = beta_main_int(est_unit_sa2hat_envi2_all)

csvwrite('betasa.csv',betasa)
csvwrite('betaesti.csv',betaesti)
csvwrite('betaenvi.csv',betaenvi)

%%
beta = beta_main_int(est_unit_sa2hat_envi2)