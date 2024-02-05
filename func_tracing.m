function data = func_tracing(whichCode,data,varargin)
    % varargin 說明:
    %   1. if length(varargin) == 1 && varargin{1} == 1; segM00_now = 1; end
    %       --> segM00 計算
    %       EX: data = func_tracing("II",data,1)
    %   2. if length(varargin) == 2 && varargin{1} == 2; segM00_now = 2; end
    %       --> BLPROI, varargin{2} 須為 VZawPS
    %       EX: data = func_tracing("II",data,2,10)
    % loop order: eye --> lens --> segment --> AUF --> pupiledge
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % --- processing ---

    %% structure assignment
    while whichCode == "II"
AUFMode = data.AUFMode;                                       RRpointSet_ME_wld = data.RRpointSet_ME_wld;             forPLA_normalWP = data.forPLA_normalWP;                 outputA = data.outputA;                                           segVerSize = data.segVerSize;                                 
CDP = data.CDP;                                               RRpointSet_RE_wld = data.RRpointSet_RE_wld;             forPLA_outsidePrism = data.forPLA_outsidePrism;         outputD = data.outputD;                                           segmentMode = data.segmentMode;                               
EIHor = data.EIHor;                                           UV_normal1 = data.UV_normal1;                           forcePupilEdgeInverse = data.forcePupilEdgeInverse;     outputIIName = data.outputIIName;                                 showAUF = data.showAUF;                                       
GPMode = data.GPMode;                                         VE_EyePoint = data.VE_EyePoint;                         glassThickness = data.glassThickness;                   outputL = data.outputL;                                           showAsph = data.showAsph;                                     
GRLMat = data.GRLMat;                                         VE_originalPoint = data.VE_originalPoint;               glass_n = data.glass_n;                                 outputManual = data.outputManual;                                 showGP = data.showGP;                                         
GRLMode = data.GRLMode;                                       WD = data.WD;                                           gp_PBA_array = data.gp_PBA_array;                       outputO = data.outputO;                                           showGRL = data.showGRL;                                       
GRLNumShift = data.GRLNumShift;                               WDForAutoGP = data.WDForAutoGP;                         imageFilename = data.imageFilename;                     overwrite = data.overwrite;                                       showII = data.showII;                                         
I = data.I;                                                   WD_PLArray = data.WD_PLArray;                           imageFilepath = data.imageFilepath;                     p1 = data.p1;                                                     showLRA = data.showLRA;                                       
LRA = data.LRA;                                               WDz = data.WDz;                                         imagePathname = data.imagePathname;                     p2 = data.p2;                                                     showPRA = data.showPRA;                                       
LREL = data.LREL;                                             air_n = data.air_n;                                     isLLSameAsPanel = data.isLLSameAsPanel;                 panelPixelNumHor = data.panelPixelNumHor;                         showWP = data.showWP;                                         
LensHeightEachLenticular = data.LensHeightEachLenticular;     asph_leftEnd_normal = data.asph_leftEnd_normal;         isRRShift = data.isRRShift;                             panelPixelNumVer = data.panelPixelNumVer;                         sizeforRangeY = data.sizeforRangeY;                           
LensRadiusEachLenticular = data.LensRadiusEachLenticular;     asph_max_height = data.asph_max_height;                 lengthZRay2Default = data.lengthZRay2Default;           panelSizeHor = data.panelSizeHor;                                 softLLTracing = data.softLLTracing;                           
MOffset = data.MOffset;                                       asph_rightEnd_normal = data.asph_rightEnd_normal;       lengthZRay3Default = data.lengthZRay3Default;           panelSizeHorLL = data.panelSizeHorLL;                             spaHorSize = data.spaHorSize;                                 
OCAThickness = data.OCAThickness;                             aspherical = data.aspherical;                           lensAperturePool = data.lensAperturePool;               panelSizeVer = data.panelSizeVer;                                 spaVerSize = data.spaVerSize;                                 
OCA_n = data.OCA_n;                                           asphericalMat = data.asphericalMat;                     lensArraySizeHor = data.lensArraySizeHor;               panelSizeVerLL = data.panelSizeVerLL;                             systemTiltAngle = data.systemTiltAngle;                       
PBA = data.PBA;                                               base_segNum = data.base_segNum;                         lensArraySizeVer = data.lensArraySizeVer;               parameter = data.parameter;                                       tVeryBegining = data.tVeryBegining;                           
PBA1_fit_length = data.PBA1_fit_length;                       binoDistance = data.binoDistance;                       lensCenter_x_fitting = data.lensCenter_x_fitting;       phiAzimuthalAngle = data.phiAzimuthalAngle;                       temp_normalGP = data.temp_normalGP;                           
PBA1_fit_line = data.PBA1_fit_line;                           colorMode = data.colorMode;                             lensHeightDefault = data.lensHeightDefault;             phiAzimuthalAngle_original = data.phiAzimuthalAngle_original;     thetaPolarAngle = data.thetaPolarAngle;                       
PBA1_fit_num = data.PBA1_fit_num;                             customLine = data.customLine;                           lensHeightEI0 = data.lensHeightEI0;                     phiAzimuthal_PLArray = data.phiAzimuthal_PLArray;                 thetaPolarAngle_original = data.thetaPolarAngle_original;     
PBA1_fit_point = data.PBA1_fit_point;                         debugMode = data.debugMode;                             lensPitch = data.lensPitch;                             pixelSize = data.pixelSize;                                       thetaPolar_PLArray = data.thetaPolar_PLArray;                 
PBA1_fit_x = data.PBA1_fit_x;                                 displayCoverThickness = data.displayCoverThickness;     lensRadius = data.lensRadius;                           polyFit = data.polyFit;                                           totalNumFile = data.totalNumFile;                             
PBA1_fit_y = data.PBA1_fit_y;                                 displayCover_n = data.displayCover_n;                   lensRadiusDefault = data.lensRadiusDefault;             polyNum = data.polyNum;                                           verSizeForSeg = data.verSizeForSeg;                           
PBA_InputArray = data.PBA_InputArray;                         display_CDP = data.display_CDP;                         lensRadiusOriginal = data.lensRadiusOriginal;           preciseGP = data.preciseGP;                                       viewAngleHor = data.viewAngleHor;                             
PBA_array_forPLA = data.PBA_array_forPLA;                     display_EyeMode = data.display_EyeMode;                 lensSubstrate = data.lensSubstrate;                     prismLensGap = data.prismLensGap;                                 viewAngleVer = data.viewAngleVer;                             
PBA_array_forPLA_2 = data.PBA_array_forPLA_2;                 display_LensInfo = data.display_LensInfo;               lensThicknessEI0 = data.lensThicknessEI0;               prismMode = data.prismMode;                                       viewPointHor = data.viewPointHor;                             
PLA_array_fromPBA = data.PLA_array_fromPBA;                   display_PrismInfo = data.display_PrismInfo;             lens_n = data.lens_n;                                   prismSizeHor = data.prismSizeHor;                                 viewPointVer = data.viewPointVer;                             
PLA_array_fromPBA_2 = data.PLA_array_fromPBA_2;               display_PupilSize = data.display_PupilSize;             ll_array = data.ll_array;                               prismSizeVer = data.prismSizeVer;                                 wedgeHalfHeight = data.wedgeHalfHeight;                       
PLAtoPBAFunction = data.PLAtoPBAFunction;                     display_RDP = data.display_RDP;                         ll_down = data.ll_down;                                 prismStructure = data.prismStructure;                             wedgeMaxHeight = data.wedgeMaxHeight;                         
PRA = data.PRA;                                               display_RRRmode = data.display_RRRmode;                 ll_left = data.ll_left;                                 prismSubstrate = data.prismSubstrate;                             wedgePBA = data.wedgePBA;                                     
RDP = data.RDP;                                               display_STA = data.display_STA;                         ll_right = data.ll_right;                               prism_n = data.prism_n;                                           wedgePRA = data.wedgePRA;                                     
RDPModifierMode = data.RDPModifierMode;                       display_SegmentMode = data.display_SegmentMode;         ll_up = data.ll_up;                                     pupilSize = data.pupilSize;                                       wedgePrism = data.wedgePrism;                                 
RDP_PLArray = data.RDP_PLArray;                               display_VA = data.display_VA;                           mid_PLA = data.mid_PLA;                                 pupilSize_PLArray = data.pupilSize_PLArray;                       wedgeVer = data.wedgeVer;                                     
RDP_original = data.RDP_original;                             display_qLTRP = data.display_qLTRP;                     mu1 = data.mu1;                                         q_LTRPMode = data.q_LTRPMode;                                     wedge_normal = data.wedge_normal;                             
RPpointSet_LE_wld = data.RPpointSet_LE_wld;                   effectiveG = data.effectiveG;                           mu2 = data.mu2;                                         rangeY = data.rangeY;                                             whichCode = data.whichCode;                                   
RPpointSet_ME_wld = data.RPpointSet_ME_wld;                   eyeMode = data.eyeMode;                                 mu_GlasstoOCA = data.mu_GlasstoOCA;                     rangeYPitch = data.rangeYPitch;                                   whichpba = data.whichpba;                                     
RPpointSet_RE_wld = data.RPpointSet_RE_wld;                   farrestDistanceHor = data.farrestDistanceHor;           mu_LenstoOCA = data.mu_LenstoOCA;                       rotLRA = data.rotLRA;                                             widthStart = data.widthStart;                                 
RRFilterHalfSizeHor = data.RRFilterHalfSizeHor;               farrestDistanceVer = data.farrestDistanceVer;           mu_OCAtoDisplayCover = data.mu_OCAtoDisplayCover;       rotPRA = data.rotPRA;                                             widthStep = data.widthStep;                                   
RRFilterHalfSizeVer = data.RRFilterHalfSizeVer;               focal = data.focal;                                     mu_OCAtoGlass = data.mu_OCAtoGlass;                     rotPhi = data.rotPhi;                                             wp_PBA = data.wp_PBA;                                         
RRRConstant = data.RRRConstant;                               forPLA_incident = data.forPLA_incident;                 mu_airtoLens = data.mu_airtoLens;                       rotWedgePRA = data.rotWedgePRA;                                   writeII = data.writeII;                                       
RRRMode = data.RRRMode;                                       forPLA_insidePrism = data.forPLA_insidePrism;           numII = data.numII;                                     segFit = data.segFit;                                             writeSpa = data.writeSpa;                                     
RRShiftHor_wld = data.RRShiftHor_wld;                         forPLA_mu_PrismtoAir = data.forPLA_mu_PrismtoAir;       numLensYOriginal = data.numLensYOriginal;               segM00 = data.segM00;                                             xNumMax = data.xNumMax;                                       
RRShiftVer_wld = data.RRShiftVer_wld;                         forPLA_mu_airtoPrism = data.forPLA_mu_airtoPrism;       originalImage = data.originalImage;                     segNum = data.segNum;                                             zero2one = data.zero2one;                                     
RRpointSet_LE_wld = data.RRpointSet_LE_wld;                   forPLA_normalGP = data.forPLA_normalGP;                                                                                                                                                                                                         
    break
    end
    while whichCode == "VZA"
