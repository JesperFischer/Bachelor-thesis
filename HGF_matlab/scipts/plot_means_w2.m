function plot_means_w2(u1, sim)
subplot(3,3,1)
omegaw2 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_w2, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegaw2),3)
s1 = round(std(omegaw2),3)
title("2      "+"mean = "+ m1 + "              sd ="+ s1)
subplot(3,3,2)
omegaw0 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_w0, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegaw0),3)
s1 = round(std(omegaw0),3)
title("0      "+"mean = "+ m1 + "              sd ="+ s1)

subplot(3,3,3)
omegawm2 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_wm2, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegawm2),3)
s1 = round(std(omegawm2),3)
title("-2      "+"mean = "+ m1 + "              sd ="+ s1)


subplot(3,3,4)
omegawm4 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_wm4, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegawm4),3)
s1 = round(std(omegawm4),3)
title("-4      "+"mean = "+ m1 + "              sd ="+ s1)


subplot(3,3,5)
omegawm6 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_wm6, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegawm6),3)
s1 = round(std(omegawm6),3)
title("-6      "+"mean = "+ m1 + "              sd ="+ s1)

subplot(3,3,6)

omegawm8 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_wm8, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegawm8),3)
s1 = round(std(omegawm8),3)
title("-8      "+"mean = "+ m1 + "              sd ="+ s1)

subplot(3,3,7)

omegawm10 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_wm10, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegawm10),3)
s1 = round(std(omegawm10),3)
title("-10      "+"mean = "+ m1 + "              sd ="+ s1)

subplot(3,3,8)

omegawm12 = pp_check_obs(u1,sim,tapas_hgf_binary_pu_tgi_config_test_demo_wm12, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(omegawm12),3)
s1 = round(std(omegawm12),3)
title("-12      "+"mean = "+ m1 + "              sd ="+ s1)
