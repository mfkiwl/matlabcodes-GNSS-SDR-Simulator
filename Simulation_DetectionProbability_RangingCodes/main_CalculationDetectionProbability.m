%% Pre-Processing

% % Correlation Results Loading
path = 'F:\TemporalDataStorage\';

load([path,'CorrOut_GPSL1CA.mat']);
load([path,'CorrOut_GALE1.mat']);

load([path,'CorrOut_ZADD1023_0.mat']);

load([path,'CorrOut_ZADD4092_0_1.mat']);
load([path,'CorrOut_ZADD4092_0_2.mat']);
load([path,'CorrOut_ZADD4092_0_3.mat']);
load([path,'CorrOut_ZADD4092_0_4.mat']);
load([path,'CorrOut_ZADD4092_0_5.mat']);
load([path,'CorrOut_ZADD4092_0_6.mat']);
load([path,'CorrOut_ZADD4092_0_7.mat']);
load([path,'CorrOut_ZADD4092_0_8.mat']);
load([path,'CorrOut_ZADD4092_0_9.mat']);
CorrOut_ZADD4092_0(1,  1: 50) = CorrOut_ZADD4092_0_1;
CorrOut_ZADD4092_0(1, 51:100) = CorrOut_ZADD4092_0_2;
CorrOut_ZADD4092_0(1,101:150) = CorrOut_ZADD4092_0_3;
CorrOut_ZADD4092_0(1,151:200) = CorrOut_ZADD4092_0_4;
CorrOut_ZADD4092_0(1,201:250) = CorrOut_ZADD4092_0_5;
CorrOut_ZADD4092_0(1,251:300) = CorrOut_ZADD4092_0_6;
CorrOut_ZADD4092_0(1,301:400) = CorrOut_ZADD4092_0_7;
CorrOut_ZADD4092_0(1,401:500) = CorrOut_ZADD4092_0_8;
CorrOut_ZADD4092_0(1,501:600) = CorrOut_ZADD4092_0_9;
clear CorrOut_ZADD4092_0_1;
clear CorrOut_ZADD4092_0_2;
clear CorrOut_ZADD4092_0_3;
clear CorrOut_ZADD4092_0_4;
clear CorrOut_ZADD4092_0_5;
clear CorrOut_ZADD4092_0_6;
clear CorrOut_ZADD4092_0_7;
clear CorrOut_ZADD4092_0_8;
clear CorrOut_ZADD4092_0_9;

%%
refVtCN0_dB = [20 35 50];
% refVtCN0_dB = 50;
lenLoop1 = length(refVtCN0_dB);

CN0_dB = [20 25 30 35 40 45 50];
CNR_dB = CN0_dB-60;
lenLoop2 = length(CN0_dB);

sigma = 1;  % RMS of noise power

load([path,'Vt_Auto_fs20MHz_gpsCAgalE1.mat']);
load([path,'Vt_Auto_fs20MHz_ZC.mat']);
fs = 20e6;

Pfa_GPSL1CA_A = zeros(lenLoop2, lenLoop1);
Pfa_GALE1b_A  = zeros(lenLoop2, lenLoop1);
Pfa_GALE1c_A  = zeros(lenLoop2, lenLoop1);
Pfa_ZC1023_A  = zeros(lenLoop2, lenLoop1);
Pfa_ZC4092_A  = zeros(lenLoop2, lenLoop1);

Pd_GPSL1CA_A  = zeros(lenLoop2, lenLoop1);
Pd_GALE1b_A   = zeros(lenLoop2, lenLoop1);
Pd_GALE1c_A   = zeros(lenLoop2, lenLoop1);
Pd_ZC1023_A   = zeros(lenLoop2, lenLoop1);
Pd_ZC4092_A   = zeros(lenLoop2, lenLoop1);