AUFMode = data.AUFMode;                                       VVAMesh = data.VVAMesh;                                 forPLA_incident = data.forPLA_incident;                 numLensYOriginal = data.numLensYOriginal;                         segNum = data.segNum;                                         
CDP = data.CDP;                                               WD = data.WD;                                           forPLA_insidePrism = data.forPLA_insidePrism;           numtest = data.numtest;                                           segVerSize = data.segVerSize;                                 
EIHor = data.EIHor;                                           WDForAutoGP = data.WDForAutoGP;                         forPLA_mu_PrismtoAir = data.forPLA_mu_PrismtoAir;       outputA = data.outputA;                                           segmentMode = data.segmentMode;                               
GPMode = data.GPMode;                                         WD_PLArray = data.WD_PLArray;                           forPLA_mu_airtoPrism = data.forPLA_mu_airtoPrism;       outputD = data.outputD;                                           showAUF = data.showAUF;                                       
GRLMat = data.GRLMat;                                         WDz = data.WDz;                                         forPLA_normalGP = data.forPLA_normalGP;                 outputIIName = data.outputIIName;                                 showAsph = data.showAsph;                                     
GRLMode = data.GRLMode;                                       air_n = data.air_n;                                     forPLA_normalWP = data.forPLA_normalWP;                 outputL = data.outputL;                                           showGP = data.showGP;                                         
GRLNumShift = data.GRLNumShift;                               angleCenterHVA = data.angleCenterHVA;                   forPLA_outsidePrism = data.forPLA_outsidePrism;         outputManual = data.outputManual;                                 showGRL = data.showGRL;                                       
HVAAllFailTag = data.HVAAllFailTag;                           angleCenterVVA = data.angleCenterVVA;                   forcePupilEdgeInverse = data.forcePupilEdgeInverse;     outputO = data.outputO;                                           showLRA = data.showLRA;                                       
HVAMesh = data.HVAMesh;                                       angleStep = data.angleStep;                             fullfilename = data.fullfilename;                       overwrite = data.overwrite;                                       showPRA = data.showPRA;                                       
I = data.I;                                                   angleSweepHVA = data.angleSweepHVA;                     glassThickness = data.glassThickness;                   p1 = data.p1;                                                     showRPFailMask = data.showRPFailMask;                         
LRA = data.LRA;                                               angleSweepVVA = data.angleSweepVVA;                     glass_n = data.glass_n;                                 p2 = data.p2;                                                     showRPMask = data.showRPMask;                                 
LREL = data.LREL;                                             asph_leftEnd_normal = data.asph_leftEnd_normal;         gp_PBA_array = data.gp_PBA_array;                       panelPixelNumHor = data.panelPixelNumHor;                         showWP = data.showWP;                                         
LensHeightEachLenticular = data.LensHeightEachLenticular;     asph_max_height = data.asph_max_height;                 isLLSameAsPanel = data.isLLSameAsPanel;                 panelPixelNumVer = data.panelPixelNumVer;                         sizeforRangeY = data.sizeforRangeY;                           
LensRadiusEachLenticular = data.LensRadiusEachLenticular;     asph_rightEnd_normal = data.asph_rightEnd_normal;       lastAngle = data.lastAngle;                             panelSizeHor = data.panelSizeHor;                                 softLLTracing = data.softLLTracing;                           
OCAThickness = data.OCAThickness;                             aspherical = data.aspherical;                           lengthZRay2Default = data.lengthZRay2Default;           panelSizeHorLL = data.panelSizeHorLL;                             systemTiltAngle = data.systemTiltAngle;                       
OCA_n = data.OCA_n;                                           asphericalMat = data.asphericalMat;                     lengthZRay3Default = data.lengthZRay3Default;           panelSizeVer = data.panelSizeVer;                                 tVeryBegining = data.tVeryBegining;                           
PBA = data.PBA;                                               autoTermString = data.autoTermString;                   lensAperturePool = data.lensAperturePool;               panelSizeVerLL = data.panelSizeVerLL;                             temp_normalGP = data.temp_normalGP;                           
PBA1_fit_length = data.PBA1_fit_length;                       autoVZAnalysis = data.autoVZAnalysis;                   lensArraySizeHor = data.lensArraySizeHor;               parameter = data.parameter;                                       thetaPolarAngle = data.thetaPolarAngle;                       
PBA1_fit_line = data.PBA1_fit_line;                           base_segNum = data.base_segNum;                         lensArraySizeVer = data.lensArraySizeVer;               phiAzimuthalAngle = data.phiAzimuthalAngle;                       thetaPolarAngle_original = data.thetaPolarAngle_original;     
PBA1_fit_num = data.PBA1_fit_num;                             binoDistance = data.binoDistance;                       lensCenter_x_fitting = data.lensCenter_x_fitting;       phiAzimuthalAngle_original = data.phiAzimuthalAngle_original;     thetaPolar_PLArray = data.thetaPolar_PLArray;                 
PBA1_fit_point = data.PBA1_fit_point;                         criticalFailRPNumber = data.criticalFailRPNumber;       lensHeightDefault = data.lensHeightDefault;             phiAzimuthal_PLArray = data.phiAzimuthal_PLArray;                 thetaPool = data.thetaPool;                                   
PBA1_fit_x = data.PBA1_fit_x;                                 customLine = data.customLine;                           lensHeightEI0 = data.lensHeightEI0;                     phiPool = data.phiPool;                                           verSizeForSeg = data.verSizeForSeg;                           
PBA1_fit_y = data.PBA1_fit_y;                                 dateStringOn = data.dateStringOn;                       lensPitch = data.lensPitch;                             pixelSize = data.pixelSize;                                       viewAngleHor = data.viewAngleHor;                             
PBA_InputArray = data.PBA_InputArray;                         displayCoverThickness = data.displayCoverThickness;     lensRadius = data.lensRadius;                           polyFit = data.polyFit;                                           viewAngleVer = data.viewAngleVer;                             
PBA_array_forPLA = data.PBA_array_forPLA;                     displayCover_n = data.displayCover_n;                   lensRadiusDefault = data.lensRadiusDefault;             polyNum = data.polyNum;                                           viewPointHor = data.viewPointHor;                             
PBA_array_forPLA_2 = data.PBA_array_forPLA_2;                 display_CDP = data.display_CDP;                         lensRadiusOriginal = data.lensRadiusOriginal;           preciseGP = data.preciseGP;                                       viewPointVer = data.viewPointVer;                             
PLA_array_fromPBA = data.PLA_array_fromPBA;                   display_EyeMode = data.display_EyeMode;                 lensSubstrate = data.lensSubstrate;                     prismLensGap = data.prismLensGap;                                 wedgeHalfHeight = data.wedgeHalfHeight;                       
PLA_array_fromPBA_2 = data.PLA_array_fromPBA_2;               display_LensInfo = data.display_LensInfo;               lensThicknessEI0 = data.lensThicknessEI0;               prismMode = data.prismMode;                                       wedgeMaxHeight = data.wedgeMaxHeight;                         
PLAtoPBAFunction = data.PLAtoPBAFunction;                     display_PrismInfo = data.display_PrismInfo;             lens_n = data.lens_n;                                   prismSizeHor = data.prismSizeHor;                                 wedgePBA = data.wedgePBA;                                     
PRA = data.PRA;                                               display_PupilSize = data.display_PupilSize;             limitedVA = data.limitedVA;                             prismSizeVer = data.prismSizeVer;                                 wedgePRA = data.wedgePRA;                                     
RPpointSet_LE_wld = data.RPpointSet_LE_wld;                   display_STA = data.display_STA;                         limitedVA_PL = data.limitedVA_PL;                       prismStructure = data.prismStructure;                             wedgePrism = data.wedgePrism;                                 
RPpointSet_ME_wld = data.RPpointSet_ME_wld;                   display_SegmentMode = data.display_SegmentMode;         ll_array = data.ll_array;                               prismSubstrate = data.prismSubstrate;                             wedgeVer = data.wedgeVer;                                     
RPpointSet_RE_wld = data.RPpointSet_RE_wld;                   display_VA = data.display_VA;                           ll_down = data.ll_down;                                 prism_n = data.prism_n;                                           wedge_normal = data.wedge_normal;                             
RRpointSet_LE_wld = data.RRpointSet_LE_wld;                   display_qLTRP = data.display_qLTRP;                     ll_left = data.ll_left;                                 pupilSize = data.pupilSize;                                       whichCode = data.whichCode;                                   
RRpointSet_ME_wld = data.RRpointSet_ME_wld;                   dyPSMode = data.dyPSMode;                               ll_right = data.ll_right;                               pupilSize_PLArray = data.pupilSize_PLArray;                       whichVAElement = data.whichVAElement;                         
RRpointSet_RE_wld = data.RRpointSet_RE_wld;                   dynamicPS = data.dynamicPS;                             ll_up = data.ll_up;                                     q_LTRPMode = data.q_LTRPMode;                                     whichVATerm = data.whichVATerm;                               
TIRHappen = data.TIRHappen;                                   effectiveG = data.effectiveG;                           mid_PLA = data.mid_PLA;                                 rangeY = data.rangeY;                                             whichpba = data.whichpba;                                     
UV_normal1 = data.UV_normal1;                                 excelFileName = data.excelFileName;                     mu1 = data.mu1;                                         rangeYPitch = data.rangeYPitch;                                   widthStart = data.widthStart;                                 
VAPool = data.VAPool;                                         excelSheetName = data.excelSheetName;                   mu2 = data.mu2;                                         rotLRA = data.rotLRA;                                             widthStep = data.widthStep;                                   
VATerm = data.VATerm;                                         eyeMode = data.eyeMode;                                 mu_GlasstoOCA = data.mu_GlasstoOCA;                     rotPRA = data.rotPRA;                                             wp_PBA = data.wp_PBA;                                         
VAchecktemp1 = data.VAchecktemp1;                             failNumberMatrix = data.failNumberMatrix;               mu_LenstoOCA = data.mu_LenstoOCA;                       rotPhi = data.rotPhi;                                             writeExcel = data.writeExcel;                                 
VAchecktemp2 = data.VAchecktemp2;                             farrestDistanceHor = data.farrestDistanceHor;           mu_OCAtoDisplayCover = data.mu_OCAtoDisplayCover;       rotWedgePRA = data.rotWedgePRA;                                   writeRPFailMask = data.writeRPFailMask;                       
VE_EyePoint = data.VE_EyePoint;                               farrestDistanceVer = data.farrestDistanceVer;           mu_OCAtoGlass = data.mu_OCAtoGlass;                     segFit = data.segFit;                                             writeRPMask = data.writeRPMask;                               
VE_originalPoint = data.VE_originalPoint;                     filename = data.filename;                               mu_airtoLens = data.mu_airtoLens;                       segM00 = data.segM00;                                             xNumMax = data.xNumMax;                                       
VVAAllFailTag = data.VVAAllFailTag;                           focal = data.focal;                                     numII = data.numII;                                                                                                                                                                     
    break
    end
    while whichCode == "M00Curve"
