function [colW_L1Cp, colW_L1Cd] = fgPRN_GPSL1C(nPRNNo)
    if nPRNNo > 63
        error('GPS L1C PRN No. is lower than 64');
    end
    
    % L1Cp
    % Phase difference(w) and Insertion point(p)
    nIdxL1CpWeil = [5111; 5109; 5108; 5106; 
                    5103; 5101; 5100; 5098;
                    5095; 5094; 5093; 5091;
                    5090; 5081; 5080; 5069;
                    5068; 5054; 5044; 5027;
                    5026; 5014; 5004; 4980;
                    4915; 4909; 4893; 4885;
                    4832; 4824; 4591; 3706;
                    5092; 4986; 4965; 4920;
                    4917; 4858; 4847; 4790;
                    4770; 4318; 4126; 3961;
                    3790; 4911; 4881; 4827;
                    4795; 4789; 4725; 4675;
                    4539; 4535; 4458; 4197;
                    4096; 3484; 3481; 3393;
                    3175; 2360; 1852;       ];
    nIdxL1CpInst = [ 412;  161;    1;  303;
                     207; 4971; 4496;    5;
                    4557;  485;  253; 4676;
                       1;   66; 4485;  282;
                     193; 5211;  729; 4848;
                     982; 5955; 9805;  670;
                     464;   29;  429;  394;
                     616; 9457; 4429; 4771;
                     365; 9705; 9489; 4193;
                    9947;  824;  864;  347;
                     677; 6544; 6312; 9804;
                     278; 9461;  444; 4839;
                    4144; 9875;  197; 1156;
                    4674;10035; 4504;    5;
                    9937;  430;    5;  355;
                     909; 1622; 6284;       ];
    % L1Cd
    % Phase difference(w) and Insertion point(p)
    nIdxL1CdWeil = [5097; 5110; 5079; 4403;
                    4121; 5043; 5042; 5104;
                    4940; 5035; 4372; 5064;
                    5084; 5048; 4950; 5019;
                    5076; 3736; 4993; 5060;
                    5061; 5096; 4983; 4783;
                    4991; 4815; 4443; 4769;
                    4879; 4894; 4985; 5056;
                    4921; 5036; 4812; 4838;
                    4855; 4904; 4753; 4483;
                    4942; 4813; 4957; 4618;
                    4669; 4969; 5031; 5038;
                    4740; 4073; 4843; 4979;
                    4867; 4964; 5025; 4579;
                    4390; 4763; 4612; 4784;
                    3716; 4703; 4851;       ];
    nIdxL1CdInst = [ 181;  359;   72; 1110;
                    1480; 5034; 4622;    1;
                    4547;  826; 6284; 4195;
                     368;    1; 4796;  523;
                     151;  713; 9850; 5734;
                      34; 6142;  190;  644;
                     467; 5384;  801;  594;
                    4450; 9437; 4307; 5906;
                     378; 9448; 9432; 5849;
                    5547; 9546; 9132;  403;
                    3766;    3;  684; 9711;
                     333; 6124;10216; 4251;
                    9893; 9884; 4627; 4449;
                    9798;  985; 4272;  126;
                   10024;  434; 1029;  561;
                     289;  638; 4353;       ];

    % Generation Start
    nCodeLength = 10223;
    
    % Weil(L1Cp, L1Cd) Generation
    colW_L1Cp = fgPRN_prime_Weil(nCodeLength, nIdxL1CpWeil(nPRNNo));
    colW_L1Cd = fgPRN_prime_Weil(nCodeLength, nIdxL1CdWeil(nPRNNo));
    
    % Expansion Insertion
    colExpansionSeq = [ 0; 1; 1; 0; 1; 0; 0; ];
    colW_L1Cp = [colW_L1Cp(1:nIdxL1CpInst(nPRNNo)-1); colExpansionSeq; colW_L1Cp(nIdxL1CpInst(nPRNNo):end)];
    colW_L1Cd = [colW_L1Cd(1:nIdxL1CdInst(nPRNNo)-1); colExpansionSeq; colW_L1Cd(nIdxL1CdInst(nPRNNo):end)];
end