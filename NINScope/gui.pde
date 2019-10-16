/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(true);
  G4P.setGlobalColorScheme(GCScheme.SCHEME_8);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  Btn_ConnectScope1 = new GButton(this, 10, 380, 80, 30);
  Btn_ConnectScope1.setText("Connect");
  Btn_Record = new GButton(this, 100, 380, 80, 30);
  Btn_Record.setText("Record");
  label1 = new GLabel(this, 10, 700, 70, 20);
  label1.setText("Rate:");
  label1.setTextBold();
  label1.setOpaque(false);
  SerialList = new GDropList(this, 100, 350, 290, 140, 6);
  SerialList.setItems(loadStrings("list_368568"), 0);
  Exposure = new GLabel(this, 10, 520, 110, 20);
  Exposure.setText("Exposure");
  Exposure.setTextBold();
  Exposure.setOpaque(false);
  Sli_ExpoCam1 = new GSlider(this, 10, 540, 380, 30, 10.0);
  Sli_ExpoCam1.setLimits(27532, 0, 27532);
  Sli_ExpoCam1.setShowTicks(true);
  Sli_ExpoCam1.setNumberFormat(G4P.INTEGER, 0);
  Sli_ExpoCam1.setOpaque(false);
  Btn_GsensorOn = new GButton(this, 410, 690, 80, 30);
  Btn_GsensorOn.setText("On");
  Sli_ExciCam1 = new GSlider(this, 10, 480, 380, 30, 10.0);
  Sli_ExciCam1.setLimits(0, 0, 63);
  Sli_ExciCam1.setNumberFormat(G4P.INTEGER, 0);
  Sli_ExciCam1.setOpaque(false);
  Excitation = new GLabel(this, 10, 460, 110, 20);
  Excitation.setText("Excitation");
  Excitation.setTextBold();
  Excitation.setOpaque(false);
  Scope = new GLabel(this, 10, 50, 160, 20);
  Scope.setTextAlign(GAlign.LEFT, GAlign.TOP);
  Scope.setText("NINScope 1");
  Scope.setTextBold();
  Scope.setOpaque(false);
  Gain = new GLabel(this, 10, 580, 80, 20);
  Gain.setText("Gain");
  Gain.setTextBold();
  Gain.setOpaque(false);
  Sli_GainCam1 = new GSlider(this, 10, 600, 380, 30, 10.0);
  Sli_GainCam1.setLimits(384, 128, 4096);
  Sli_GainCam1.setNumberFormat(G4P.INTEGER, 0);
  Sli_GainCam1.setOpaque(false);
  BehavList1 = new GDropList(this, 410, 320, 320, 220, 10);
  BehavList1.setItems(loadStrings("list_855707"), 0);
  LbLBehaviour = new GLabel(this, 410, 50, 150, 20);
  LbLBehaviour.setText("Behaviour Camera");
  LbLBehaviour.setTextBold();
  LbLBehaviour.setOpaque(false);
  LbLSerialPort = new GLabel(this, 10, 350, 80, 20);
  LbLSerialPort.setText("SerialPort");
  LbLSerialPort.setTextBold();
  LbLSerialPort.setOpaque(false);
  Btn_ConnectBehav = new GButton(this, 410, 350, 80, 30);
  Btn_ConnectBehav.setText("Connect");
  Btn_Zoom_Cam1 = new GButton(this, 280, 380, 50, 30);
  Btn_Zoom_Cam1.setIcon("Zoom.png", 1, GAlign.NORTH, GAlign.CENTER, GAlign.MIDDLE);
  NoteArea = new GTextArea(this, 10, 750, 300, 100, G4P.SCROLLBARS_NONE);
  NoteArea.setOpaque(false);
  LbLNotes = new GLabel(this, 10, 730, 80, 20);
  LbLNotes.setText("Notes");
  LbLNotes.setTextBold();
  LbLNotes.setOpaque(false);
  Btn_Settings = new GButton(this, 10, 10, 80, 30);
  Btn_Settings.setText("Settings");
  Lbl_BlackOffset = new GLabel(this, 10, 640, 160, 20);
  Lbl_BlackOffset.setText("Desired black level");
  Lbl_BlackOffset.setTextBold();
  Lbl_BlackOffset.setOpaque(false);
  Sli_BlackOffsetCam1 = new GSlider(this, 10, 660, 380, 30, 10.0);
  Sli_BlackOffsetCam1.setLimits(0, 0, 255);
  Sli_BlackOffsetCam1.setNumberFormat(G4P.INTEGER, 0);
  Sli_BlackOffsetCam1.setOpaque(false);
  LbL_Gsens = new GLabel(this, 490, 390, 150, 20);
  LbL_Gsens.setTextAlign(GAlign.LEFT, GAlign.TOP);
  LbL_Gsens.setText("IMU Sensor");
  LbL_Gsens.setTextBold();
  LbL_Gsens.setOpaque(false);
  LbL_ExpoStat = new GLabel(this, 240, 520, 150, 20);
  LbL_ExpoStat.setTextAlign(GAlign.RIGHT, GAlign.CENTER);
  LbL_ExpoStat.setText("33,04mS - 27532");
  LbL_ExpoStat.setTextItalic();
  LbL_ExpoStat.setOpaque(false);
  LbL_GainStat = new GLabel(this, 320, 580, 70, 20);
  LbL_GainStat.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbL_GainStat.setText("3.0");
  LbL_GainStat.setTextItalic();
  LbL_GainStat.setOpaque(false);
  LbL_BlackOffsetStat = new GLabel(this, 310, 640, 80, 20);
  LbL_BlackOffsetStat.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbL_BlackOffsetStat.setText("0");
  LbL_BlackOffsetStat.setTextItalic();
  LbL_BlackOffsetStat.setOpaque(false);
  LbL_ExciStat = new GLabel(this, 180, 460, 210, 20);
  LbL_ExciStat.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbL_ExciStat.setText("0mA - 0");
  LbL_ExciStat.setTextItalic();
  LbL_ExciStat.setOpaque(false);
  Btn_SnapShotCam1 = new GButton(this, 190, 380, 80, 30);
  Btn_SnapShotCam1.setText("SnapShot");
  Btn_Stimulate = new GButton(this, 10, 420, 80, 30);
  Btn_Stimulate.setText("Stimulate");
  Btn_AppendNotes = new GButton(this, 320, 750, 70, 30);
  Btn_AppendNotes.setText("Append");
  ConsoleArea = new GTextArea(this, 410, 750, 230, 100, G4P.SCROLLBARS_VERTICAL_ONLY);
  ConsoleArea.setOpaque(false);
  LbL_Console = new GLabel(this, 410, 730, 80, 20);
  LbL_Console.setText("Console");
  LbL_Console.setTextBold();
  LbL_Console.setOpaque(false);
  Btn_DualHead = new GButton(this, 190, 10, 80, 30);
  Btn_DualHead.setText("DualHead");
  LbL_MiniScope2 = new GLabel(this, 750, 50, 120, 20);
  LbL_MiniScope2.setText("NINScope 2");
  LbL_MiniScope2.setTextBold();
  LbL_MiniScope2.setOpaque(false);
  Btn_ConnectScope2 = new GButton(this, 750, 380, 80, 30);
  Btn_ConnectScope2.setText("Connect");
  SerialPort2List = new GDropList(this, 850, 350, 280, 140, 6);
  SerialPort2List.setItems(loadStrings("list_527591"), 0);
  LbL_SerialPort2 = new GLabel(this, 750, 350, 90, 20);
  LbL_SerialPort2.setText("Serial Port :");
  LbL_SerialPort2.setTextBold();
  LbL_SerialPort2.setOpaque(false);
  Sli_ExciCam2 = new GSlider(this, 750, 440, 380, 30, 10.0);
  Sli_ExciCam2.setLimits(0, 0, 63);
  Sli_ExciCam2.setNumberFormat(G4P.INTEGER, 0);
  Sli_ExciCam2.setOpaque(false);
  LbL_Excitation2 = new GLabel(this, 750, 420, 80, 20);
  LbL_Excitation2.setText("Excitation");
  LbL_Excitation2.setTextBold();
  LbL_Excitation2.setOpaque(false);
  Sli_ExpoCam2 = new GSlider(this, 750, 500, 380, 30, 10.0);
  Sli_ExpoCam2.setLimits(27532, 0, 27532);
  Sli_ExpoCam2.setNumberFormat(G4P.INTEGER, 0);
  Sli_ExpoCam2.setOpaque(false);
  LbL_Exposure2 = new GLabel(this, 750, 480, 80, 20);
  LbL_Exposure2.setText("Exposure");
  LbL_Exposure2.setTextBold();
  LbL_Exposure2.setOpaque(false);
  Sli_GainCam2 = new GSlider(this, 750, 560, 380, 30, 10.0);
  Sli_GainCam2.setLimits(384, 128, 4096);
  Sli_GainCam2.setNumberFormat(G4P.INTEGER, 0);
  Sli_GainCam2.setOpaque(false);
  LbL_Gain = new GLabel(this, 750, 540, 80, 20);
  LbL_Gain.setText("Gain");
  LbL_Gain.setTextBold();
  LbL_Gain.setOpaque(false);
  LbLFrameRate2 = new GLabel(this, 750, 700, 80, 20);
  LbLFrameRate2.setText("FrameRate:");
  LbLFrameRate2.setOpaque(false);
  LbL_ExciStat2 = new GLabel(this, 970, 420, 160, 20);
  LbL_ExciStat2.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbL_ExciStat2.setText("0mA - 0");
  LbL_ExciStat2.setTextItalic();
  LbL_ExciStat2.setOpaque(false);
  LbL_ExpoStat2 = new GLabel(this, 970, 480, 160, 20);
  LbL_ExpoStat2.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbL_ExpoStat2.setText("30,04mS - 27532");
  LbL_ExpoStat2.setTextItalic();
  LbL_ExpoStat2.setOpaque(false);
  LbL_GainStat2 = new GLabel(this, 1060, 540, 70, 20);
  LbL_GainStat2.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbL_GainStat2.setText("3.0");
  LbL_GainStat2.setTextItalic();
  LbL_GainStat2.setOpaque(false);
  Btn_Scan = new GButton(this, 100, 10, 80, 30);
  Btn_Scan.setText("HW Scan");
  Btn_ConsoleClr = new GButton(this, 650, 750, 80, 30);
  Btn_ConsoleClr.setText("Clear");
  LblDropScp1 = new GLabel(this, 180, 700, 60, 20);
  LblDropScp1.setText("Drop:");
  LblDropScp1.setTextBold();
  LblDropScp1.setOpaque(false);
  LblRecScp1 = new GLabel(this, 250, 700, 110, 20);
  LblRecScp1.setText("Rec:");
  LblRecScp1.setTextBold();
  LblRecScp1.setOpaque(false);
  LblDropScp2 = new GLabel(this, 840, 700, 80, 20);
  LblDropScp2.setText("Drop: 0");
  LblDropScp2.setOpaque(false);
  LbL_FrameBehave = new GLabel(this, 410, 390, 70, 20);
  LbL_FrameBehave.setText("Rate : 0 ");
  LbL_FrameBehave.setOpaque(false);
  Lbl_RngBuf1Status = new GLabel(this, 90, 700, 80, 20);
  Lbl_RngBuf1Status.setText("Buffer: 0");
  Lbl_RngBuf1Status.setOpaque(false);
  Btn_Zoom_behave = new GButton(this, 590, 350, 50, 30);
  Btn_Zoom_behave.setIcon("Zoom.png", 1, GAlign.NORTH, GAlign.CENTER, GAlign.MIDDLE);
  Btn_Zoom_Cam2 = new GButton(this, 930, 380, 50, 30);
  Btn_Zoom_Cam2.setIcon("Zoom.png", 1, GAlign.NORTH, GAlign.CENTER, GAlign.MIDDLE);
  Btn_Zoom_Cam2.setTextAlign(GAlign.CENTER, GAlign.TOP);
  Drpl_BehaveFormat = new GDropList(this, 650, 350, 80, 80, 3);
  Drpl_BehaveFormat.setItems(loadStrings("list_785816"), 0);
  Btn_GsensorOff = new GButton(this, 500, 690, 80, 30);
  Btn_GsensorOff.setText("Off");
  Btn_SnapShotCam2 = new GButton(this, 840, 380, 80, 30);
  Btn_SnapShotCam2.setText("SnapShot");
  Btn_SnapShotBehav = new GButton(this, 500, 350, 80, 30);
  Btn_SnapShotBehav.setText("Snapshot");
  LbL_Name = new GLabel(this, 290, 10, 60, 20);
  LbL_Name.setText("Name:");
  LbL_Name.setOpaque(false);
  tf_Name = new GTextField(this, 360, 10, 92, 20, G4P.SCROLLBARS_NONE);
  tf_Name.setOpaque(true);
  Btn_SaveSettings = new GButton(this, 480, 10, 80, 30);
  Btn_SaveSettings.setText("Save");
  Btn_LoadSettings = new GButton(this, 570, 10, 80, 30);
  Btn_LoadSettings.setText("Load");
  Sli_BlackOffsetCam2 = new GSlider(this, 750, 620, 380, 30, 10.0);
  Sli_BlackOffsetCam2.setLimits(0, 0, 255);
  Sli_BlackOffsetCam2.setNumberFormat(G4P.INTEGER, 0);
  Sli_BlackOffsetCam2.setOpaque(false);
  Lbl_BlackOffset2 = new GLabel(this, 750, 600, 160, 20);
  Lbl_BlackOffset2.setText("Desired black level");
  Lbl_BlackOffset2.setTextBold();
  Lbl_BlackOffset2.setOpaque(false);
  LbL_BlackOffsetStat2 = new GLabel(this, 1050, 600, 80, 20);
  LbL_BlackOffsetStat2.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbL_BlackOffsetStat2.setText("0");
  LbL_BlackOffsetStat2.setTextItalic();
  LbL_BlackOffsetStat2.setOpaque(false);
  Btn_Detect1 = new GButton(this, 100, 420, 80, 30);
  Btn_Detect1.setText("Detect");
  Btn_Detect2 = new GButton(this, 990, 380, 80, 30);
  Btn_Detect2.setText("Detect");
  LbL_NINscopeSelcted = new GLabel(this, 10, 320, 380, 20);
  LbL_NINscopeSelcted.setText("---");
  LbL_NINscopeSelcted.setOpaque(false);
  LbL_NINscope2Selected = new GLabel(this, 750, 320, 380, 20);
  LbL_NINscope2Selected.setText("---");
  LbL_NINscope2Selected.setOpaque(false);
  Grp_Gain = new GToggleGroup();
  Opt_Gain1 = new GOption(this, 100, 580, 40, 20);
  Opt_Gain1.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Opt_Gain1.setText("1x");
  Opt_Gain1.setOpaque(false);
  Opt_Gain2 = new GOption(this, 160, 580, 40, 20);
  Opt_Gain2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Opt_Gain2.setText("2x");
  Opt_Gain2.setOpaque(false);
  Grp_Gain.addControl(Opt_Gain1);
  Opt_Gain1.setSelected(true);
  Grp_Gain.addControl(Opt_Gain2);
  Btn_FineGainCam1_Down = new GButton(this, 210, 580, 40, 20);
  Btn_FineGainCam1_Down.setText("<");
  Btn_FineGainCam1_Up = new GButton(this, 260, 580, 40, 20);
  Btn_FineGainCam1_Up.setText(">");
  Grp_Gain2 = new GToggleGroup();
  Opt_Gain1_Cam2 = new GOption(this, 840, 540, 40, 20);
  Opt_Gain1_Cam2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Opt_Gain1_Cam2.setText("1x");
  Opt_Gain1_Cam2.setOpaque(false);
  Opt_Gain2_Cam2 = new GOption(this, 900, 540, 40, 20);
  Opt_Gain2_Cam2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Opt_Gain2_Cam2.setText("2x");
  Opt_Gain2_Cam2.setOpaque(false);
  Grp_Gain2.addControl(Opt_Gain1_Cam2);
  Opt_Gain1_Cam2.setSelected(true);
  Grp_Gain2.addControl(Opt_Gain2_Cam2);
  Btn_FineGainCam2_Down = new GButton(this, 950, 540, 40, 20);
  Btn_FineGainCam2_Down.setText("<");
  Btn_FineGainCam2_Up = new GButton(this, 1000, 540, 40, 20);
  Btn_FineGainCam2_Up.setText(">");
  WindowZoomCam1 = GWindow.getWindow(this, "Zoom Cam 1", 0, 0, 752, 630, JAVA2D);
  WindowZoomCam1.noLoop();
  Sld_Cam1 = new GSlider2D(WindowZoomCam1, 340, 520, 36, 80);
  Sld_Cam1.setLimitsX(7.0, 0.0, 14.0);
  Sld_Cam1.setLimitsY(16.0, 0.0, 31.0);
  Sld_Cam1.setNumberFormat(G4P.DECIMAL, 1);
  Sld_Cam1.setOpaque(false);
  Chk_HistoCam1 = new GCheckbox(WindowZoomCam1, 10, 490, 290, 20);
  Chk_HistoCam1.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Chk_HistoCam1.setText("Histogram active");
  Chk_HistoCam1.setOpaque(false);
  Btn_CentreSLDCam1 = new GButton(WindowZoomCam1, 390, 570, 70, 30);
  Btn_CentreSLDCam1.setText("Centre");
  Lbl_ViewCam1 = new GLabel(WindowZoomCam1, 320, 490, 80, 20);
  Lbl_ViewCam1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Lbl_ViewCam1.setText("View");
  Lbl_ViewCam1.setOpaque(false);
  Chk_ROIAvgCam1 = new GCheckbox(WindowZoomCam1, 480, 490, 240, 20);
  Chk_ROIAvgCam1.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Chk_ROIAvgCam1.setText("ROI Average Graph");
  Chk_ROIAvgCam1.setOpaque(false);
  SettingsWnd = GWindow.getWindow(this, "Settings", 0, 0, 455, 600, JAVA2D);
  SettingsWnd.noLoop();
  Btn_OKSettings = new GButton(SettingsWnd, 360, 460, 80, 30);
  Btn_OKSettings.setText("OK");
  LbL_PulsOn = new GLabel(SettingsWnd, 20, 40, 100, 20);
  LbL_PulsOn.setText("Pulse On(mS) :");
  LbL_PulsOn.setOpaque(false);
  LbL_PulsOff = new GLabel(SettingsWnd, 20, 70, 100, 20);
  LbL_PulsOff.setText("Pulse Off(mS) :");
  LbL_PulsOff.setOpaque(false);
  LbL_BurstCnt = new GLabel(SettingsWnd, 20, 100, 100, 20);
  LbL_BurstCnt.setText("Burst Count :");
  LbL_BurstCnt.setOpaque(false);
  tf_PulseOff = new GTextField(SettingsWnd, 130, 70, 90, 20, G4P.SCROLLBARS_NONE);
  tf_PulseOff.setText("10");
  tf_PulseOff.setOpaque(true);
  tf_BurstCnt = new GTextField(SettingsWnd, 130, 100, 90, 20, G4P.SCROLLBARS_NONE);
  tf_BurstCnt.setText("5");
  tf_BurstCnt.setOpaque(true);
  LbL_StartDelay = new GLabel(SettingsWnd, 230, 40, 100, 20);
  LbL_StartDelay.setText("Start delay(mS) :");
  LbL_StartDelay.setOpaque(false);
  LbL_Pause = new GLabel(SettingsWnd, 230, 70, 100, 20);
  LbL_Pause.setText("Pause(mS) : ");
  LbL_Pause.setOpaque(false);
  LbL_LoopCnt = new GLabel(SettingsWnd, 230, 100, 100, 20);
  LbL_LoopCnt.setText("Loop Count :");
  LbL_LoopCnt.setOpaque(false);
  tf_PulseOn = new GTextField(SettingsWnd, 130, 40, 90, 20, G4P.SCROLLBARS_NONE);
  tf_PulseOn.setText("5");
  tf_PulseOn.setOpaque(true);
  tf_StrDelay = new GTextField(SettingsWnd, 340, 40, 90, 20, G4P.SCROLLBARS_NONE);
  tf_StrDelay.setText("500");
  tf_StrDelay.setOpaque(true);
  tf_Pause = new GTextField(SettingsWnd, 340, 70, 90, 20, G4P.SCROLLBARS_NONE);
  tf_Pause.setText("500");
  tf_Pause.setOpaque(true);
  tf_LoopCnt = new GTextField(SettingsWnd, 340, 100, 90, 20, G4P.SCROLLBARS_NONE);
  tf_LoopCnt.setText("0");
  tf_LoopCnt.setOpaque(true);
  Sli_OptoGen = new GSlider(SettingsWnd, 20, 160, 270, 30, 10.0);
  Sli_OptoGen.setLimits(1, 1, 10);
  Sli_OptoGen.setNumberFormat(G4P.INTEGER, 0);
  Sli_OptoGen.setOpaque(false);
  LbL_LEDpower = new GLabel(SettingsWnd, 20, 140, 110, 20);
  LbL_LEDpower.setText("LED Power (mA)");
  LbL_LEDpower.setOpaque(false);
  LbLOptoBrightState = new GLabel(SettingsWnd, 210, 140, 80, 20);
  LbLOptoBrightState.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  LbLOptoBrightState.setText("11mA");
  LbLOptoBrightState.setOpaque(false);
  ChkBox_TriggerInput = new GCheckbox(SettingsWnd, 20, 250, 189, 20);
  ChkBox_TriggerInput.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  ChkBox_TriggerInput.setText("Trigger Input ( active high)");
  ChkBox_TriggerInput.setOpaque(false);
  LbL_OptoGen_Settings = new GLabel(SettingsWnd, 20, 10, 160, 20);
  LbL_OptoGen_Settings.setText("OptoGenetic Settings");
  LbL_OptoGen_Settings.setTextBold();
  LbL_OptoGen_Settings.setOpaque(false);
  LbL_TriggerSettings = new GLabel(SettingsWnd, 20, 220, 140, 20);
  LbL_TriggerSettings.setText("Trigger Settings");
  LbL_TriggerSettings.setTextBold();
  LbL_TriggerSettings.setOpaque(false);
  Chkbox_FramesPT = new GCheckbox(SettingsWnd, 20, 280, 140, 20);
  Chkbox_FramesPT.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Chkbox_FramesPT.setText("Frames per Trigger");
  Chkbox_FramesPT.setOpaque(false);
  LbL_FramesPT = new GLabel(SettingsWnd, 170, 280, 80, 20);
  LbL_FramesPT.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LbL_FramesPT.setText("Frames # : ");
  LbL_FramesPT.setOpaque(false);
  tf_FramesPT = new GTextField(SettingsWnd, 260, 280, 100, 20, G4P.SCROLLBARS_NONE);
  tf_FramesPT.setText("0");
  tf_FramesPT.setOpaque(true);
  LbL_Title_Temperature = new GLabel(SettingsWnd, 20, 330, 150, 20);
  LbL_Title_Temperature.setText("Temperature");
  LbL_Title_Temperature.setTextBold();
  LbL_Title_Temperature.setOpaque(false);
  LbL_Temperature = new GLabel(SettingsWnd, 120, 360, 80, 20);
  LbL_Temperature.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LbL_Temperature.setText("0 °C");
  LbL_Temperature.setOpaque(false);
  Btn_TempRead = new GButton(SettingsWnd, 20, 360, 80, 30);
  Btn_TempRead.setText("Read");
  togGroup1 = new GToggleGroup();
  OG_OptoManual = new GOption(SettingsWnd, 340, 170, 100, 20);
  OG_OptoManual.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  OG_OptoManual.setText("Manual");
  OG_OptoManual.setOpaque(false);
  OG_OptoAuto = new GOption(SettingsWnd, 340, 140, 100, 20);
  OG_OptoAuto.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  OG_OptoAuto.setText("Auto");
  OG_OptoAuto.setOpaque(false);
  togGroup1.addControl(OG_OptoManual);
  OG_OptoManual.setSelected(true);
  togGroup1.addControl(OG_OptoAuto);
  LbL_TitleRecordings = new GLabel(SettingsWnd, 20, 420, 80, 20);
  LbL_TitleRecordings.setText("Recordings");
  LbL_TitleRecordings.setTextBold();
  LbL_TitleRecordings.setOpaque(false);
  Chkox_RecFixedFrames = new GCheckbox(SettingsWnd, 20, 450, 170, 20);
  Chkox_RecFixedFrames.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Chkox_RecFixedFrames.setText("Record fixed frame count");
  Chkox_RecFixedFrames.setOpaque(false);
  tf_RecFrmeCnt = new GTextField(SettingsWnd, 260, 450, 80, 20, G4P.SCROLLBARS_NONE);
  tf_RecFrmeCnt.setText("0");
  tf_RecFrmeCnt.setOpaque(true);
  LbL_RecFrameCnt = new GLabel(SettingsWnd, 220, 450, 30, 20);
  LbL_RecFrameCnt.setText("# : ");
  LbL_RecFrameCnt.setOpaque(false);
  Btn_TempPyRead = new GButton(SettingsWnd, 220, 360, 80, 30);
  Btn_TempPyRead.setText("Read Py");
  LbL_TemperaturePy = new GLabel(SettingsWnd, 320, 360, 80, 20);
  LbL_TemperaturePy.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LbL_TemperaturePy.setText("0 °C");
  LbL_TemperaturePy.setOpaque(false);
  Chk_TempAuto = new GCheckbox(SettingsWnd, 321, 386, 120, 20);
  Chk_TempAuto.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Chk_TempAuto.setText("Auto");
  Chk_TempAuto.setOpaque(false);
  Lbl_Title_Cal = new GLabel(SettingsWnd, 20, 510, 160, 20);
  Lbl_Title_Cal.setText("Auto Black Calibration");
  Lbl_Title_Cal.setTextBold();
  Lbl_Title_Cal.setOpaque(false);
  ChBox_AutoCal = new GCheckbox(SettingsWnd, 20, 540, 120, 20);
  ChBox_AutoCal.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  ChBox_AutoCal.setText("NINScope 1");
  ChBox_AutoCal.setOpaque(false);
  ChBox_AutoCal.setSelected(true);
  ChBox_AutoCal2 = new GCheckbox(SettingsWnd, 170, 540, 120, 20);
  ChBox_AutoCal2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  ChBox_AutoCal2.setText("NINScope 2");
  ChBox_AutoCal2.setOpaque(false);
  ChBox_AutoCal2.setSelected(true);
  windowZoomBehav = GWindow.getWindow(this, "Zoom Behaviour Camera", 0, 0, 640, 480, JAVA2D);
  windowZoomBehav.noLoop();
  WindowZoomCam2 = GWindow.getWindow(this, "Zoom Cam 2", 0, 0, 752, 630, JAVA2D);
  WindowZoomCam2.noLoop();
  Sld_Cam2 = new GSlider2D(WindowZoomCam2, 340, 520, 36, 80);
  Sld_Cam2.setLimitsX(7.0, 0.0, 14.0);
  Sld_Cam2.setLimitsY(16.0, 0.0, 31.0);
  Sld_Cam2.setNumberFormat(G4P.DECIMAL, 1);
  Sld_Cam2.setOpaque(false);
  Chk_HistoCam2 = new GCheckbox(WindowZoomCam2, 10, 490, 270, 20);
  Chk_HistoCam2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Chk_HistoCam2.setText("Histogram active");
  Chk_HistoCam2.setOpaque(false);
  Btn_CentreSLDCam2 = new GButton(WindowZoomCam2, 390, 570, 70, 30);
  Btn_CentreSLDCam2.setText("Centre");
  Lbl_ViewCam2 = new GLabel(WindowZoomCam2, 320, 490, 80, 20);
  Lbl_ViewCam2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  Lbl_ViewCam2.setText("View");
  Lbl_ViewCam2.setOpaque(false);
  Chk_ROIAvgCam2 = new GCheckbox(WindowZoomCam2, 480, 490, 220, 20);
  Chk_ROIAvgCam2.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  Chk_ROIAvgCam2.setText("ROI Average Graph");
  Chk_ROIAvgCam2.setOpaque(false);
  WindowWarning = GWindow.getWindow(this, "Warning", 0, 0, 320, 120, JAVA2D);
  WindowWarning.noLoop();
  Btn_Warning = new GButton(WindowWarning, 120, 70, 80, 30);
  Btn_Warning.setText("OK");
  LbL_warning = new GLabel(WindowWarning, 10, 30, 300, 20);
  LbL_warning.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LbL_warning.setText("---");
  LbL_warning.setTextBold();
  LbL_warning.setOpaque(false);
  WindowZoomCam1.loop();
  SettingsWnd.loop();
  windowZoomBehav.loop();
  WindowZoomCam2.loop();
  WindowWarning.loop();
}