AUFMode = data.AUFMode;                                       RRpointSet_RE_wld = data.RRpointSet_RE_wld;             eyeMode = data.eyeMode;                                 outputA = data.outputA;                                           segmentMode = data.segmentMode;                               
AimSphere = data.AimSphere;                                   RV = data.RV;                                           farrestDistanceHor = data.farrestDistanceHor;           outputD = data.outputD;                                           showAUF = data.showAUF;                                       
CDP = data.CDP;                                               TIR = data.TIR;                                         farrestDistanceVer = data.farrestDistanceVer;           outputIIName = data.outputIIName;                                 showAimSphere = data.showAimSphere;                           
EIHor = data.EIHor;                                           TIRHappen = data.TIRHappen;                             focal = data.focal;                                     outputL = data.outputL;                                           showAsph = data.showAsph;                                     
GPMode = data.GPMode;                                         UV_normal1 = data.UV_normal1;                           forPLA_incident = data.forPLA_incident;                 outputManual = data.outputManual;                                 showAvg = data.showAvg;                                       
GRLMat = data.GRLMat;                                         VAPool = data.VAPool;                                   forPLA_insidePrism = data.forPLA_insidePrism;           outputO = data.outputO;                                           showCenter = data.showCenter;                                 
GRLMode = data.GRLMode;                                       VATerm = data.VATerm;                                   forPLA_mu_PrismtoAir = data.forPLA_mu_PrismtoAir;       overwrite = data.overwrite;                                       showGP = data.showGP;                                         
GRLNumShift = data.GRLNumShift;                               VE_EyePoint = data.VE_EyePoint;                         forPLA_mu_airtoPrism = data.forPLA_mu_airtoPrism;       p1 = data.p1;                                                     showGRL = data.showGRL;                                       
GridCustomString = data.GridCustomString;                     VE_originalPoint = data.VE_originalPoint;               forPLA_normalGP = data.forPLA_normalGP;                 p2 = data.p2;                                                     showLRA = data.showLRA;                                       
HVASet = data.HVASet;                                         VVACenteOriginal = data.VVACenteOriginal;               forPLA_normalWP = data.forPLA_normalWP;                 panelSizeHor = data.panelSizeHor;                                 showLeftEye = data.showLeftEye;                               
I = data.I;                                                   VVACenterArray = data.VVACenterArray;                   forPLA_outsidePrism = data.forPLA_outsidePrism;         panelSizeHorLL = data.panelSizeHorLL;                             showMax = data.showMax;                                       
LRA = data.LRA;                                               VVASet = data.VVASet;                                   forcePupilEdgeInverse = data.forcePupilEdgeInverse;     panelSizeVer = data.panelSizeVer;                                 showMiddleEye = data.showMiddleEye;                           
LREL = data.LREL;                                             VZAArray = data.VZAArray;                               glassThickness = data.glassThickness;                   panelSizeVerLL = data.panelSizeVerLL;                             showPRA = data.showPRA;                                       
LensHeightEachLenticular = data.LensHeightEachLenticular;     WD = data.WD;                                           glass_n = data.glass_n;                                 parameter = data.parameter;                                       showRV = data.showRV;                                         
LensRadiusEachLenticular = data.LensRadiusEachLenticular;     WDForAutoGP = data.WDForAutoGP;                         gp_PBA_array = data.gp_PBA_array;                       phiAzimuthalAngle = data.phiAzimuthalAngle;                       showRightEye = data.showRightEye;                             
M00AVG = data.M00AVG;                                         WD_PLArray = data.WD_PLArray;                           isLLSameAsPanel = data.isLLSameAsPanel;                 phiAzimuthalAngle_original = data.phiAzimuthalAngle_original;     showWP = data.showWP;                                         
M00Center = data.M00Center;                                   WDz = data.WDz;                                         lengthZRay2Default = data.lengthZRay2Default;           phiPool = data.phiPool;                                           sizeforRangeY = data.sizeforRangeY;                           
M00GridMode = data.M00GridMode;                               air_n = data.air_n;                                     lengthZRay3Default = data.lengthZRay3Default;           plotAVG = data.plotAVG;                                           softLLTracing = data.softLLTracing;                           
M00IndexHVACell = data.M00IndexHVACell;                       angleCenterHVA = data.angleCenterHVA;                   lensAperturePool = data.lensAperturePool;               plotAimSphere = data.plotAimSphere;                               systemTiltAngle = data.systemTiltAngle;                       
M00IndexVVACell = data.M00IndexVVACell;                       angleCenterVVA = data.angleCenterVVA;                   lensArraySizeHor = data.lensArraySizeHor;               plotCenter = data.plotCenter;                                     tVeryBegining = data.tVeryBegining;                           
M00MatStr = data.M00MatStr;                                   angleStep = data.angleStep;                             lensArraySizeVer = data.lensArraySizeVer;               plotM00andTIRCurveAuto = data.plotM00andTIRCurveAuto;             temp_normalGP = data.temp_normalGP;                           
M00Matrix = data.M00Matrix;                                   angleSweepHVA = data.angleSweepHVA;                     lensCenter_x_fitting = data.lensCenter_x_fitting;       plotMax = data.plotMax;                                           termNum = data.termNum;                                       
M00Max = data.M00Max;                                         angleSweepVVA = data.angleSweepVVA;                     lensHeightDefault = data.lensHeightDefault;             plotRV = data.plotRV;                                             thetaPolarAngle = data.thetaPolarAngle;                       
M00ValueCell = data.M00ValueCell;                             asph_leftEnd_normal = data.asph_leftEnd_normal;         lensHeightEI0 = data.lensHeightEI0;                     plotTIR = data.plotTIR;                                           thetaPolarAngle_original = data.thetaPolarAngle_original;     
OCAThickness = data.OCAThickness;                             asph_max_height = data.asph_max_height;                 lensPitch = data.lensPitch;                             plotVZALine = data.plotVZALine;                                   thetaPool = data.thetaPool;                                   
OCA_n = data.OCA_n;                                           asph_rightEnd_normal = data.asph_rightEnd_normal;       lensRadius = data.lensRadius;                           preciseGP = data.preciseGP;                                       verSizeForSeg = data.verSizeForSeg;                           
PBA = data.PBA;                                               aspherical = data.aspherical;                           lensRadiusDefault = data.lensRadiusDefault;             prismLensGap = data.prismLensGap;                                 viewAngleHor = data.viewAngleHor;                             
PBA1_fit_length = data.PBA1_fit_length;                       asphericalMat = data.asphericalMat;                     lensRadiusOriginal = data.lensRadiusOriginal;           prismMode = data.prismMode;                                       viewAngleVer = data.viewAngleVer;                             
PBA1_fit_line = data.PBA1_fit_line;                           autoM00Analysis = data.autoM00Analysis;                 lensSubstrate = data.lensSubstrate;                     prismSizeHor = data.prismSizeHor;                                 viewPointHor = data.viewPointHor;                             
PBA1_fit_num = data.PBA1_fit_num;                             autoTermString = data.autoTermString;                   lensThicknessEI0 = data.lensThicknessEI0;               prismSizeVer = data.prismSizeVer;                                 viewPointVer = data.viewPointVer;                             
PBA1_fit_point = data.PBA1_fit_point;                         binoDistance = data.binoDistance;                       lens_n = data.lens_n;                                   prismStructure = data.prismStructure;                             wedgeHalfHeight = data.wedgeHalfHeight;                       
PBA1_fit_x = data.PBA1_fit_x;                                 checkTemp1 = data.checkTemp1;                           ll_array = data.ll_array;                               prismSubstrate = data.prismSubstrate;                             wedgeMaxHeight = data.wedgeMaxHeight;                         
PBA1_fit_y = data.PBA1_fit_y;                                 checkTemp2 = data.checkTemp2;                           ll_down = data.ll_down;                                 prism_n = data.prism_n;                                           wedgePBA = data.wedgePBA;                                     
PBA_InputArray = data.PBA_InputArray;                         curveStr = data.curveStr;                               ll_left = data.ll_left;                                 pupilSize = data.pupilSize;                                       wedgePRA = data.wedgePRA;                                     
PBA_array_forPLA = data.PBA_array_forPLA;                     customLine = data.customLine;                           ll_right = data.ll_right;                               pupilSize_PLArray = data.pupilSize_PLArray;                       wedgePrism = data.wedgePrism;                                 
PBA_array_forPLA_2 = data.PBA_array_forPLA_2;                 displayCoverThickness = data.displayCoverThickness;     ll_up = data.ll_up;                                     rangeY = data.rangeY;                                             wedgeVer = data.wedgeVer;                                     
PLA_array_fromPBA = data.PLA_array_fromPBA;                   displayCover_n = data.displayCover_n;                   mid_PLA = data.mid_PLA;                                 rangeYPitch = data.rangeYPitch;                                   wedge_normal = data.wedge_normal;                             
PLA_array_fromPBA_2 = data.PLA_array_fromPBA_2;               display_CDP = data.display_CDP;                         mu1 = data.mu1;                                         rotLRA = data.rotLRA;                                             whichCode = data.whichCode;                                   
PLAtoPBAFunction = data.PLAtoPBAFunction;                     display_EyeMode = data.display_EyeMode;                 mu2 = data.mu2;                                         rotPRA = data.rotPRA;                                             whichVAElement = data.whichVAElement;                         
PRA = data.PRA;                                               display_LensInfo = data.display_LensInfo;               mu_GlasstoOCA = data.mu_GlasstoOCA;                     rotPhi = data.rotPhi;                                             whichVATerm = data.whichVATerm;                               
RDP = data.RDP;                                               display_PrismInfo = data.display_PrismInfo;             mu_LenstoOCA = data.mu_LenstoOCA;                       rotWedgePRA = data.rotWedgePRA;                                   whichpba = data.whichpba;                                     
RPpointSet_LE_wld = data.RPpointSet_LE_wld;                   display_PupilSize = data.display_PupilSize;             mu_OCAtoDisplayCover = data.mu_OCAtoDisplayCover;       saveCurve = data.saveCurve;                                       widthStart = data.widthStart;                                 
RPpointSet_ME_wld = data.RPpointSet_ME_wld;                   display_STA = data.display_STA;                         mu_OCAtoGlass = data.mu_OCAtoGlass;                     saveM00Mat = data.saveM00Mat;                                     widthStep = data.widthStep;                                   
RPpointSet_RE_wld = data.RPpointSet_RE_wld;                   display_VA = data.display_VA;                           mu_airtoLens = data.mu_airtoLens;                       segM00 = data.segM00;                                             wp_PBA = data.wp_PBA;                                         
RRpointSet_LE_wld = data.RRpointSet_LE_wld;                   effectiveG = data.effectiveG;                           numII = data.numII;                                     segNum = data.segNum;                                             writeGrid = data.writeGrid;                                   
RRpointSet_ME_wld = data.RRpointSet_ME_wld;                   exludeRVJoint = data.exludeRVJoint;                     numLensYOriginal = data.numLensYOriginal;               segVerSize = data.segVerSize;                                     xNumMax = data.xNumMax;                                       
    break
    end
    while whichCode == "FindGRL"
AUFMode = data.AUFMode;                                       PLA_array_fromPBA_2 = data.PLA_array_fromPBA_2;         forPLA_incident = data.forPLA_incident;                 mu_LenstoOCA = data.mu_LenstoOCA;                                 rangeYPitch = data.rangeYPitch;                               
CDP = data.CDP;                                               PLAtoPBAFunction = data.PLAtoPBAFunction;               forPLA_insidePrism = data.forPLA_insidePrism;           mu_OCAtoDisplayCover = data.mu_OCAtoDisplayCover;                 rotLRA = data.rotLRA;                                         
EIHor = data.EIHor;                                           PRA = data.PRA;                                         forPLA_mu_PrismtoAir = data.forPLA_mu_PrismtoAir;       mu_OCAtoGlass = data.mu_OCAtoGlass;                               rotPRA = data.rotPRA;                                         
GPMode = data.GPMode;                                         RDP = data.RDP;                                         forPLA_mu_airtoPrism = data.forPLA_mu_airtoPrism;       mu_airtoLens = data.mu_airtoLens;                                 rotPhi = data.rotPhi;                                         
GRLMode = data.GRLMode;                                       RPpointSet_LE_wld = data.RPpointSet_LE_wld;             forPLA_normalGP = data.forPLA_normalGP;                 numII = data.numII;                                               rotWedgePRA = data.rotWedgePRA;                               
I = data.I;                                                   RPpointSet_ME_wld = data.RPpointSet_ME_wld;             forPLA_normalWP = data.forPLA_normalWP;                 numLensYOriginal = data.numLensYOriginal;                         showAUF = data.showAUF;                                       
LL = data.LL;                                                 RPpointSet_RE_wld = data.RPpointSet_RE_wld;             forPLA_outsidePrism = data.forPLA_outsidePrism;         outputA = data.outputA;                                           showGP = data.showGP;                                         
LRA = data.LRA;                                               RRpointSet_LE_wld = data.RRpointSet_LE_wld;             forcePupilEdgeInverse = data.forcePupilEdgeInverse;     outputD = data.outputD;                                           showLRA = data.showLRA;                                       
LREL = data.LREL;                                             RRpointSet_ME_wld = data.RRpointSet_ME_wld;             glassThickness = data.glassThickness;                   outputIIName = data.outputIIName;                                 showPRA = data.showPRA;                                       
LREnd = data.LREnd;                                           RRpointSet_RE_wld = data.RRpointSet_RE_wld;             glass_n = data.glass_n;                                 outputL = data.outputL;                                           showWP = data.showWP;                                         
LRNum = data.LRNum;                                           RatioM = data.RatioM;                                   gp_PBA_array = data.gp_PBA_array;                       outputManual = data.outputManual;                                 sizeforRangeY = data.sizeforRangeY;                           
LRStart = data.LRStart;                                       RatioMTemp = data.RatioMTemp;                           isLLSameAsPanel = data.isLLSameAsPanel;                 outputO = data.outputO;                                           softLLTracing = data.softLLTracing;                           
LRstep = data.LRstep;                                         UV_normal1 = data.UV_normal1;                           lengthZRay2Default = data.lengthZRay2Default;           overwrite = data.overwrite;                                       systemTiltAngle = data.systemTiltAngle;                       
LensHeightEachLenticular = data.LensHeightEachLenticular;     VE_EyePoint = data.VE_EyePoint;                         lengthZRay3Default = data.lengthZRay3Default;           p1 = data.p1;                                                     tVeryBegining = data.tVeryBegining;                           
LensRadiusCenter = data.LensRadiusCenter;                     VE_originalPoint = data.VE_originalPoint;               lensAperturePool = data.lensAperturePool;               p2 = data.p2;                                                     temp_normalGP = data.temp_normalGP;                           
LensRadiusEachLenticular = data.LensRadiusEachLenticular;     WD = data.WD;                                           lensArraySizeHor = data.lensArraySizeHor;               panelSizeHor = data.panelSizeHor;                                 thetaPolarAngle = data.thetaPolarAngle;                       
LensRadiusFinal = data.LensRadiusFinal;                       WDForAutoGP = data.WDForAutoGP;                         lensArraySizeVer = data.lensArraySizeVer;               panelSizeHorLL = data.panelSizeHorLL;                             thetaPolarAngle_original = data.thetaPolarAngle_original;     
M00Output = data.M00Output;                                   WD_PLArray = data.WD_PLArray;                           lensCenter_x_fitting = data.lensCenter_x_fitting;       panelSizeVer = data.panelSizeVer;                                 thetaPolar_PLArray = data.thetaPolar_PLArray;                 
M00Pool = data.M00Pool;                                       WDz = data.WDz;                                         lensHeightDefault = data.lensHeightDefault;             panelSizeVerLL = data.panelSizeVerLL;                             viewAngleHor = data.viewAngleHor;                             
MAB_E2C = data.MAB_E2C;                                       air_n = data.air_n;                                     lensHeightEI0 = data.lensHeightEI0;                     parameter = data.parameter;                                       viewAngleVer = data.viewAngleVer;                             
MCenter = data.MCenter;                                       aspherical = data.aspherical;                           lensPitch = data.lensPitch;                             phiAzimuthalAngle = data.phiAzimuthalAngle;                       viewPointHor = data.viewPointHor;                             
MDesiredArray = data.MDesiredArray;                           binoDistance = data.binoDistance;                       lensRadius = data.lensRadius;                           phiAzimuthalAngle_original = data.phiAzimuthalAngle_original;     viewPointVer = data.viewPointVer;                             
MEachLens = data.MEachLens;                                   customLine = data.customLine;                           lensRadiusDefault = data.lensRadiusDefault;             phiAzimuthal_PLArray = data.phiAzimuthal_PLArray;                 wedgeHalfHeight = data.wedgeHalfHeight;                       
MEachLenticular = data.MEachLenticular;                       displayCoverThickness = data.displayCoverThickness;     lensRadiusOriginal = data.lensRadiusOriginal;           plotGRL = data.plotGRL;                                           wedgeMaxHeight = data.wedgeMaxHeight;                         
MRatioArray = data.MRatioArray;                               displayCover_n = data.displayCover_n;                   lensSubstrate = data.lensSubstrate;                     preciseGP = data.preciseGP;                                       wedgePBA = data.wedgePBA;                                     
OCAThickness = data.OCAThickness;                             display_CDP = data.display_CDP;                         lensThicknessEI0 = data.lensThicknessEI0;               prismLensGap = data.prismLensGap;                                 wedgePRA = data.wedgePRA;                                     
OCA_n = data.OCA_n;                                           display_EyeMode = data.display_EyeMode;                 lens_n = data.lens_n;                                   prismMode = data.prismMode;                                       wedgePrism = data.wedgePrism;                                 
PBA = data.PBA;                                               display_LensInfo = data.display_LensInfo;               ll_array = data.ll_array;                               prismSizeHor = data.prismSizeHor;                                 wedgeVer = data.wedgeVer;                                     
PBA1_fit_length = data.PBA1_fit_length;                       display_PrismInfo = data.display_PrismInfo;             ll_down = data.ll_down;                                 prismSizeVer = data.prismSizeVer;                                 wedge_normal = data.wedge_normal;                             
PBA1_fit_line = data.PBA1_fit_line;                           display_PupilSize = data.display_PupilSize;             ll_left = data.ll_left;                                 prismStructure = data.prismStructure;                             whichCode = data.whichCode;                                   
PBA1_fit_num = data.PBA1_fit_num;                             display_RDP = data.display_RDP;                         ll_right = data.ll_right;                               prismSubstrate = data.prismSubstrate;                             whichpba = data.whichpba;                                     
PBA1_fit_point = data.PBA1_fit_point;                         display_STA = data.display_STA;                         ll_up = data.ll_up;                                     prism_n = data.prism_n;                                           widthStart = data.widthStart;                                 
PBA1_fit_x = data.PBA1_fit_x;                                 display_VA = data.display_VA;                           manualE2CRatio = data.manualE2CRatio;                   pupilSize = data.pupilSize;                                       widthStep = data.widthStep;                                   
PBA1_fit_y = data.PBA1_fit_y;                                 effectiveG = data.effectiveG;                           manualMDesired = data.manualMDesired;                   pupilSize_PLArray = data.pupilSize_PLArray;                       wp_PBA = data.wp_PBA;                                         
PBA_InputArray = data.PBA_InputArray;                         eyeMode = data.eyeMode;                                 mid_PLA = data.mid_PLA;                                 radiusNum = data.radiusNum;                                       writeGRL = data.writeGRL;                                     
PBA_array_forPLA = data.PBA_array_forPLA;                     farrestDistanceHor = data.farrestDistanceHor;           mu1 = data.mu1;                                         radiusPool = data.radiusPool;                                     xNumMax = data.xNumMax;                                       
PBA_array_forPLA_2 = data.PBA_array_forPLA_2;                 farrestDistanceVer = data.farrestDistanceVer;           mu2 = data.mu2;                                         rangeY = data.rangeY;                                             rangeYTotal = data.rangeYTotal;                               
PLA_array_fromPBA = data.PLA_array_fromPBA;                   focal = data.focal;                                     mu_GlasstoOCA = data.mu_GlasstoOCA;                                                                                                                                                     
    break
    end
    while whichCode == "Design"
