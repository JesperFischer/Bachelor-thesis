
function pstruct = tgi_joint_namep(pvec)
    pstruct = struct;
    pstruct.tau = pvec(1);
    pstruct.b0 = pvec(2);
    pstruct.b1 = pvec(3);
    pstruct.b2 = pvec(4);
    pstruct.sigma_rt = pvec(5);
    return;
end