for lpRefVtCN0 = 1:lenLoop1
    for lpCN0 = 1:lenLoop2
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_GPSL1CA_A(lpRefVtCN0,3), CNR_dB(lpCN0), 32, CorrOut_GPSL1CA, 1023, sigma);
        Pfa_GPSL1CA_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_GPSL1CA_A (lpCN0, lpRefVtCN0) = Pd;
        
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_GALE1b_A (lpRefVtCN0,3), CNR_dB(lpCN0), 50,  CorrOut_GALE1b,  4092, sigma);
        Pfa_GALE1b_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_GALE1b_A (lpCN0, lpRefVtCN0) = Pd;
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_GALE1c_A (lpRefVtCN0,3), CNR_dB(lpCN0), 50,  CorrOut_GALE1c,  4092, sigma);
        Pfa_GALE1c_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_GALE1c_A (lpCN0, lpRefVtCN0) = Pd;
        
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_ZC1023_A(lpRefVtCN0,3), CNR_dB(lpCN0), 25, CorrOut_ZC1023_0, 1023, sigma);
        Pfa_ZC1023_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_ZC1023_A (lpCN0, lpRefVtCN0) = Pd;
        
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_ZC4092_A (lpRefVtCN0,3), CNR_dB(lpCN0), 27,  CorrOut_ZC4092_0,  4092, sigma);
        Pfa_ZC4092_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_ZC4092_A (lpCN0, lpRefVtCN0) = Pd;

        disp(['refVt=',num2str(refVtCN0_dB(lpRefVtCN0)),' testVt=',num2str(CN0_dB(lpCN0))]);
        
        save([path, 'Pfa_Auto_fs20MHz.mat'],...
            'Pfa_GPSL1CA_A',...
            'Pfa_GALE1b_A',...
            'Pfa_GALE1c_A',...
            'Pfa_ZC1023_A',...
            'Pfa_ZC4092_A');
        save([path, 'Pd_Auto_fs20MHz.mat'],...
            'Pd_GPSL1CA_A',...
            'Pd_GALE1b_A',...
            'Pd_GALE1c_A',...
            'Pd_ZC1023_A',...
            'Pd_ZC4092_A');
    end
end

load([path,'Vt_Auto_fs5MHz_gpsCAgalE1.mat']);
load([path,'Vt_Auto_fs5MHz_ZC.mat']);
fs = 5e6;

Pfa_GPSL1CA_A = zeros(lenLoop2, lenLoop1);
Pfa_GALE1b_A  = zeros(lenLoop2, lenLoop1);
Pfa_GALE1c_A  = zeros(lenLoop2, lenLoop1);
Pfa_ZC1023_A  = zeros(lenLoop2, lenLoop1);
Pfa_ZC4092_A  = zeros(lenLoop2, lenLoop1);

Pd_GPSL1CA_A  = zeros(lenLoop2, lenLoop1);
Pd_GALE1b_A   = zeros(lenLoop2, lenLoop1);
Pd_GALE1c_A   = zeros(lenLoop2, lenLoop1);
Pd_ZC1023_A   = zeros(lenLoop2, lenLoop1);
Pd_ZC4092_A   = zeros(lenLoop2, lenLoop1);

for lpRefVtCN0 = 1:lenLoop1
    for lpCN0 = 1:lenLoop2
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_GPSL1CA_A(lpRefVtCN0,3), CNR_dB(lpCN0), 32, CorrOut_GPSL1CA, 1023, sigma);
        Pfa_GPSL1CA_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_GPSL1CA_A (lpCN0, lpRefVtCN0) = Pd;
        
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_GALE1b_A (lpRefVtCN0,3), CNR_dB(lpCN0), 50,  CorrOut_GALE1b,  4092, sigma);
        Pfa_GALE1b_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_GALE1b_A (lpCN0, lpRefVtCN0) = Pd;
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_GALE1c_A (lpRefVtCN0,3), CNR_dB(lpCN0), 50,  CorrOut_GALE1c,  4092, sigma);
        Pfa_GALE1c_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_GALE1c_A (lpCN0, lpRefVtCN0) = Pd;
        
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_ZC1023_A(lpRefVtCN0,3), CNR_dB(lpCN0), 25, CorrOut_ZC1023_0, 1023, sigma);
        Pfa_ZC1023_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_ZC1023_A (lpCN0, lpRefVtCN0) = Pd;
        
        [FA_CorrOut,Pfa,Pd] = fCalculationPd('Auto', fs, Vt_ZC4092_A (lpRefVtCN0,3), CNR_dB(lpCN0), 27,  CorrOut_ZC4092_0,  4092, sigma);
        Pfa_ZC4092_A(lpCN0, lpRefVtCN0) = Pfa;
        Pd_ZC4092_A (lpCN0, lpRefVtCN0) = Pd;

        CN0_dB(lpCN0)
        
        save([path, 'Pfa_Auto_fs5MHz.mat'],...
            'Pfa_GPSL1CA_A',...
            'Pfa_GALE1b_A',...
            'Pfa_GALE1c_A',...
            'Pfa_ZC1023_A',...
            'Pfa_ZC4092_A');
        save([path, 'Pd_Auto_fs5MHz.mat'],...
            'Pd_GPSL1CA_A',...
            'Pd_GALE1b_A',...
            'Pd_GALE1c_A',...
            'Pd_ZC1023_A',...
            'Pd_ZC4092_A');
    end
end