AUFMode = data.AUFMode;                                       PRA = data.PRA;                                         focal = data.focal;                                     ll_down = data.ll_down;                                           rangeYPitch = data.rangeYPitch;                               
CDP = data.CDP;                                               RDP = data.RDP;                                         focal_Design = data.focal_Design;                       ll_left = data.ll_left;                                           rotLRA = data.rotLRA;                                         
CDP_Design = data.CDP_Design;                                 RPpointSet_LE_wld = data.RPpointSet_LE_wld;             forPLA_incident = data.forPLA_incident;                 ll_right = data.ll_right;                                         rotPRA = data.rotPRA;                                         
EIHor = data.EIHor;                                           RPpointSet_ME_wld = data.RPpointSet_ME_wld;             forPLA_insidePrism = data.forPLA_insidePrism;           ll_up = data.ll_up;                                               rotPhi = data.rotPhi;                                         
GPMode = data.GPMode;                                         RPpointSet_RE_wld = data.RPpointSet_RE_wld;             forPLA_mu_PrismtoAir = data.forPLA_mu_PrismtoAir;       mid_PLA = data.mid_PLA;                                           rotWedgePRA = data.rotWedgePRA;                               
GRLMode = data.GRLMode;                                       RRpointSet_LE_wld = data.RRpointSet_LE_wld;             forPLA_mu_airtoPrism = data.forPLA_mu_airtoPrism;       mu1 = data.mu1;                                                   sampleSize = data.sampleSize;                                 
GRLNumShift = data.GRLNumShift;                               RRpointSet_ME_wld = data.RRpointSet_ME_wld;             forPLA_normalGP = data.forPLA_normalGP;                 mu2 = data.mu2;                                                   sizeforRangeY = data.sizeforRangeY;                           
HardVA = data.HardVA;                                         RRpointSet_RE_wld = data.RRpointSet_RE_wld;             forPLA_normalWP = data.forPLA_normalWP;                 mu_GlasstoOCA = data.mu_GlasstoOCA;                               softLLTracing = data.softLLTracing;                           
HardVATargetHigh = data.HardVATargetHigh;                     RV_Design = data.RV_Design;                             forPLA_outsidePrism = data.forPLA_outsidePrism;         mu_LenstoOCA = data.mu_LenstoOCA;                                 systemTiltAngle = data.systemTiltAngle;                       
HardVATargetLow = data.HardVATargetLow;                       UV_normal1 = data.UV_normal1;                           forcePupilEdgeInverse = data.forcePupilEdgeInverse;     mu_OCAtoDisplayCover = data.mu_OCAtoDisplayCover;                 tVeryBegining = data.tVeryBegining;                           
HardVATargetStep = data.HardVATargetStep;                     VE_EyePoint = data.VE_EyePoint;                         glassThickness = data.glassThickness;                   mu_OCAtoGlass = data.mu_OCAtoGlass;                               targetName = data.targetName;                                 
HardVA_Design = data.HardVA_Design;                           VE_originalPoint = data.VE_originalPoint;               glassThicknessPool = data.glassThicknessPool;           mu_airtoLens = data.mu_airtoLens;                                 temp1 = data.temp1;                                           
I = data.I;                                                   WD = data.WD;                                           glassThickness_Design = data.glassThickness_Design;     numII = data.numII;                                               temp_normalGP = data.temp_normalGP;                           
LRA = data.LRA;                                               WDForAutoGP = data.WDForAutoGP;                         glass_n = data.glass_n;                                 numLensYOriginal = data.numLensYOriginal;                         thetaPolarAngle = data.thetaPolarAngle;                       
LREL = data.LREL;                                             WDz = data.WDz;                                         gp_PBA_array = data.gp_PBA_array;                       outputA = data.outputA;                                           thetaPolarAngle_original = data.thetaPolarAngle_original;     
LensHeightEachLenticular = data.LensHeightEachLenticular;     air_n = data.air_n;                                     isLLSameAsPanel = data.isLLSameAsPanel;                 outputD = data.outputD;                                           totalName = data.totalName;                                   
LensRadiusEachLenticular = data.LensRadiusEachLenticular;     asph_leftEnd_normal = data.asph_leftEnd_normal;         lengthZRay2Default = data.lengthZRay2Default;           outputL = data.outputL;                                           varName = data.varName;                                       
LouieAnalysis = data.LouieAnalysis;                           asph_max_height = data.asph_max_height;                 lengthZRay3Default = data.lengthZRay3Default;           outputO = data.outputO;                                           varTypes = data.varTypes;                                     
M00TargetHigh = data.M00TargetHigh;                           asph_rightEnd_normal = data.asph_rightEnd_normal;       lensAperturePool = data.lensAperturePool;               p1 = data.p1;                                                     verticalPointNum = data.verticalPointNum;                     
M00TargetLow = data.M00TargetLow;                             aspherical = data.aspherical;                           lensArraySizeHor = data.lensArraySizeHor;               p2 = data.p2;                                                     viewAngleHor = data.viewAngleHor;                             
M00TargetStep = data.M00TargetStep;                           asphericalMat = data.asphericalMat;                     lensArraySizeVer = data.lensArraySizeVer;               panelSizeHor = data.panelSizeHor;                                 viewAngleVer = data.viewAngleVer;                             
M_Design = data.M_Design;                                     binoDistance = data.binoDistance;                       lensCenter_x_fitting = data.lensCenter_x_fitting;       panelSizeHorLL = data.panelSizeHorLL;                             viewPointHor = data.viewPointHor;                             
OCAThickness = data.OCAThickness;                             c = data.c;                                             lensHeightDefault = data.lensHeightDefault;             panelSizeVer = data.panelSizeVer;                                 viewPointVer = data.viewPointVer;                             
OCA_n = data.OCA_n;                                           condition = data.condition;                             lensHeightEI0 = data.lensHeightEI0;                     panelSizeVerLL = data.panelSizeVerLL;                             wedgeHalfHeight = data.wedgeHalfHeight;                       
PBA = data.PBA;                                               continueWarning1 = data.continueWarning1;               lensPitch = data.lensPitch;                             phiAzimuthalAngle = data.phiAzimuthalAngle;                       wedgeMaxHeight = data.wedgeMaxHeight;                         
PBA1_fit_length = data.PBA1_fit_length;                       continueWarning2 = data.continueWarning2;               lensPitchPool = data.lensPitchPool;                     phiAzimuthalAngle_original = data.phiAzimuthalAngle_original;     wedgePBA = data.wedgePBA;                                     
PBA1_fit_line = data.PBA1_fit_line;                           continue_flag_desgin = data.continue_flag_desgin;       lensPitch_Design = data.lensPitch_Design;               preciseGP = data.preciseGP;                                       wedgePRA = data.wedgePRA;                                     
PBA1_fit_num = data.PBA1_fit_num;                             designCount = data.designCount;                         lensRadius = data.lensRadius;                           prismLensGap = data.prismLensGap;                                 wedgePrism = data.wedgePrism;                                 
PBA1_fit_point = data.PBA1_fit_point;                         designEI = data.designEI;                               lensRadiusDefault = data.lensRadiusDefault;             prismMode = data.prismMode;                                       wedgeVer = data.wedgeVer;                                     
PBA1_fit_x = data.PBA1_fit_x;                                 designPosition = data.designPosition;                   lensRadiusOriginal = data.lensRadiusOriginal;           prismSizeHor = data.prismSizeHor;                                 wedge_normal = data.wedge_normal;                             
PBA1_fit_y = data.PBA1_fit_y;                                 design_cal_once_1 = data.design_cal_once_1;             lensRadiusPool = data.lensRadiusPool;                   prismSizeVer = data.prismSizeVer;                                 whichCode = data.whichCode;                                   
PBA_InputArray = data.PBA_InputArray;                         displayCoverThickness = data.displayCoverThickness;     lensRadius_Design = data.lensRadius_Design;             prismStructure = data.prismStructure;                             whichpba = data.whichpba;                                     
PBA_array_forPLA = data.PBA_array_forPLA;                     displayCover_n = data.displayCover_n;                   lensSubstrate = data.lensSubstrate;                     prismSubstrate = data.prismSubstrate;                             widthStart = data.widthStart;                                 
PBA_array_forPLA_2 = data.PBA_array_forPLA_2;                 effectiveG = data.effectiveG;                           lensThicknessEI0 = data.lensThicknessEI0;               prism_n = data.prism_n;                                           widthStep = data.widthStep;                                   
PLA_array_fromPBA = data.PLA_array_fromPBA;                   eyeMode = data.eyeMode;                                 lens_n = data.lens_n;                                   pupilSize = data.pupilSize;                                       wp_PBA = data.wp_PBA;                                         
PLA_array_fromPBA_2 = data.PLA_array_fromPBA_2;               farrestDistanceHor = data.farrestDistanceHor;           ll_array = data.ll_array;                               rangeY = data.rangeY;                                             xNumMax = data.xNumMax;                                       
PLAtoPBAFunction = data.PLAtoPBAFunction;                     farrestDistanceVer = data.farrestDistanceVer;                                                                                                                                                                                                   
        break
    end
    while whichCode == "XYGrid"
