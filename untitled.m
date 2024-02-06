clear
clc
%% Ray Object
A = Ray();                              % 創建一個空的光線物件
%%  
A = Ray([0;0;0],[0;0;-2],[0;0;-1]);     % 創建一個含頭尾和向量的光線物件
%% 
A = Ray([2;0;0],[0;0;0]);               % 創建一個只含頭尾的光線物件
%% 更新 Ray 物件
% ex: 更新 point_head --> p_h 要跟著變
A.set_head([1;0;0])
A.set_tail([2;0;0])
A.set_vector([1;0;0])
%% 更新 vector: by head and tail
A.update_vector
%% 更新 tail: by head, vector, Z (ray tracing by Z)
A.update_tail(-10)
%% 其他函數
A.isTIR

%% Example:
B = Ray();
B.set_head([0;0;500]);     % 已知人眼
B.set_vector([-1*sind(30);0;-1*cosd(30)]);    % 垂直往下看 (Z<0)
B.update_tail(-400);        % 找到往下看 Z 400 的位置
% show [0;0;100]


%% Medium Object
MA = Medium("Cube");
MA.set_n(1.52)
MA.set_t(3.663)
MB = Medium("Cube",1.2,1.49);

%% Ray Tracing Process:
% 決定介質，更新介質參數 (EX:normal)
MA
MB

M_list = [MMMM]

% version: need final position
[B.uv]
B.snell(MA,MB)      % 只更新 vector (為 unit form)
B.set_head(B.p_t)   % 新頭為上一道光線的尾
B.update_tail(-MB.t) % 新尾由 頭 "uv" 和 Z 決定
B.update_vector     % 由新頭尾重新更新 Vector
B.update            % 更新其他參數: 縮寫, uv, TIR
[B.uv]

primsm lens "air"


% version: need vector only
[B.uv]
B.snell(MA,MB)      % 只更新 vector (為 unit form)
B.update            % 更新其他參數: 縮寫, uv, TIR
[B.uv]
%% Option Object

% AUF Object
% auf = AUF(AUFMode=0);
% auf = AUF(AUFMode=1);   % 報錯
auf = AUF(AUFMode = 1,a_start = 0.1,a_end = 1.001,a_num = 10);
% auf = AUF(AUFMode = 1,list = [0,1]);
% auf = AUF(AUFMode = 1, a_start = 0.1, a_end = 1.001, a_num = 10, list = [0,1]);

% GRL Object % 會先提前計算好 radius list
% grl = GRL(GRLMode=0)
% grl = GRL(GRLMode=1)    % 報錯
grl = GRL(GRLMode=1,file="GRL-F13L20,LRA12,E2C0.73-1.25_0322 (KeepSub).mat");
% grl = GRL(GRLMode=1,radius_list=[1,3])
% grl = GRL(GRLMode=1,file="GRL-F13L20,LRA12,E2C0.73-1.25_0322 (KeepSub).mat",radius_list=[1,3]) % 以 list 為主
% grl.radius_list;

%% Cube Object
G = Cube()

%% Lens Object
auf = AUF(AUFMode=1,a_start=0.1,a_end=1.001,a_num=10);
grl = GRL(GRLMode=1,file="GRL-F13L20,LRA12,E2C0.73-1.25_0322 (KeepSub).mat");
L = Lens(LRA = 12,...
        size_hor = 186.5,...
        size_ver = 311.7,...
        pitch = 1.001,...
        refractive_index = 1.49,...
        thickness_EI0 = 1.524,...
        aperture = 1.001,...
        radius = 1.674,...
        reversed = 0,...
        grl = grl, ...
        auf = auf);  % grl, auf: optional

%% 建立 Lens 層 和 Prism 層之間的空氣層 (凹透鏡)
L_star = Lens(   LRA = 12,...
            size_hor = 186.5,...
            size_ver = 311.7,...
            pitch = 1.001,...
            refractive_index = 1,...                        % 空氣層
            thickness = 0.15 + L.fullheight_EI0,...         % 空氣層
            aperture = 1.001,...
            radius = 1.674,...
            reversed = 1,    ...                            % 結構朝下 (optional)
            grl = grl, ...
            auf = auf, ...
            vex_cave = -1);  % grl, auf; vex_cave = -1 凹透鏡 (optional)
% 強制更新 normal
normal_test = [0;1;0];  % 隨 Prism 更新
L_star.forceNormal(top_btm="top",normal=normal_test)

%% AutoGP (虛擬面: 其實是 Cube 變體)
PBA_key = [41.5];
Air1 = Cube();
GP = GradientPrism( ...
                    PBA_key = PBA_key,...
                    GPMode = 1,...  % 0: noGP, 1: autoGP, 2: manualGP
                    PRA = -10,...
                    refractive_index = 1.49,...
                    thickness = 1.934 + 0.066/2,...
                    size_hor = 165.24,...
                    size_ver = 293.76,...
                    reversed = 1);
Air2 = Cube();
% AutoGP 物件
autoGP = AutoGP(gp = GP,...
                PBA_center = PBA_key,...
                medium_list = {Air1,GP,Air2},...    % 決定 PLA 追跡順序 (由下至上)
                WDGP = 550);
GP.set_autoGP(autoGP)
GP1 = GP;
%% 
autoGP = AutoGP(medium_list = {Cube(),[],Cube()},...    % 決定 PLA 追跡順序 (由下至上)。 [] 代表 GP 位置
                WDGP = 550);