// Variable declarations 
// autogenerated do not edit
GButton Btn_ConnectScope1; 
GButton Btn_Record; 
GLabel label1; 
GDropList SerialList; 
GLabel Exposure; 
GSlider Sli_ExpoCam1; 
GButton Btn_GsensorOn; 
GSlider Sli_ExciCam1; 
GLabel Excitation; 
GLabel Scope; 
GLabel Gain; 
GSlider Sli_GainCam1; 
GDropList BehavList1; 
GLabel LbLBehaviour; 
GLabel LbLSerialPort; 
GButton Btn_ConnectBehav; 
GButton Btn_Zoom_Cam1; 
GTextArea NoteArea; 
GLabel LbLNotes; 
GButton Btn_Settings; 
GLabel Lbl_BlackOffset; 
GSlider Sli_BlackOffsetCam1; 
GLabel LbL_Gsens; 
GLabel LbL_ExpoStat; 
GLabel LbL_GainStat; 
GLabel LbL_BlackOffsetStat; 
GLabel LbL_ExciStat; 
GButton Btn_SnapShotCam1; 
GButton Btn_Stimulate; 
GButton Btn_AppendNotes; 
GTextArea ConsoleArea; 
GLabel LbL_Console; 
GButton Btn_DualHead; 
GLabel LbL_MiniScope2; 
GButton Btn_ConnectScope2; 
GDropList SerialPort2List; 
GLabel LbL_SerialPort2; 
GSlider Sli_ExciCam2; 
GLabel LbL_Excitation2; 
GSlider Sli_ExpoCam2; 
GLabel LbL_Exposure2; 
GSlider Sli_GainCam2; 
GLabel LbL_Gain; 
GLabel LbLFrameRate2; 
GLabel LbL_ExciStat2; 
GLabel LbL_ExpoStat2; 
GLabel LbL_GainStat2; 
GButton Btn_Scan; 
GButton Btn_ConsoleClr; 
GLabel LblDropScp1; 
GLabel LblRecScp1; 
GLabel LblDropScp2; 
GLabel LbL_FrameBehave; 
GLabel Lbl_RngBuf1Status; 
GButton Btn_Zoom_behave; 
GButton Btn_Zoom_Cam2; 
GDropList Drpl_BehaveFormat; 
GButton Btn_GsensorOff; 
GButton Btn_SnapShotCam2; 
GButton Btn_SnapShotBehav; 
GLabel LbL_Name; 
GTextField tf_Name; 
GButton Btn_SaveSettings; 
GButton Btn_LoadSettings; 
GSlider Sli_BlackOffsetCam2; 
GLabel Lbl_BlackOffset2; 
GLabel LbL_BlackOffsetStat2; 
GButton Btn_Detect1; 
GButton Btn_Detect2; 
GLabel LbL_NINscopeSelcted; 
GLabel LbL_NINscope2Selected; 
GToggleGroup Grp_Gain; 
GOption Opt_Gain1; 
GOption Opt_Gain2; 
GButton Btn_FineGainCam1_Down; 
GButton Btn_FineGainCam1_Up; 
GToggleGroup Grp_Gain2; 
GOption Opt_Gain1_Cam2; 
GOption Opt_Gain2_Cam2; 
GButton Btn_FineGainCam2_Down; 
GButton Btn_FineGainCam2_Up; 
GWindow WindowZoomCam1;
GSlider2D Sld_Cam1; 
GCheckbox Chk_HistoCam1; 
GButton Btn_CentreSLDCam1; 
GLabel Lbl_ViewCam1; 
GCheckbox Chk_ROIAvgCam1; 
GWindow SettingsWnd;
GButton Btn_OKSettings; 
GLabel LbL_PulsOn; 
GLabel LbL_PulsOff; 
GLabel LbL_BurstCnt; 
GTextField tf_PulseOff; 
GTextField tf_BurstCnt; 
GLabel LbL_StartDelay; 
GLabel LbL_Pause; 
GLabel LbL_LoopCnt; 
GTextField tf_PulseOn; 
GTextField tf_StrDelay; 
GTextField tf_Pause; 
GTextField tf_LoopCnt; 
GSlider Sli_OptoGen; 
GLabel LbL_LEDpower; 
GLabel LbLOptoBrightState; 
GCheckbox ChkBox_TriggerInput; 
GLabel LbL_OptoGen_Settings; 
GLabel LbL_TriggerSettings; 
GCheckbox Chkbox_FramesPT; 
GLabel LbL_FramesPT; 
GTextField tf_FramesPT; 
GLabel LbL_Title_Temperature; 
GLabel LbL_Temperature; 
GButton Btn_TempRead; 
GToggleGroup togGroup1; 
GOption OG_OptoManual; 
GOption OG_OptoAuto; 
GLabel LbL_TitleRecordings; 
GCheckbox Chkox_RecFixedFrames; 
GTextField tf_RecFrmeCnt; 
GLabel LbL_RecFrameCnt; 
GButton Btn_TempPyRead; 
GLabel LbL_TemperaturePy; 
GCheckbox Chk_TempAuto; 
GLabel Lbl_Title_Cal; 
GCheckbox ChBox_AutoCal; 
GCheckbox ChBox_AutoCal2; 
GWindow windowZoomBehav;
GWindow WindowZoomCam2;
GSlider2D Sld_Cam2; 
GCheckbox Chk_HistoCam2; 
GButton Btn_CentreSLDCam2; 
GLabel Lbl_ViewCam2; 
GCheckbox Chk_ROIAvgCam2; 
GWindow WindowWarning;
GButton Btn_Warning; 
GLabel LbL_warning; 