AS_XYGrid = data.AS_XYGrid;                                   RRpointSet_LE_wld = data.RRpointSet_LE_wld;             figXYGrid_AS = data.figXYGrid_AS;                               mu1 = data.mu1;                                                   rotPhi = data.rotPhi;                                         
AUFMode = data.AUFMode;                                       RRpointSet_ME_wld = data.RRpointSet_ME_wld;             figXYGrid_M = data.figXYGrid_M;                                 mu2 = data.mu2;                                                   rotWedgePRA = data.rotWedgePRA;                               
AimSphere_grid = data.AimSphere_grid;                         RRpointSet_RE_wld = data.RRpointSet_RE_wld;             figXYGrid_RP = data.figXYGrid_RP;                               mu_GlasstoOCA = data.mu_GlasstoOCA;                               rotationMatrix = data.rotationMatrix;                         
CDP = data.CDP;                                               RV_XYGrid = data.RV_XYGrid;                             figXYGrid_RV = data.figXYGrid_RV;                               mu_LenstoOCA = data.mu_LenstoOCA;                                 showAUF = data.showAUF;                                       
EIHor = data.EIHor;                                           RV_grid = data.RV_grid;                                 figXYGrid_TIR = data.figXYGrid_TIR;                             mu_OCAtoDisplayCover = data.mu_OCAtoDisplayCover;                 showAsph = data.showAsph;                                     
GPMode = data.GPMode;                                         TIR_XYGrid = data.TIR_XYGrid;                           focal = data.focal;                                             mu_OCAtoGlass = data.mu_OCAtoGlass;                               showGP = data.showGP;                                         
GRLMat = data.GRLMat;                                         TIR_grid = data.TIR_grid;                               forPLA_incident = data.forPLA_incident;                         mu_airtoLens = data.mu_airtoLens;                                 showGRL = data.showGRL;                                       
GRLMode = data.GRLMode;                                       UV_normal1 = data.UV_normal1;                           forPLA_insidePrism = data.forPLA_insidePrism;                   numII = data.numII;                                               showLRA = data.showLRA;                                       
GRLNumShift = data.GRLNumShift;                               VE_EyePoint = data.VE_EyePoint;                         forPLA_mu_PrismtoAir = data.forPLA_mu_PrismtoAir;               numLensYOriginal = data.numLensYOriginal;                         showMaxMin = data.showMaxMin;                                 
I = data.I;                                                   VE_originalPoint = data.VE_originalPoint;               forPLA_mu_airtoPrism = data.forPLA_mu_airtoPrism;               outputA = data.outputA;                                           showPRA = data.showPRA;                                       
LCLengthHor = data.LCLengthHor;                               WD = data.WD;                                           forPLA_normalGP = data.forPLA_normalGP;                         outputD = data.outputD;                                           showWP = data.showWP;                                         
LCLengthVer = data.LCLengthVer;                               WDForAutoGP = data.WDForAutoGP;                         forPLA_normalWP = data.forPLA_normalWP;                         outputIIName = data.outputIIName;                                 sizeforRangeY = data.sizeforRangeY;                           
LRA = data.LRA;                                               WD_PLArray = data.WD_PLArray;                           forPLA_outsidePrism = data.forPLA_outsidePrism;                 outputL = data.outputL;                                           systemTiltAngle = data.systemTiltAngle;                       
LREL = data.LREL;                                             WDz = data.WDz;                                         forcePupilEdgeInverse = data.forcePupilEdgeInverse;             outputManual = data.outputManual;                                 tVeryBegining = data.tVeryBegining;                           
LensHeightEachLenticular = data.LensHeightEachLenticular;     air_n = data.air_n;                                     glassThickness = data.glassThickness;                           outputO = data.outputO;                                           targetWithinPanel = data.targetWithinPanel;                   
LensRadiusEachLenticular = data.LensRadiusEachLenticular;     asph_leftEnd_normal = data.asph_leftEnd_normal;         glass_n = data.glass_n;                                         overwrite = data.overwrite;                                       temp_normalGP = data.temp_normalGP;                           
M_XYGrid = data.M_XYGrid;                                     asph_max_height = data.asph_max_height;                 gp_PBA_array = data.gp_PBA_array;                               p1 = data.p1;                                                     testMatrix = data.testMatrix;                                 
M_grid = data.M_grid;                                         asph_rightEnd_normal = data.asph_rightEnd_normal;       isLLSameAsPanel = data.isLLSameAsPanel;                         p2 = data.p2;                                                     thetaPolarAngle = data.thetaPolarAngle;                       
OCAThickness = data.OCAThickness;                             aspherical = data.aspherical;                           lengthZRay2Default = data.lengthZRay2Default;                   panelSizeHor = data.panelSizeHor;                                 thetaPolarAngle_original = data.thetaPolarAngle_original;     
OCA_n = data.OCA_n;                                           asphericalMat = data.asphericalMat;                     lengthZRay3Default = data.lengthZRay3Default;                   panelSizeHorLL = data.panelSizeHorLL;                             thetaPolar_PLArray = data.thetaPolar_PLArray;                 
PBA = data.PBA;                                               axXYGrid_AS = data.axXYGrid_AS;                         lensAperturePool = data.lensAperturePool;                       panelSizeVer = data.panelSizeVer;                                 viewAngleHor = data.viewAngleHor;                             
PBA1_fit_length = data.PBA1_fit_length;                       axXYGrid_M = data.axXYGrid_M;                           lensArraySizeHor = data.lensArraySizeHor;                       panelSizeVerLL = data.panelSizeVerLL;                             viewAngleVer = data.viewAngleVer;                             
PBA1_fit_line = data.PBA1_fit_line;                           axXYGrid_RP = data.axXYGrid_RP;                         lensArraySizeVer = data.lensArraySizeVer;                       parameter = data.parameter;                                       viewPointHor = data.viewPointHor;                             
PBA1_fit_num = data.PBA1_fit_num;                             axXYGrid_RV = data.axXYGrid_RV;                         lensCenterUserDefined_Hor = data.lensCenterUserDefined_Hor;     phiAzimuthalAngle = data.phiAzimuthalAngle;                       viewPointVer = data.viewPointVer;                             
PBA1_fit_point = data.PBA1_fit_point;                         axXYGrid_TIR = data.axXYGrid_TIR;                       lensCenterUserDefined_Ver = data.lensCenterUserDefined_Ver;     phiAzimuthalAngle_original = data.phiAzimuthalAngle_original;     wedgeHalfHeight = data.wedgeHalfHeight;                       
PBA1_fit_x = data.PBA1_fit_x;                                 binoDistance = data.binoDistance;                       lensCenter_x_fitting = data.lensCenter_x_fitting;               phiAzimuthal_PLArray = data.phiAzimuthal_PLArray;                 wedgeMaxHeight = data.wedgeMaxHeight;                         
PBA1_fit_y = data.PBA1_fit_y;                                 customLine = data.customLine;                           lensHeightDefault = data.lensHeightDefault;                     preciseGP = data.preciseGP;                                       wedgePBA = data.wedgePBA;                                     
PBA_InputArray = data.PBA_InputArray;                         displayCoverThickness = data.displayCoverThickness;     lensHeightEI0 = data.lensHeightEI0;                             prismLensGap = data.prismLensGap;                                 wedgePRA = data.wedgePRA;                                     
PBA_array_forPLA = data.PBA_array_forPLA;                     displayCover_n = data.displayCover_n;                   lensPitch = data.lensPitch;                                     prismMode = data.prismMode;                                       wedgePrism = data.wedgePrism;                                 
PBA_array_forPLA_2 = data.PBA_array_forPLA_2;                 display_CDP = data.display_CDP;                         lensRadius = data.lensRadius;                                   prismSizeHor = data.prismSizeHor;                                 wedgeVer = data.wedgeVer;                                     
PLA_array_fromPBA = data.PLA_array_fromPBA;                   display_EyeMode = data.display_EyeMode;                 lensRadiusDefault = data.lensRadiusDefault;                     prismSizeVer = data.prismSizeVer;                                 wedge_normal = data.wedge_normal;                             
PLA_array_fromPBA_2 = data.PLA_array_fromPBA_2;               display_LensInfo = data.display_LensInfo;               lensRadiusOriginal = data.lensRadiusOriginal;                   prismStructure = data.prismStructure;                             whichCode = data.whichCode;                                   
PLAtoPBAFunction = data.PLAtoPBAFunction;                     display_PrismInfo = data.display_PrismInfo;             lensSubstrate = data.lensSubstrate;                             prismSubstrate = data.prismSubstrate;                             whichpba = data.whichpba;                                     
PRA = data.PRA;                                               display_PupilSize = data.display_PupilSize;             lensThicknessEI0 = data.lensThicknessEI0;                       prism_n = data.prism_n;                                           widthStart = data.widthStart;                                 
RDP = data.RDP;                                               display_RDP = data.display_RDP;                         lens_n = data.lens_n;                                           pupilSize = data.pupilSize;                                       widthStep = data.widthStep;                                   
RDP_PLArray = data.RDP_PLArray;                               display_STA = data.display_STA;                         ll_array = data.ll_array;                                       pupilSize_PLArray = data.pupilSize_PLArray;                       wp_PBA = data.wp_PBA;                                         
RP_XYGrid = data.RP_XYGrid;                                   display_VA = data.display_VA;                           ll_down = data.ll_down;                                         rangeY = data.rangeY;                                             writeFig = data.writeFig;                                     
RP_grid = data.RP_grid;                                       effectiveG = data.effectiveG;                           ll_left = data.ll_left;                                         rangeYPitch = data.rangeYPitch;                                   xNumMax = data.xNumMax;                                       
RPpointSet_LE_wld = data.RPpointSet_LE_wld;                   eyeMode = data.eyeMode;                                 ll_right = data.ll_right;                                       rotLRA = data.rotLRA;                                             whichLCVer = data.whichLCVer;                                 
RPpointSet_ME_wld = data.RPpointSet_ME_wld;                   farrestDistanceHor = data.farrestDistanceHor;           ll_up = data.ll_up;                                             rotPRA = data.rotPRA;                                             whichLCHor = data.whichLCHor;                                 
RPpointSet_RE_wld = data.RPpointSet_RE_wld;                   farrestDistanceVer = data.farrestDistanceVer;           mid_PLA = data.mid_PLA;                                                                                                                                                                         
        break
    end
    %% common (待處理)
    if whichCode == "II"
        TIRHappen = 0;
    end
    %% 決定輸出要為 data 或是 segM00, 其他處理
    while 1
        segM00_now = 0;
        if length(varargin) == 1 && varargin{1} == 1; segM00_now = 1; end     % determine segM00_now
        if length(varargin) == 2 && varargin{1} == 2; segM00_now = 2; end     % determine segM00_now + BLP Mode
        if segM00_now == 1 % 計算 M00
            pupilSize = 0; 
            RDP = 0;
            RRRMode = 0;
        end
        if segM00_now == 2 % BLPROI mode: VZawPS (II-BLP Only)
            pupilSize = varargin{2};
            RDP = 0;
            RRRMode = 0;
        end
        if whichCode == "VZA"   % VZA code 不需要 RR
            RDP = 0;
        end
        if whichCode == "XYGrid"
            softLLTracing = 0;  % XYGrid code 沒有根數概念
        end

        % unified coordinate system (zero point: panel center)
        warningTIR = 0; % 僅提示一次 (20230829)
        if whichCode == "M00Curve"
            M00MatrixPadded = nan(length(rangeY),segNum+1,3); % 左中右眼
            ASMatrixPadded = nan(length(rangeY),segNum+1,3);
            RVMatrixPadded = nan(length(rangeY),segNum+1,3);
        end
        if whichCode == "XYGrid"
            % XYGrid GRL handle %
            xBefore = lensCenterUserDefined_Ver(whichLCVer);
            yBefore = lensCenterUserDefined_Hor(whichLCHor);
            temp1228 = rotationMatrix * [xBefore;yBefore];
            xAfter = temp1228(1);yAfter = temp1228(2);
            % 檢查 yAfter 決定 要帶的 Radius (網格近似)
            numLens = length(LREL);
            temp12228_2 = (numLens - 1)*0.5;
            yAfterShift = yAfter + temp12228_2 * lensPitch + 0.5 * lensPitch;
            whichLensForXYGrid = fix(yAfterShift / lensPitch) + 1;
            testMatrix(whichLCVer,whichLCHor) = whichLensForXYGrid;
            if whichLensForXYGrid > numLens % 20221229
                whichLensForXYGrid = numLens;
            end
        end
        break
    end
    
    %% loop begin
    for whichEye = eyeMode 
        lensCount = 0;
        for whichLens = rangeY
            % break_flag = 0; % 是否 break 判定 (跳下一顆Lens)
            lensCount = lensCount + 1;
            %% Lens Top Bottom 計算
            while 1
                if LRA == 0
                    lensCenterTop = [-panelSizeVerLL*0.5 ; whichLens*lensPitch];
                    lensCenterBottom = [panelSizeVerLL*0.5 ; whichLens*lensPitch];
                end
                if LRA ~= 0
                    Cpoint = [0; whichLens*rangeYPitch]; % midpoint for each lens
                    lensCenterTop = LensCenter_xy_Generator(-1,Cpoint,LRA,ll_array);
                    lensCenterBottom = LensCenter_xy_Generator(1,Cpoint,LRA,ll_array);
                    %% software method: LRA angle rectangle cover with vertex of panel
                    if softLLTracing == 1
                        lensCenterMid = [-sind(LRA) * whichLens * lensPitch; cosd(LRA) * whichLens * lensPitch];
                        lengthInclineLL_ver =  panelSizeVerLL * cosd(LRA) + panelSizeHorLL * sind(LRA);
                        vectorInclineLL = [cosd(LRA);sind(LRA)];
                        lensCenterFinalTop = lensCenterMid - 0.5*lengthInclineLL_ver * vectorInclineLL;
                        lensCenterFinalBottom = lensCenterMid + 0.5*lengthInclineLL_ver * vectorInclineLL;
                        lensCenterTop = lensCenterFinalTop;
                        lensCenterBottom = lensCenterFinalBottom;
                    end
                end
            break
            end
            
            %% seg assignment, 其他參數初始化
            while 1
                if ismember(whichCode,["FindGRL","Design","XYGrid"])
                    rangeX = 1; % 只跑一個分段點
                else
                    switch whichEye
                        case -1
                            rangeX = segM00.segmentPoint_Matrix{1,lensCount,1};
                        case 0
                            rangeX = segM00.segmentPoint_Matrix{1,lensCount,2};
                        case 1
                            rangeX = segM00.segmentPoint_Matrix{1,lensCount,3};
                    end
                end
    
                XStepNum = length(rangeX) - 1;
                finalPosition = rangeX;
    
                M00Array = nan(1,XStepNum+1); % for M00
                RPCenterArray = nan(3,XStepNum+1);  % for M00
                %%
                if whichCode == "M00Curve"
                    M00Arraytemp = nan(1,XStepNum+1);
                    ASArraytemp = nan(1,XStepNum+1);
                    RVArraytemp = nan(1,XStepNum+1);
                end
                lensCenterArray = [linspace(lensCenterTop(1),lensCenterBottom(1),rangeX(end));...
                                   linspace(lensCenterTop(2),lensCenterBottom(2),rangeX(end))];
                if ismember(whichCode, ["FindGRL"]) % 跑每根 Lens 中點
                    lensCenterArray = 0.5 * (lensCenterTop + lensCenterBottom);
                end
                if whichCode == "XYGrid"
                    lensCenterArray = [lensCenterUserDefined_Ver(whichLCVer);lensCenterUserDefined_Hor(whichLCHor)];
                end
                if whichCode == "Design"
                    switch verticalPointNum
                        case -999 % very top
                            lensCenterArray = lensCenterTop;
                        case 999 % very bottom
                            lensCenterArray = lensCenterBottom;
                        case 1 % midpoint
                            lensCenterArray = 0.5 * (lensCenterTop + lensCenterBottom);
                    end
                end
                % 紀錄 lens center x 20230901
                lensCenter_x_fitting(lensCount,:) = [lensCenterTop(1),lensCenterBottom(1)];
            break
            end
            segCount = 0; % 分段點數
            
            %% segment loop  
            for whichSeg = rangeX
                break_flag = 0; % 20230829
                segCount = segCount + 1;
                %% lens center
                lensCenter_xy = lensCenterArray(:,whichSeg);
                
                %% pupil center
                pupilCenter_xy = [0;whichEye*binoDistance*0.5]; %以眼球中心為零點
                % HVA90 270 ... 以外都要旋轉 (雙眼中心)
                if mod(phiAzimuthalAngle-90,180)~=0
                    pupilCenter_norot=[pupilCenter_xy;0];
                    pupilCenter_rot=rotPhi*pupilCenter_norot;
                    pupilCenter_xy=pupilCenter_rot(1:2);
                end
                pupilCenter_xy = pupilCenter_xy + [viewPointVer ; viewPointHor];

                %% GP PBA determination (@ lens center)    
                while 1
                    if prismMode == 1 && GPMode == 1 && length(PBA) == 1
                        % update wedge height
                        if wedgePrism == 1
                            wedgeHeight = getWedgeHeight(lensCenter_xy,rotWedgePRA,wedgeVer,wedgePBA);
                        elseif wedgePrism == 0
                            wedgeHeight = 0;
                        end
                        % set: substrate top Z = 0
                        QP = [lensCenter_xy;wedgeHeight];
                        VEP = VE_EyePoint; VEP_XY = VEP(1:2);
                        QV = VEP - QP; % query vector
                        if norm(VEP_XY)~=0 
                            Length_LensVirtualEye_1 = abs(lensCenter_xy'*VEP_XY-norm(VEP_XY)^2)/norm(VEP_XY); % 點到線距離
                            % 判斷 L 正負 20230808
                            % 假設 零點 (0,0) 一定在虛擬眼之上
                            % if L 和 零點 在切線同一側: L > 0
                            % 切線方程式: E𝑦∗𝑦+𝐸𝑥∗𝑥−(𝐸𝑦^2+𝐸𝑥^2)=0
                            centerSide = -norm(VEP_XY(1:2))^2;
                            targetSide = lensCenter_xy(1:2)'*VEP_XY(1:2) - norm(VEP_XY(1:2))^2;
                            if centerSide*targetSide < 0;Length_LensVirtualEye_1 = -Length_LensVirtualEye_1;end
                        elseif norm(VEP_XY)==0 % 虛擬眼睛與面板中心重疊時
                            if PRA == 0
                                Length_LensVirtualEye_1 = -lensCenter_xy(1);
                            elseif PRA ==90 || PRA ==-90
                                Length_LensVirtualEye_1 = -lensCenter_xy(2);
                            else
                                Length_LensVirtualEye_1 = -lensCenter_xy(1)*cosd(PRA);
                            end
                        end
                        PLA_desired = atand(Length_LensVirtualEye_1/QV(3));
    %                     PBA_desired = interp1(PLA_array_fromPBA,PBA_array_forPLA,PLA_desired); 
                        PBA_desired = PLAtoPBAFunction(PLA_desired);
                    elseif prismMode == 1 && GPMode == 1 && length(PBA) > 1
                        lensCenterForGP_tf = [lensCenter_xy(2);-lensCenter_xy(1)];
                        if PRA~=90 && PRA~=-90
                            PBA1_Ldesired = abs(lensCenterForGP_tf(1)*sind(PRA)-lensCenterForGP_tf(2)*cosd(PRA)+PBA1_fit_length*0.5);
                        else
                            PBA1_Ldesired = abs(lensCenterForGP_tf(1) - (-sind(PRA)*panelSizeVer*0.5));
                        end
                        whichpba=1;
                        while 1 %找要代到哪一條線段
                            if whichpba == PBA1_fit_num
                                ThrowError("General",14);
                            end
                            % 該點位於面板外的情形
                            if PBA1_Ldesired < PBA1_fit_point(1,1)
                                PBA_desired = PBA1_fit_line(1,1) * PBA1_Ldesired + PBA1_fit_line(2,1);
                                break
                            elseif PBA1_Ldesired > PBA1_fit_point(1,end)
                                PBA_desired = PBA1_fit_line(1,end) * PBA1_Ldesired + PBA1_fit_line(2,end);
                                break
                            end
                            if PBA1_fit_point(1,whichpba)<= PBA1_Ldesired && PBA1_fit_point(1,whichpba+1)>= PBA1_Ldesired
                                PBA_desired = PBA1_fit_line(1,whichpba) * PBA1_Ldesired + PBA1_fit_line(2,whichpba);
                                whichpba = 1;
                                break
                            end
                            whichpba = whichpba + 1;
                        end    
                    elseif prismMode==1 && GPMode == 0
                        PBA_desired = PBA;
                    else % 無 Prism
                        PBA_desired = 0;
                    end
                    UV_normal2=[-sind(PBA_desired);0;-cosd(PBA_desired)]; % 出Prism斜面法向量  
                    UV_normal2 = rotPRA * UV_normal2; % 旋轉法向量
                break
                end
                
                %% LensAperture Loop setup
                widthCount = 0;
                RRPointFromLeftPupilEdgeArrayAUF = cell(1,length(lensAperturePool));
                RRPointFromRightPupilEdgeArrayAUF = cell(1,length(lensAperturePool));
                RPPointFromLeftPupilEdgeArrayAUF = cell(1,length(lensAperturePool));
                RPPointFromRightPupilEdgeArrayAUF = cell(1,length(lensAperturePool));
                
                %% AUF loop
                for lensAperture = lensAperturePool
                    widthCount = widthCount + 1;                 
                    % parameter update
                    % 20231123
                    % 每段 system thickness 相同
             
                    % gradient lens radius
                    if aspherical == 0
                        if GRLMode == 1
                            if whichCode == "XYGrid"
                                lensRadius = LREL(whichLensForXYGrid); %20221228
                            else
                                lensRadius = LREL(GRLNumShift+whichLens+0.5*(numLensYOriginal+1)); % lensRadius becomes variable
                            end
                        end 
                        lensFullHeight = lensRadius - sqrt(lensRadius^2 - (lensPitch*0.5)^2); % 只要是同一根Lens， 值就是相同
                        lensHeight = lensRadius - sqrt(lensRadius^2 - (lensAperture*0.5)^2);
                    elseif aspherical == 1
                        lensFullHeight = lensHeightDefault; % (asph_max_height)
                        lensHeight = lensHeightDefault;     % (asph_max_height)
                    end
                    lensFH_minus_H = lensFullHeight - lensHeight;
                    lensHD_minus_FH = lensHeightDefault - lensFullHeight;
                    lengthZRay3 = lensHeight + prismLensGap + lensHD_minus_FH;  % Prism 結構半高 到 Lens Edge
                    lensThickness = lensSubstrate + lensFullHeight; % 各自 Lens 高 (不受 AUF 影響)
                    
                    % lensHeightDefault; % EI 0 Lens 高: 通常最高，通常代表系統高度
                    systemThickness = displayCoverThickness + OCAThickness*2 + glassThickness + lensSubstrate + lensHeightDefault +...
                                    + prismLensGap + prismStructure/2 + prismSubstrate;       % always fixed

                    Z_lensEdge = displayCoverThickness + OCAThickness*2 + glassThickness + lensThickness - lensHeight;
                    Z_pupil = systemThickness + WDz; % WDR 從 prism substrate top 開始算起 

                    %% pupil edge loop
                    if whichCode == "M00Curve"
                        % Aim sphere
                        AS_two = nan(1,2);
                    end
                    for whichPupilEdge = [-1 1]
                        % locate pupil edge and lens edge % (align with LRA)
                        % note: zero point --> panel center
                        vector_beforeRot_lens = [0;whichPupilEdge*0.5*lensAperture;0];
                        temp_rot = rotLRA * vector_beforeRot_lens;
                        final_lensEdge = lensCenter_xy + temp_rot(1:2); % [2D]
                        % 20230717_18 PupilEdge 要反轉 @ 純虛像
                        if forcePupilEdgeInverse == 1
                            vector_beforeRot_pupil = [0;-whichPupilEdge*pupilSize;0];
                        elseif forcePupilEdgeInverse == 0
                            vector_beforeRot_pupil = [0;whichPupilEdge*pupilSize;0];
                        end
                        temp_rot = rotLRA * vector_beforeRot_pupil;
                        final_PupilEdge = [pupilCenter_xy;Z_pupil] + temp_rot; % [3D]
                        
                        % ray tracing (prism part) %
                        % pupil center: zero point
                        % update: wedge prism 20230725
                        % system top: thickness without wedge (lengthZRay2Default)
                        final_goal = [final_lensEdge;Z_lensEdge];% lens edge position
                        if prismMode==1 %有 Prism Case
                            % point eye center == zero point
                            % vector OA: vector between pupil edge and prism top %
                            % first loop assumption: point A has XY the same as lens edge
                            pointEye = final_PupilEdge;
                            pointA = [final_lensEdge;systemThickness]; % X Y 必錯
                            vectorOA = pointA - pointEye;
                            dev = [0,0,0]; % deviation 向量
                            step = 0; % IPA Loop
                            while 1 % Tracing Through Prism (For prism case) % <<DeV Factor 恰為1>>
                                vectorOA = vectorOA - [dev(1);dev(2);0]; % 該座標的XY為LENS層的XY (第一次必錯) A為向量
                                pointA = vectorOA + pointEye;
                                % update thickness Z for point A and vector OA 20230725
                                if wedgePrism == 1
                                    wedgeHeight = getWedgeHeight(pointA,rotWedgePRA,prismSizeVer,wedgePBA);
                                    pointA(3) = systemThickness + wedgeHeight;
                                    vectorOA = pointA - pointEye;
                                    % other update
                                    UV_normal_prismTop = wedge_normal;
                                    lengthZRay2 = lengthZRay2Default + wedgeHeight;
                                elseif wedgePrism == 0
                                    UV_normal_prismTop = UV_normal1;
                                    lengthZRay2 = lengthZRay2Default;
                                    wedgeHeight = 0;
                                end
                                % update PBA from pointA 20231027
                                if preciseGP == 1
                                    PBA_desired = PBAUpdate(pointA,wedgeHeight,VE_EyePoint,PLA_array_fromPBA,PBA_array_forPLA,PRA);                      
                                    UV_normal2 = [-sind(PBA_desired);0;-cosd(PBA_desired)]; % 出Prism斜面法向量
                                    UV_normal2 = rotPRA * UV_normal2; % 旋轉法向量
                                end
                                % 20230725
                                unitOA = vectorOA/norm(vectorOA);
                                unitAB = sqrt(1-mu1^2*(1-(UV_normal_prismTop'*unitOA)^2))*UV_normal_prismTop+...
                                        mu1*(unitOA-(UV_normal_prismTop'*unitOA)*UV_normal_prismTop); %snell's law 第一面
                                pointB = pointA + unitAB*(-lengthZRay2)/unitAB(3); % lower prism
                                pointSubstrateTop = pointA + unitAB*(-wedgeHeight)/unitAB(3); % substrate top @20230725
                                unitBC=sqrt(1-mu2^2*(1-(UV_normal2'*unitAB)^2))*UV_normal2+...
                                    mu2*(unitAB-(UV_normal2'*unitAB)*UV_normal2);  %snell's law 第二面
                                pointC = pointB+unitBC*(-lengthZRay3)/unitBC(3); %lensedge
                                dev = pointC - final_goal;
                                if sqrt(dev(1)^2+dev(2)^2)<1e-6 %誤差越小越好 其值待商榷!
                                    break
                                end
                                step = step + 1;
                            end
                        elseif prismMode==0 % 無 Prism Case
                            unitBC=(final_goal-final_PupilEdge)/norm(final_goal-final_PupilEdge); %眼睛邊緣到Lens邊緣單位方向向量
                            pointB=0;pointC=final_goal;pointA=pointC;
                            pointSubstrateTop = pointC;
                        end
                    
                        % Tracing through panel %      % <目前中心已位於眼球中央> <向下Z為負>
                        % get lens normal
                        if aspherical == 0
                            Lens_tempx=sqrt(lensRadius^2-(0.5*lensAperture)^2); % Lens邊緣到圓心的Z距離
                            Lens_center=[lensCenter_xy;Z_lensEdge-Lens_tempx];  % 眼球往下Z為負 % 20220713
                            Lens_normal_unit=(Lens_center-final_goal)/norm(Lens_center-final_goal); % <球面過邊緣點法向量>
                        elseif aspherical == 1 % aspherical critical section % 20230717
                            if whichPupilEdge == -1
                                Lens_normal_unit = asph_leftEnd_normal;
                            elseif whichPupilEdge == 1
                                Lens_normal_unit = asph_rightEnd_normal;
                            end
                            % 考量 LRA
                            Lens_normal_unit =  rotLRA * Lens_normal_unit;
                        end
                    
                        % Snell's law in 3D %% normal向量正負要注意!
                        % (簡化)進出Glass的單位方向向量相同 -->中間玻璃層不跑　少跑一層
                        unit_airtoLens=sqrt(1-mu_airtoLens^2*(1-(Lens_normal_unit'*unitBC)^2))*Lens_normal_unit+...
                            mu_airtoLens*(unitBC-(Lens_normal_unit'*unitBC)*Lens_normal_unit); %snell's law <air到Lens> 
                        unit_LenstoOCA=sqrt(1-mu_LenstoOCA^2*(1-(UV_normal1'*unit_airtoLens)^2))*UV_normal1+...
                            mu_LenstoOCA*(unit_airtoLens-(UV_normal1'*unit_airtoLens)*UV_normal1); %snell's law <Lens到OCA>
                        unit_OCAtoGlass=sqrt(1-mu_OCAtoGlass^2*(1-(UV_normal1'*unit_LenstoOCA)^2))*UV_normal1+...
                            mu_OCAtoGlass*(unit_LenstoOCA-(UV_normal1'*unit_LenstoOCA)*UV_normal1); %snell's law <OCA到Glass>
                        unit_GlasstoOCA=unit_LenstoOCA;
                        unit_OCAtoCoverglass=sqrt(1-mu_OCAtoDisplayCover^2*(1-(UV_normal1'*unit_GlasstoOCA)^2))*UV_normal1+...
                            mu_OCAtoDisplayCover*(unit_GlasstoOCA-(UV_normal1'*unit_GlasstoOCA)*UV_normal1); %snell's law <OCA到coverglass>

                        % 點整理 
                        point_pupiledge=final_PupilEdge;point_systemTop=pointSubstrateTop; % 20230725 pointSubstrateTop
                        point_lowerprism=pointB;point_lensedge=pointC;  
                        point_onPanel= point_lensedge + ...
                                    unit_airtoLens*(-(lensThickness-lensHeight))/unit_airtoLens(3) + ...
                                    unit_LenstoOCA*(-OCAThickness)/unit_LenstoOCA(3)+ ...
                                    unit_OCAtoGlass*(-glassThickness)/unit_OCAtoGlass(3) + ...
                                    unit_GlasstoOCA*(-OCAThickness)/unit_GlasstoOCA(3) + ...
                                    unit_OCAtoCoverglass*(-displayCoverThickness)/unit_OCAtoCoverglass(3);    
                        t=whichPupilEdge*0.5+1.5;t=uint8(t);
                        outputO(:,t)=point_pupiledge;
                        outputA(:,t)=point_systemTop;
                        outputD(:,t)=point_onPanel;
                        outputL(:,t)=point_lensedge; % for no prism case

                        % aim sphere %% for M00Curve Coding
                        % in: vector in cover glass
                        % out: vector in air (above Panel)
                        % aim sphere angle: out vector with Z axis
                        if whichCode == "M00Curve" || whichCode == "XYGrid"
                            mu_DisplayCovertoAir = displayCover_n/1;
                            unit_toAirPanel = sqrt(1-mu_DisplayCovertoAir^2*(1-(UV_normal1'*unit_OCAtoCoverglass)^2))*UV_normal1+...
                                mu_DisplayCovertoAir*(unit_OCAtoCoverglass-(UV_normal1'*unit_OCAtoCoverglass)*UV_normal1);
                            aimSphereAngle = abs(acosd(dot(unit_toAirPanel,[0;0;-1])/norm(unit_toAirPanel)));
                            AS_two(t) = aimSphereAngle;
                        end
                    end
                    %% if 發生全反射: Break (Flag) 到下一段 20230829
                    if ~isreal(outputD) 
                        if warningTIR == 0
                            cprintf([1,0.5,0],strcat("[warning] TIR 發生 (PS",num2str(pupilSize),")\n"))
                            warningTIR = 1;
                        end
                        TIRHappen = 1;
                        break_flag = 1;
                        if whichCode == "M00Curve" % 紀錄 -1
                            M00Arraytemp(segCount) = -1;
                            ASArraytemp(segCount) = -1;
                        end
                        if whichCode == "XYGrid"
                            % M, RP, RV, TIR, AS
                            data = [-1,-1,-1,1,-1];
                            return % 直接離開 tracing
                        end
                        break % leave AUF Loop
                    end
                    %% RP/RR Width derivation
                    RRPointFromLeftPupilEdgeArrayAUF{widthCount} = outputA(:,1);
                    RRPointFromRightPupilEdgeArrayAUF{widthCount} = outputA(:,2);
                    RPPointFromLeftPupilEdgeArrayAUF{widthCount} = outputD(:,1);
                    RPPointFromRightPupilEdgeArrayAUF{widthCount} = outputD(:,2);
                    %% AS 
                    if whichCode == "M00Curve" || whichCode == "XYGrid"
                        AS_Angle = max(AS_two);
                    end
                end
                if break_flag == 1;continue;end % continue next seg 20230829

                %% Locate RP %%
                % AUF: Find the RP with max Width and corresponding RR.
                [atemp,btemp] = ndgrid(1:length(lensAperturePool));
                repeatArray = [atemp(:),btemp(:)];
                widthPool = zeros(1,size(repeatArray,1));
                for iii = 1:size(repeatArray,1)
                    RPFromLPEtemp = RPPointFromLeftPupilEdgeArrayAUF{repeatArray(iii,1)};
                    RPFromRPEtemp = RPPointFromRightPupilEdgeArrayAUF{repeatArray(iii,2)};
                    widthPool(iii) = norm(RPFromLPEtemp-RPFromRPEtemp);
                end
                [RP_width_final,ind1] = max(widthPool);
                RPFromLPE = RPPointFromLeftPupilEdgeArrayAUF{repeatArray(ind1,1)};
                RPFromRPE = RPPointFromRightPupilEdgeArrayAUF{repeatArray(ind1,2)};
                RRFromLPE = RRPointFromLeftPupilEdgeArrayAUF{repeatArray(ind1,1)}; % From Left Pupil Edge
                RRFromRPE = RRPointFromRightPupilEdgeArrayAUF{repeatArray(ind1,2)}; % From Right Pupil Edge
                indLeftPupilEdge = repeatArray(ind1,1);
                lensPositionFromLeftPupilEdge = (-1)*lensAperturePool(indLeftPupilEdge)/2;
                indRightPupilEdge = repeatArray(ind1,2);
                lensPositionFromRightPupilEdge = (1)*lensAperturePool(indRightPupilEdge)/2;
                lens_width_final = abs(lensPositionFromLeftPupilEdge-lensPositionFromRightPupilEdge);
                RP_radius = 0.5 * RP_width_final;
                RP_center = 0.5 * (RPFromLPE + RPFromRPE);
                % determine real or virtual 
                [~,indLefter] = min([lensPositionFromLeftPupilEdge,lensPositionFromRightPupilEdge]);
                if indLefter == 1 % 左PupilEdge打到的Lens位置較左
                    RPFromLLA = RPFromLPE; % From Left Lens Aperture
                    RPFromRLA = RPFromRPE; % From Right Lens Aperture
                elseif indLefter == 2 % 右 PupilEdge 打到的 Lens 位置較左
                    RPFromLLA = RPFromRPE; % From Left Lens Aperture
                    RPFromRLA = RPFromLPE; % From Right Lens Aperture
                end  
                RPFromLLA2D = RPFromLLA(1:2);
                RPFromRLA2D = RPFromRLA(1:2);
                if RPFromLLA2D(2) < RPFromRLA2D(2)
                    RPAtLeftPanel2D = RPFromLLA2D;
                    RPAtRightPanel2D = RPFromRLA2D;
                    if whichCode == "Design" || whichCode == "XYGrid"
                        R1V0 = 0;
                    end
                else
                    RPAtLeftPanel2D = RPFromRLA2D;
                    RPAtRightPanel2D = RPFromLLA2D;
                    if whichCode == "Design" || whichCode == "XYGrid"
                        R1V0 = 1;
                    end
                end
                
                % M00_Curve Only %
                % real or virtual % 水平座標判斷虛實 (有誤差) @20230803_3
                % 找同一個 pupil edge 出發的組合
                if whichCode == "M00Curve"
                    if length(lensAperturePool) > 1
                        combNum = nchoosek(length(lensAperturePool),2); % 所有組合
                        combList = nchoosek(1:length(lensAperturePool),2); % 所有組合
                        RV_comb_LPE = nan(1,length(lensAperturePool));
                        RV_comb_RPE = nan(1,length(lensAperturePool));
                        for combb = 1:combNum
                            whichComb = combList(combb,:);
                            lensAperture_RV_1 = lensAperturePool(whichComb(1));
                            lensAperture_RV_2 = lensAperturePool(whichComb(2));
                            RPFormLPE_RV_1 = RPPointFromLeftPupilEdgeArrayAUF{whichComb(1)};
                            RPFormLPE_RV_2 = RPPointFromLeftPupilEdgeArrayAUF{whichComb(2)};
                            RPFormRPE_RV_1 = RPPointFromRightPupilEdgeArrayAUF{whichComb(1)};
                            RPFormRPE_RV_2 = RPPointFromRightPupilEdgeArrayAUF{whichComb(2)};
                            if lensAperture_RV_1 < lensAperture_RV_2 
                                if RPFormLPE_RV_1(2) < RPFormLPE_RV_2(2) % 虛像 沒有交叉
                                    RV_comb_LPE(combb) = 0;
                                elseif RPFormLPE_RV_1(2) > RPFormLPE_RV_2(2) % 實像 有交叉
                                    RV_comb_LPE(combb) = 1;
                                end
                                if RPFormRPE_RV_1(2) < RPFormRPE_RV_2(2) % 虛像 沒有交叉
                                    RV_comb_RPE(combb) = 0;
                                elseif RPFormRPE_RV_1(2) > RPFormRPE_RV_2(2) % 實像 有交叉
                                    RV_comb_RPE(combb) = 1;
                                end
                            end
                        end
                        if (any(RV_comb_LPE==1) && any(RV_comb_LPE==0)) ||...
                                (any(RV_comb_RPE==1) && any(RV_comb_RPE==0)) % 含有任何虛實並存 --> RVAlone = 0
                            RValone = 0;
                        else
                            RValone = 1; 
                        end
                    else
                        RValone = nan;
                    end
                end

                %% Locate RR %%
                % RR_beforeShift: real position
                % RR_afterShift: RR with RRShift (for image mapping)
                point_systemTop_final = [RRFromLPE,RRFromRPE]; % From AUF
                point_pupiledge_final = outputO; % From RayTracing
                directional = point_systemTop_final - point_pupiledge_final; % 有Prism
                %% M_RRR Curve Based on Each Lens and Each Eye
                % II Code Only
                if segM00_now == 0
                    if whichCode == "II"
                        if debugMode == 0
                            M00Curve_Matrix = segM00.M00Parameter_Matrix;
                            RRX_linear_array = ChooseMRRXandRV1003(whichEye,M00Curve_Matrix,lensCount,RRRConstant); 
                            if ~all(isnan(RRX_linear_array)) % 全部 nan 才不會進來此處 20230829
                                RRX_linear = RRX_linear_array(segCount,:);
                            else
                                RRX_linear = nan;
                            end
                        elseif debugMode == 1
                            RRX_linear = nan;
                        end
                    end
                end
                
                % RDP modifer (for system tilt) "II Code only"
                if whichCode == "II"
                    if RDPModifierMode == 1 && segM00_now == 0
                        RDPNew = planeLineIntersection(systemTiltAngle,systemThickness,panelSizeVer,point_pupiledge_final,directional);
                        RDP = RDP_original + RDPNew;
                    end
                end
        
                % Center RR %  Intersection_forRR_neg = Intersection_forRR when RDP > 0
                Intersection_forRR_neg = point_pupiledge_final+((RDP+systemThickness-point_pupiledge_final(3,:))./directional(3,:)).*directional;
                Intersection_forRR = point_pupiledge_final+((abs(RDP)+systemThickness-point_pupiledge_final(3,:))./directional(3,:)).*directional;
                RR_center = 0.5*(Intersection_forRR_neg(1:2,1)+Intersection_forRR_neg(1:2,2)); % down to (x,y)               
        
                % Radius RR
                Radius_forRR = 0.5*norm(Intersection_forRR(:,1)-Intersection_forRR(:,2));

                % RRR (II Code Only)
                if whichCode == "II"
                    if RRRMode == 1
                        M_RRX = (RRX_linear(1) * RDP + RRX_linear(2));
                        if isnan(M_RRX)
                            warning("M_RRX == nan 請洽詢 GY")
                            % RRX_linear = [nan,nan]
                            % PS0 在此處 TIR，但 coding PS 尚未 TIR
                        end
                        M_RRX = M_RRX * MOffset; % 20221208
                        Radius_forRR = RP_radius * M_RRX;
                    end 
                end

                % RR位置
                % RR Egde點旋轉 (垂直Lenticular排列方向)
                vectorRRleft_beforeRot_lens = [0;-Radius_forRR;0];
                temp_rot = rotLRA * vectorRRleft_beforeRot_lens;
                RRAtLeftPanel2D = RR_center + temp_rot(1:2);
                vectorRRright_beforeRot_lens = [0;Radius_forRR;0];
                temp_rot = rotLRA * vectorRRright_beforeRot_lens;
                RRAtRightPanel2D = RR_center + temp_rot(1:2); 
                
                %% 紀錄 %%
                %% 1. 記錄與中心最遠的"垂直距離"，得 padsize (同時考量 RR(AfterShift) + RP)
                % for mapping (必要輸出)
                if ismember(whichCode,["II", "VZA"])
                    if whichCode == "VZA"
                        RRShiftVer_wld = 0; RRShiftHor_wld = 0;
                    end
                    checkVerTemp1 = abs(RPAtLeftPanel2D(1)) - panelSizeVer*0.5;
                    checkVerTemp2 = abs(RPAtRightPanel2D(1)) - panelSizeVer*0.5;
                    checkVerTemp3 = abs(RRAtLeftPanel2D(1) - RRShiftVer_wld) - panelSizeVer*0.5;
                    checkVerTemp4 = abs(RRAtRightPanel2D(1) - RRShiftVer_wld) - panelSizeVer*0.5;
                    farCheckVer = max([checkVerTemp1,checkVerTemp2,checkVerTemp3,checkVerTemp4]);
                    if farCheckVer > farrestDistanceVer
                        farrestDistanceVer = farCheckVer;
                    end
                    checkHorTemp1 = abs(RPAtLeftPanel2D(2)) - panelSizeHor*0.5;
                    checkHorTemp2 = abs(RPAtRightPanel2D(2)) - panelSizeHor*0.5;
                    checkHorTemp3 = abs(RRAtLeftPanel2D(2) - RRShiftHor_wld) - panelSizeHor*0.5;
                    checkHorTemp4 = abs(RRAtRightPanel2D(2) - RRShiftHor_wld) - panelSizeHor*0.5;
                    farCheckHor = max([checkHorTemp1,checkHorTemp2,checkHorTemp3,checkHorTemp4]);
                    if farCheckHor > farrestDistanceHor
                        farrestDistanceHor = farCheckHor;
                    end
                end
        
                %% 2. 記錄 RP RR (三眼) (mm) 20230412
                switch whichEye
                    case -1
                        RPpointSet_LE_wld(2*segCount-1,:,lensCount) = (RPAtLeftPanel2D)';
                        RPpointSet_LE_wld(2*segCount,:,lensCount) = (RPAtRightPanel2D)';
                        RRpointSet_LE_wld(2*segCount-1,:,lensCount) = (RRAtLeftPanel2D)';
                        RRpointSet_LE_wld(2*segCount,:,lensCount) = (RRAtRightPanel2D)';
                    case 0
                        RPpointSet_ME_wld(2*segCount-1,:,lensCount) = (RPAtLeftPanel2D)';
                        RPpointSet_ME_wld(2*segCount,:,lensCount) = (RPAtRightPanel2D)';
                        RRpointSet_ME_wld(2*segCount-1,:,lensCount) = (RRAtLeftPanel2D)';
                        RRpointSet_ME_wld(2*segCount,:,lensCount) = (RRAtRightPanel2D)';
                    case 1
                        RPpointSet_RE_wld(2*segCount-1,:,lensCount) = (RPAtLeftPanel2D)';
                        RPpointSet_RE_wld(2*segCount,:,lensCount) = (RPAtRightPanel2D)';
                        RRpointSet_RE_wld(2*segCount-1,:,lensCount) = (RRAtLeftPanel2D)';
                        RRpointSet_RE_wld(2*segCount,:,lensCount) = (RRAtRightPanel2D)';
                end
                %% 3. 記錄放大率 (mainly for getSegM00)
                M00temp = abs((Radius_forRR)/(RP_radius));
                RPCenterArray(:,segCount) = RP_center;
                M00Array(segCount) = M00temp;
                %% 4. 紀錄 AS RV (For M00_Curve)
                if whichCode == "M00Curve"
                    % target RP within Panel only (20230314)
                    if RP_center(1)<-panelSizeVer*0.5 || RP_center(1)>panelSizeVer*0.5||...
                            RP_center(2)<-panelSizeHor*0.5 || RP_center(2)>panelSizeVer*0.5
                        continue
                    end
                    M00Arraytemp(segCount) = M00temp;
                    ASArraytemp(segCount) = AS_Angle; 
                    RVArraytemp(segCount) = RValone;
                end
            end

            %% M00 linear parameter (segM00 only)
            if segM00_now == 1 || segM00_now == 2
                finalPositionNum = size(finalPosition,2);
                RDPMFitArray = zeros(finalPositionNum,2);
                for whichPosition = 1:finalPositionNum % 分多段
                    M = M00Array(whichPosition);    
                    x_data=[0,WDz];y_data=[M,0];
                    RDPMFit = polyfit(x_data,y_data,1);
                    RDPMFitArray(whichPosition,:) = RDPMFit; 
                end
                %% result recorded
                switch whichEye
                    case -1
                        segM00.M00Parameter_Matrix{1,lensCount,1} = RDPMFitArray;
                        segM00.PS0_RPCenter_Matrix{1,lensCount,1} = RPCenterArray;
                    case 0
                        segM00.M00Parameter_Matrix{1,lensCount,2} = RDPMFitArray;
                        segM00.PS0_RPCenter_Matrix{1,lensCount,2} = RPCenterArray;
                    case 1
                        segM00.M00Parameter_Matrix{1,lensCount,3} = RDPMFitArray;
                        segM00.PS0_RPCenter_Matrix{1,lensCount,3} = RPCenterArray;
                end
            end 
            %% M00 Curve Only
            if whichCode == "M00Curve"
                M00MatrixPadded(lensCount,finalPosition,whichEye+2) = M00Arraytemp;
                ASMatrixPadded(lensCount,finalPosition,whichEye+2) = ASArraytemp;
                RVMatrixPadded(lensCount,finalPosition,whichEye+2) = RVArraytemp;
            end
        end
    end

    %% segfit % 20230914
    % for RP
    if ismember(whichCode,["II", "VZA"])
        if segM00_now == 0 && segmentMode == 2 && segFit == 1
            [RPpointSet_LE_wld, RPpointSet_ME_wld, RPpointSet_RE_wld] = RPFitting(RPpointSet_LE_wld,RPpointSet_ME_wld,RPpointSet_RE_wld,...
            eyeMode,polyFit,polyNum,verSizeForSeg,base_segNum,segNum,lensCenter_x_fitting);
        end
    end

    %% Design Record (理論上只會追跡一次)
    if whichCode == "Design"
        M_Design(designCount) = M00temp;
        RV_Design(designCount) = R1V0;
    end

    %% Loop end
    switch whichCode
        case "II"
            switch segM00_now
                case 0
%                     data = ws2struct; data = rmfield(data,"data");
                    % 只輸出 RP RR 座標, padding factor
                    data = {RPpointSet_LE_wld,RRpointSet_LE_wld;
                            RPpointSet_ME_wld,RRpointSet_ME_wld;
                            RPpointSet_RE_wld,RRpointSet_RE_wld;
                            farrestDistanceVer,farrestDistanceHor; % for padding
                            TIRHappen,nan}; 
                case 1 % seg now
                    data = segM00;
                case 2 % seg now + BLP Mode
                    segM00.RP_LE = RPpointSet_LE_wld;
                    segM00.RP_RE = RPpointSet_RE_wld;
                    data = segM00;
            end
        case "VZA"
            switch segM00_now
                case 0
%                     data = ws2struct; data = rmfield(data,"data");
                    data = {RPpointSet_LE_wld,RRpointSet_LE_wld;
                            RPpointSet_ME_wld,RRpointSet_ME_wld;
                            RPpointSet_RE_wld,RRpointSet_RE_wld;
                            farrestDistanceVer,farrestDistanceHor;  % for padding
                            TIRHappen,nan}; 
                case 1
                    data = segM00;
            end
        case "M00Curve"
            switch segM00_now
                case 0
%                     data = ws2struct; data = rmfield(data,"data");
                    data = {M00MatrixPadded;
                            ASMatrixPadded;
                            RVMatrixPadded};
                case 1
                    data = segM00;
            end
        case "FindGRL"
            data = M00temp;
        case "Design"
            data = {M_Design,RV_Design};
        case "XYGrid"
            if targetWithinPanel == 1
                check = RP_center(1) > -0.5*panelSizeVer && RP_center(1) < 0.5*panelSizeVer && ...
                    RP_center(2) > -0.5*panelSizeHor && RP_center(2) < 0.5*panelSizeHor;
            else
                check = 1;
            end
            if check == 1
                data = [M00temp,RP_radius*2,R1V0,0,AS_Angle];
            elseif check == 0
                data = [nan,nan,nan,nan,nan];
            end
    end
    % --- end of process ---
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end