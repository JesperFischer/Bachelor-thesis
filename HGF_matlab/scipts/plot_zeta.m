function plot_zeta(u1, sim)

subplot(2,2,1)
dn05 = pp_check(u1,sim,tapas_hgf_binary_pu_tgi_config_test,tapas_unitsq_sgm_config05, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(dn05),3)
s1 = round(std(dn05),3)
title("0.5      "+"mean = "+ m1 + "              sd ="+ s1)


subplot(2,2,2)
dn1 = pp_check(u1,sim,tapas_hgf_binary_pu_tgi_config_test,tapas_unitsq_sgm_config1, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(dn1),3)
s1 = round(std(dn1),3)
title("1      "+"mean = "+ m1 + "              sd ="+ s1)

subplot(2,2,3)
dn5 = pp_check(u1,sim,tapas_hgf_binary_pu_tgi_config_test,tapas_unitsq_sgm_config5, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(dn5),3)
s1 = round(std(dn5),3)
title("5      "+"mean = "+ m1 + "              sd ="+ s1)


subplot(2,2,4)
dn10 = pp_check(u1,sim,tapas_hgf_binary_pu_tgi_config_test,tapas_unitsq_sgm_config10, tapas_hgf_binary_pu_tgi_config_test_optimal)
m1 = round(mean(dn10),3)
s1 = round(std(dn10),3)
title("10      "+"mean = "+ m1 + "              sd ="+ s1)