GP = GradientPrism( ...
                    PBA_key = 41.5,...
                    GPMode = 1,...  % 0: noGP, 1: autoGP, 2: manualGP
                    PRA = -10,...
                    refractive_index = 1.49,...
                    thickness = 1.934 + 0.066/2,...
                    autoGP = autoGP,...
                    reversed = 1);

%% 
manualGP = ManualGP();
GP = GradientPrism( ...
                    PBA_key = [60 41.5 10],...
                    GPMode = 2,...  % 0: noGP, 1: autoGP, 2: manualGP
                    PRA = -10,...
                    refractive_index = 1.49,...
                    thickness = 1.934 + 0.066/2,...
                    size_hor = 165.24,...   % optional: only for manualGP
                    size_ver = 293.76,...   % optional: only for manualGP
                    manualGP = manualGP,...
                    reversed = 1);

%% ManualGP
PBA_key = [60 41.5 10];
GP = GradientPrism( ...
                    PBA_key = PBA_key,...
                    GPMode = 2,...  % 0: noGP, 1: autoGP, 2: manualGP
                    PRA = -10,...
                    refractive_index = 1.49,...
                    thickness = 1.934 + 0.066/2,...
                    size_hor = 165.24,...   % optional: only for manualGP
                    size_ver = 293.76,...   % optional: only for manualGP
                    reversed = 1);
% ManualGP 物件
manualGP = ManualGP(gp = GP);
GP.set_manualGP(manualGP)
GP2 = GP;
%% Medium List %%
% 從眼睛至面板:
% EX: air(Cube) --> GP --> air(平凹透鏡) --> Lens(平凸透鏡) --> Gap(Cube) --> displayCover(Cube)
air_eye = Cube();
gp = GradientPrism();
air_prismtolens = Lens();
lens = Lens();
gap = Cube();
displayCover = Cube();

%% 設定追跡順序 (小至大)
medium_list = {air_eye,gp,air_prismtolens,lens,gap,displayCover};
% note: medium_list 修改也會改到 air_eye... 的參數

%% MediumTrain 物件
medium_train = MediumTrain(medium_list);
% set_order method
medium_train.set_order([1,2,3,4,5,6])
% find method   (多個符合 --> 輸出 cell)
medium = medium_train.find(order = 4);
medium = medium_train.find(type = "Cube");

%% 形成 medium train 之後， Z 才有的意義
% final order: z_bottom = 0

%% step 1: 建立介質
% Eye 物件
% eye = Eye();
eye = Eye(mode=[-1,0,1],...
          IPD=60,...
          VD=500,...
          VVA=30,...
          HVA=0,...
          PS=10,...
          STA=0);   % STA: optional
air_eye = Cube(thickness=eye.VD_z,refractive_index=1);
% autoGP 設定
autoGP = AutoGP(medium_list = {Cube(),[],Cube()},WDGP = 550);  % 決定 PLA 追跡順序 (由下至上)。 [] 代表 GP 位置
gp = GradientPrism( PBA_key = [41.5],...
                    GPMode = 1,...  % 0: noGP, 1: autoGP, 2: manualGP
                    PRA = -10,...
                    refractive_index = 1.49,...
                    thickness = 1.934 + 0.066/2,...
                    autoGP = autoGP,...
                    reversed = 1);
% auf, grl 設定
auf = AUF(AUFMode=1,a_start=0.1,a_end=1.001,a_num=10);
auf = AUF(AUFMode=0);
grl = GRL(GRLMode=1,file="GRL-F13L20,LRA12,E2C0.73-1.25_0322 (KeepSub).mat");
segment = Segment(num=5);
lens = Lens(LRA = 12,...
            size_hor = 186.5,...
            size_ver = 311.7,...
            pitch = 1.001,...
            refractive_index = 1.49,...
            thickness_EI0 = 1.524,...
            aperture = 1.001,...
            radius = 1.674,...
            reversed = 0,...
            grl = grl, ...
            auf = auf,...
            segment = segment);
% 置於 lens 和 prism 之間的空氣層
air_prismtolens = Lens( LRA = 12,...
                        size_hor = 186.5,...
                        size_ver = 311.7,...
                        pitch = 1.001,...
                        refractive_index = 1,...                            % 空氣層
                        thickness = 0.15 + lens.fullheight_EI0,...          % 空氣層
                        aperture = 1.001,...
                        radius = 1.674,...
                        reversed = 1,    ...                                % 結構朝下
                        grl = grl, ...
                        auf = auf, ...
                        vex_cave = -1,...
                        segment = segment);                                     % 凹透鏡
gap = Cube(thickness=3.663,refractive_index=1.52);
displayCover = Cube(thickness=0.264,refractive_index=1.51);

%% step 2: 建立 medium train
% 預設追跡順序: 遞增 (從上至下)
medium_list = {air_eye,gp,air_prismtolens,lens,gap,displayCover};
% 更新需要關聯其他介質的參數
% 0. medium train
medium_train = MediumTrain(eye,medium_list); % 同時更新 Z, order
% 1. eye edge position (Eye): with LRA
eye.deriveEdge(lens)
% 2. prism normal: assume 均使用 lens center XY 的 位置
gp.deriveNormalList(lens)

%% step 3: 光線追跡
% IPA layer: air(Eye) --> prism --> air(Lens)
% noIPA layer: "air(lens)" --> lens --> gap --> displayCover
tracingBus = TracingBus(medium_train,IPA=[1:3]);
tracingBus.tracing
% Point Matrix object
RP = Point_Matrix(tracingBus.RP);
RP_eye = RP.eye_extract;
