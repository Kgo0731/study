function [ inversions_num ] = count_inversions( test )
%COUNT_INVERSIONS この関数の概要をここに記述
%   詳細説明をここに記述
%% test
close all
load('no3_1_excerp_srm_info.mat')
path = ref_trj;
figure(1)
plot([ref_trj.kpt])

%%
for i = 1:1:length(path) - 1
    d_kpt(i) = (path(i+1).kpt - path(i).kpt)/...
        (path(i+1).s - path(i).s);
end
d_kpt(length(path)) = d_kpt(end);

% よこJ 換算
TH_D_KPT = +0.05;
TH_KPT   = 0.01;
for i = 1:1:length(path)
    if d_kpt(i) > TH_D_KPT && abs(path(i).kpt) > TH_KPT
        Sing_G(i) = 1;
    elseif d_kpt(i) < TH_D_KPT && abs(path(i).kpt) > TH_KPT
        Sing_G(i) = -1;
    else
        Sing_G(i) = 0;
    end
end

num(1) = 0;
for i = 2:1:length(Sing_G)
    if Sing_G(i) == Sing_G(i-1) || Sing_G(i-1) == 0
       num(i) = num(i-1);
    else
        num(i) = num(i-1) + 1;
    end
end
% 0 1 0 -1 0 5 OK
% 0 1  - 1 0 4 OK
% 0 1 0 1  …    
% 0 1 0 -1 1

figure(2)
subplot(4,1,1)
plot([path.s],[path.kpt])
subplot(4,1,2)
plot([path.s],d_kpt)
subplot(4,1,3)
plot([path.s],[Sing_G])
subplot(4,1,4)
plot([path.s],[num])

end

