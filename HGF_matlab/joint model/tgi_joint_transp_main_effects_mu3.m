
function [pvec, pstruct] = tgi_joint_transp_main_effects_mu3(r, ptrans)
    pvec    = NaN(1,length(ptrans));
    pstruct = struct;

%     pvec(1)    = exp(ptrans(1));    % tau
%     pstruct.tau = pvec(1);
    pvec(1)    = ptrans(1);         % b0
    pstruct.be0 = pvec(1);
    pvec(2)    = ptrans(2);         % b1
    pstruct.be1 = pvec(2);
    pvec(3)    = ptrans(3);         % b2
    pstruct.be2 = pvec(3);
    pvec(4)    = ptrans(4);         % b3
    pstruct.be3 = pvec(4);
    pvec(5)    = ptrans(5);         % b4
    pstruct.be4 = pvec(5);
%     pvec(7)    = ptrans(7);         % b5
%     pstruct.be5 = pvec(7);
%     pvec(8)    = ptrans(8);         % b6
%     pstruct.be6 = pvec(8);
%     pvec(9)    = ptrans(9);         % b7
%     pstruct.be7 = pvec(9);
%     pvec(10)   = ptrans(10);         % b8
%     pstruct.be8 = pvec(10);
    pvec(6)    = ptrans(6);         % sigma_rt
    pstruct.sigma_rt = pvec(6);
    
    
    return;
end

