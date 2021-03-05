import g4p_controls.*; //<>//
import java.awt.Font;
import java.awt.*;
import processing.serial.*;
import processing.video.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Scanner;
import java.io.IOException;

static final int MAJOR = 1;
static final int MINOR = 03;



static final int CMD_GSENSOR_ON = 2;
static final int CMD_EXPOSURE = 3;
static final int CMD_EXCITATION = 4;
static final int CMD_START_RECORD = 5;
static final int CMD_SETTINGS = 6;
static final int CMD_GAIN = 7;
static final int CMD_FOCUS = 8;
static final int CMD_STIMULATE = 9;
static final int CMD_TEMP_RD = 10;
static final int CMD_STOP_RECORD = 11;
static final int CMD_TRIG_ON = 12;
static final int CMD_TRIG_OFF = 13;
static final int CMD_GSENSOR_OFF = 14;
static final int CMD_ROI = 15;
static final int CMD_AGAIN = 16;
static final int CMD_BLACKOFFSET =   17;
static final int CMD_AUTOCAL_ON  =  18;
static final int CMD_AUTOCAL_OFF =   19;
static final int CMD_PAIR_CAM_ON =   20;
static final int CMD_PAIR_CAM_OFF =   21;
static final int CMD_DETECT_ON = 22;
static final int CMD_DETECT_OFF = 23;
static final int CMD_PYTEMP_RD = 24;

static final int IMGBUFSIZE = 60;

PrintWriter PWriteLogData;
PrintWriter PWriteNotes;
PrintWriter PWriteTimeStFile;
String FilePrefix;
Serial myPort;                        // The serial port
Serial myPort2;    
PGraphics GSensPanel;
Boolean fSerialEnabled = false;
Boolean fSerial2Enabled = false;
Boolean fCamEnabled = false;
Boolean fCam2Enabled = false;
Boolean fBehavCamEnabled = false;
Boolean fTempUpdate = false;
int     Temperature;
Boolean fTempUpdatePy = false;
int     TemperaturePy;
int     ConsoleLineNumb = 0;
Boolean fRecord = false;
Boolean fStartRecord = false;
Boolean fStartRecord2 = false;

int SveBlackLevel = 0;
int SveBlackLevel2 = 0;
int SveBlackOffset  = 512;
int SveBlackOffset2 = 512;

int     RecCntScp1 = 0;
int     DropScp1 = 0;
int     DropScp1Sve = 0;
int     RecCntScp2 = 0;
int     DropScp2 = 0;
int     DropScp2Sve = 0;
int     RecCntBehav = 0;
int     CamRecordCnt = 0;
int     Cam2RecordCnt = 0;
int     SnapCnt = 0;                          // Counter each time a snap shot is taken
int     SnapCnt2 = 0;
int     SnapCnt3 = 0;

int     RecStartTime = 0;
int     FixedRecCnt = 0;

Capture cam;
Capture cam2;
Capture BehavCam;

int FirstTimeUpdateDLCam = 5;

ROIAvg ROI1;
ROIAvg ROI2;

int PairCam = 0;
int PairRetry = 0;
int camIndex = 0;

int PairCam2 = 0;
int PairRetry2 = 0;
int camIndex2 = 0;

int FrameCnt = 0;
int FrameCnt2 = 0;
int FramBehaveCnt = 0;

int SveGsensX = 0;
int SveGsensY = 0;
int SveGsensZ = 0;

int Tiff1read = 0;
int Tiff1write = 0;
int Tiff1diff = 0;
int Tiff1diffSve = 0;

int Tiff2read = 0;
int Tiff2write = 0;
int Tiff2diff = 0;
int Tiff2diffSve = 0;

int Behav3read = 0;
int Behav3write = 0;
int Behav3diff = 0;
int Behav3diffSve = 0;

String VersionCAM1;
String VersionCAM2;

String[] NINscopeList;
String[] NINscope2List;

String[] Tiff1Filename;
String[] Tiff2Filename;
String[] Behav3Filename;

String[] TimeStpC1Buf;
String[] TimeStpC2Buf;
String[] TimeStpC3Buf;
int TimeStpC1read = 0;
int TimeStpC1write = 0;
int TimeStpC2read = 0;
int TimeStpC2write = 0;
int TimeStpC3read = 0;
int TimeStpC3write = 0;

byte[][] TiffData;
byte[][] TiffData2;
PImage BehavImage[];
int BehavFormat = 0;

GTimer timer1;

public void setup() {
  size(1140, 855, JAVA2D);    
  surface.setResizable(true);    //this make it possible the total size is viewable in the GUI builder
  surface.setSize(745, 855);  

  // workaround for buttons being unresponsive
  // https://discourse.processing.org/t/g4p-with-p2d-p3d-processing-bug/5889
  G4P.setMouseOverEnabled(false); // use this until the bug is fixed

  // Custom 
  createGUI();
  customGUI();
  VersionCAM1 = "";
  VersionCAM2 = "";
  surface.setTitle("NINScope v" + MAJOR + "." + MINOR );
  PImage icon = loadImage("NINlogo.png");
  surface.setIcon(icon);

  GSensPanel  = createGraphics(320, 210);
  GSensPanel.beginDraw();
  GSensPanel.background(54);
  GSensPanel.endDraw();

  frameRate(30);

  Tiff1Filename = new String[IMGBUFSIZE];
  Tiff2Filename = new String[IMGBUFSIZE];
  Behav3Filename = new String[IMGBUFSIZE];
  BehavImage    = new PImage[IMGBUFSIZE];

  TimeStpC1Buf =  new String[IMGBUFSIZE];
  TimeStpC2Buf =  new String[IMGBUFSIZE];
  TimeStpC3Buf =  new String[IMGBUFSIZE];

  TiffData  = new byte[IMGBUFSIZE][361216];
  TiffData2 = new byte[IMGBUFSIZE][361216];

  for (int TiffFill = 0; TiffFill < IMGBUFSIZE; TiffFill++)
    TiffData[TiffFill] = loadBytes("data/Gray.dat");//
  for (int TiffFill = 0; TiffFill < IMGBUFSIZE; TiffFill++)
    TiffData2[TiffFill] = loadBytes("data/Gray.dat");//
  for (int PimgInit = 0; PimgInit < IMGBUFSIZE; PimgInit++)
    BehavImage[PimgInit] = createImage(640, 480, ARGB);      


  //UpdateDropList();
  thread("SaveThread");
}

public void draw() {
  background(51);
  fill(51);
  stroke(80);
  rect(5, 45, 390, 680);    //Scope 1 group
  rect(400, 45, 340, 365);     //Behavior group
  rect(400, 415, 340, 310);     //Gsensor group
  rect(745, 45, 390, 680);    //Scope 2 group

  image(GSensPanel, 410, 445); 

  if (fCamEnabled)
  {
    if (WindowZoomCam1.isVisible() == false) {
      image(cam, 10, 70, 376, 240);
      if ( (byte)cam.pixels[360955] == (byte)0xFF)
      {
        stroke(255);
        fill(255);
        rect(10, 290, 376, 20);
      }
    }
  } else
  {
    stroke(54);
    fill(54);
    rect(10, 70, 376, 240);
  }

  if (fCam2Enabled)
  {
    if (WindowZoomCam2.isVisible() == false) {
      image(cam2, 750, 70, 376, 240);
    }
  } else
  {
    stroke(54);
    fill(54);
    rect(750, 70, 376, 240);
  }

  if ( fBehavCamEnabled )
  {
    if (windowZoomBehav.isVisible() == false)
    {
      image(BehavCam, 410, 70, 320, 240);
    }
  } else
  {
    stroke(54);
    fill(54);
    rect(410, 70, 320, 240);
  }

  Lbl_RngBuf1Status.setText("Buffer: " + Integer.toString(Tiff1diffSve)); 

  PairCamera1();
  PairCamera2();

  if (FirstTimeUpdateDLCam == 1)
    UpdateDropList();
  if (FirstTimeUpdateDLCam>0)
    FirstTimeUpdateDLCam--;
}



public void PairCamera1 ()
{
  if (PairCam > 0)
  {
    if ( PairCam == 1)
    {     
      if (PApplet.platform != MACOSX )
      {    
        while (!NINscopeList[camIndex].contains("NINScope"))
        {
          camIndex++;
        }
      }
      cam = new Capture(this, 752, 480, NINscopeList[camIndex]);
      cam.start();
      println("Check Cam :" + camIndex);
      PairCam = 2;
      fCamEnabled = true;
      PairRetry = 50;
    } else if ( PairCam == 2 )
    {
      if ((byte)cam.pixels[360954] == 0x5D)
      {
        PairCam = 0;
        myPort.write( new byte[]{0x02, CMD_PAIR_CAM_OFF, 0, 0x02}); 
        LbL_NINscopeSelcted.setText(NINscopeList[camIndex]);

        fSerialEnabled = true;
        Btn_ConnectScope1.setText("Disconnect");
      }
      PairRetry--;
      if ( PairRetry == 0)
      {
        camIndex++;
        if ( camIndex < NINscopeList.length)
        {
          println("Check Cam :" + camIndex);
          fCamEnabled = false;
          cam.stop();
          if (PApplet.platform != MACOSX )
          {    
            while (!NINscopeList[camIndex].contains("NINScope"))
            {
              camIndex++;
            }
          }                    
          cam = new Capture(this, 752, 480, NINscopeList[camIndex]);
          cam.start();
          fCamEnabled = true;
          PairRetry = 50;
        } else
        {
          fCamEnabled = false;
          ConsoleArea.appendText("Cannot Connect Camera");
          SetWarning("Cannot Connect Camera");
          myPort.clear();
          myPort.stop();
          myPort = null;
        }
      }
    }
  }
}

public void PairCamera2 ()
{
  if (PairCam2 > 0)
  {
    if ( PairCam2 == 1)
    {
      if (PApplet.platform != MACOSX )
      {    
        while (!NINscope2List[camIndex2].contains("NINScope"))
        {
          camIndex2++;
        }
      }
      cam2 = new Capture(this, 752, 480, NINscope2List[camIndex2]);
      cam2.start();
      println("Check Cam :" + camIndex2);
      PairCam2 = 2;
      fCam2Enabled = true;
      PairRetry2 = 50;
    } else if ( PairCam2 == 2 )
    {
      if ((byte)cam2.pixels[360954] == 0x5D)
      {
        PairCam2 = 0;
        myPort2.write( new byte[]{0x02, CMD_PAIR_CAM_OFF, 0, 0x02}); 
        LbL_NINscope2Selected.setText(NINscope2List[camIndex2]);

        fSerial2Enabled = true;
        Btn_ConnectScope2.setText("Disconnect");
      }
      PairRetry2--;
      if ( PairRetry2 == 0)
      {
        camIndex2++;
        if ( camIndex2 < NINscope2List.length)
        {
          println("Check Cam :" + camIndex2);
          fCam2Enabled = false;
          cam2.stop();
          if (PApplet.platform != MACOSX )
          {    
            while (!NINscope2List[camIndex2].contains("NINScope"))
            {
              camIndex2++;
            }
          } 
          cam2 = new Capture(this, 752, 480, NINscope2List[camIndex2]);
          cam2.start();
          fCam2Enabled = true;
          PairRetry2 = 50;
        } else
        {
          fCam2Enabled = false;
          ConsoleArea.appendText("Cannot Connect Camera");
          SetWarning("Cannot Connect Camera");
          myPort2.clear();
          myPort2.stop();
          myPort2 = null;
        }
      }
    }
  }
}




public void SaveThread ()
{
  while (true)
  {
    SaveImgData1();
    SaveImgData2();
    SaveBehaveImg();
    SaveTimeStampToFile();
    delay(1);
  }
}


// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {

  background(51);
  delay(1000);

  WindowZoomCam1. setVisible(false);
  //WindowZoomCam1.setAlwaysOnTop(true);
  windowZoomBehav.setVisible(false);
  WindowZoomCam2. setVisible(false);
  WindowWarning.setVisible(false);
  WindowWarning.setAlwaysOnTop(true);
  SettingsWnd.setVisible(false);

  SettingsWnd.addDrawHandler(this, "winOptoDraw");
  WindowZoomCam2.addDrawHandler(this, "WindZmCam2draw");
  WindowZoomCam2.addMouseHandler(this, "WndZmCam2Mouse");
  windowZoomBehav.addDrawHandler(this, "WindZmBehavdraw");
  WindowZoomCam1.addDrawHandler(this, "WindZmCam1draw");
  WindowZoomCam1.addMouseHandler(this, "WndZmCam1Mouse");
  WindowWarning.addDrawHandler(this, "WindowWarningDraw");

  Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
  WindowWarning.setLocation(screenSize.width/2, screenSize.height/2);

  LbL_FramesPT.setVisible(false);
  tf_FramesPT.setVisible(false);
  LbL_RecFrameCnt.setVisible(false);
  tf_RecFrmeCnt.setVisible(false);

  // Gain options - fixed to gain 2
  Opt_Gain1.setVisible(false);
  Opt_Gain2.setVisible(false);
  Opt_Gain1_Cam2.setVisible(false);
  Opt_Gain2_Cam2.setVisible(false);

  // Read out Temperture Python - only possible with connection on DAQ between D0 and MISO
  Btn_TempPyRead.setVisible(true);
  LbL_TemperaturePy.setVisible(true);
  Chk_TempAuto.setVisible(true);

  ROI1 = new ROIAvg(WindowZoomCam1, 360, 520); 
  ROI2 = new ROIAvg(WindowZoomCam2, 360, 520); 

  timer1 = new GTimer(this, this, "handleTimer1", 1000);
  timer1.start();
}

public void handleTextEvents(GEditableTextControl textcontrol, GEvent event) 
{ /* code */
}

public void handleDropListEvents(GDropList list, GEvent event) 
{ /* code */
}


public void handleTimer1 ( GTimer timer )
{

  //println("timer1 - GTimer >> an event occured @ " + millis());
  label1.setText("Rate: " + FrameCnt);
  LbLFrameRate2.setText("Rate: " + FrameCnt2);
  LbL_FrameBehave.setText("Rate: " + FramBehaveCnt);
  FrameCnt = 0;
  FrameCnt2 = 0;
  FramBehaveCnt = 0;

  if (fTempUpdate == true )
  {
    LbL_Temperature.setText(String.format("%.2f", ((float)Temperature/256)+25) + "° C");
  }

  if (fTempUpdatePy)
  {      // Celcius = (68°F - 32) × 5/9

    LbL_TemperaturePy.setText(String.format("%.2f", ((float)TemperaturePy-32)*5/9) + "° C");
  }

  if ( Chk_TempAuto.isSelected() == true)
  {

    //myPort.write(new byte[] { 0x02,CMD_TEMP_RD,0,0});

    myPort.write(new byte[] { 0x02, CMD_PYTEMP_RD, 0, 0});
  }

  LblRecScp1.setText(     "Rec: "   +  CamRecordCnt);     
  LblDropScp1.setText(    "Drop: "  + (CamRecordCnt  - RecCntScp1)); 
  LblDropScp2.setText(    "Drop: "  + (Cam2RecordCnt - RecCntScp2)); 

  if (Tiff1diff < Tiff1diffSve )
    Tiff1diffSve--;

  if (Tiff2diff < Tiff2diffSve )
    Tiff2diffSve--;
}



public void BtnSaveSettings()
{
  if ( tf_Name.getText() != "" )
  {
    PrintWriter PWSettings;

    Calendar ScopeCal = Calendar.getInstance();
    SimpleDateFormat DateNow = new SimpleDateFormat("yyyyMMdd");
    String DateStr = DateNow.format(ScopeCal.getTime());
    PWSettings = createWriter(tf_Name.getText() + "_" + DateStr + ".dat"); 
    PWSettings.println("Settings " + tf_Name.getText() + " " + DateStr );
    PWSettings.println(tf_Name.getText());

    PWSettings.println(Sli_ExciCam1.getValueS());
    PWSettings.println(Sli_ExpoCam1.getValueS());
    PWSettings.println(Sli_GainCam1.getValueS());
    PWSettings.println(Sli_BlackOffsetCam1.getValueS());

    PWSettings.println(Sli_ExciCam2.getValueS());
    PWSettings.println(Sli_ExpoCam2.getValueS());
    PWSettings.println(Sli_GainCam2.getValueS());
    PWSettings.println(Sli_BlackOffsetCam2.getValueS());

    //Settings
    PWSettings.println(Sli_OptoGen.getValueS());
    PWSettings.println(tf_PulseOn.getText());
    PWSettings.println(tf_PulseOff.getText());
    PWSettings.println(tf_StrDelay.getText());
    PWSettings.println(tf_BurstCnt.getText() );
    PWSettings.println(tf_Pause.getText());
    PWSettings.println(tf_LoopCnt.getText() );

    if ( OG_OptoAuto.isSelected() == true)
      PWSettings.println("true");
    else
      PWSettings.println("false");

    if ( ChkBox_TriggerInput.isSelected() == true)
      PWSettings.println("true");
    else
      PWSettings.println("false");

    if (Chkbox_FramesPT.isSelected() == true)
      PWSettings.println("true");
    else
      PWSettings.println("false");       

    PWSettings.println(tf_FramesPT.getText());

    if (Chkox_RecFixedFrames.isSelected() == true)
      PWSettings.println("true");
    else
      PWSettings.println("false");

    PWSettings.println(tf_RecFrmeCnt.getText());

    PWSettings.println(Sld_Cam1.getValueXI());
    PWSettings.println(Sld_Cam1.getValueYI());

    PWSettings.println(Sld_Cam2.getValueXI());
    PWSettings.println(Sld_Cam2.getValueYI());

    PWSettings.println(SerialList.getSelectedText());
    PWSettings.println(SerialPort2List.getSelectedText());
    PWSettings.println(BehavList1.getSelectedText());

    if (ChBox_AutoCal.isSelected() == true)
      PWSettings.println("true");
    else
      PWSettings.println("false");             

    if (ChBox_AutoCal2.isSelected() == true)
      PWSettings.println("true");
    else
      PWSettings.println("false");

    PWSettings.flush();
    PWSettings.close();

    ConsoleArea.appendText( ConsoleLineNumb++ + " Settings Saved");
    ConsoleArea.appendText( ConsoleLineNumb++ + " " + tf_Name.getText() + "_" + DateStr + ".dat");
  } else
  {
    ConsoleArea.appendText( ConsoleLineNumb++ + " Define name");
    SetWarning("Define name");
  }
}

public void BtnLoadSettings()
{
  selectInput("Load settings", "fileSelected");
}



public int SearchDropList ( GDropList SearchList, String SearchStr )
{
  int SrchInd = 0;
  SearchList.setSelected(SrchInd); 
  println(SearchStr);
  println(SearchList.getSelectedIndex());
  println(SrchInd);
  while (!SearchStr.equals(SearchList.getSelectedText()) && SearchList.getSelectedIndex() == SrchInd )
  {
    SrchInd++; 
    SearchList.setSelected(SrchInd); 
    println(SearchList.getSelectedText());
    println(SearchList.getSelectedIndex());
    println(SrchInd);
  }
  return SrchInd;
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else 
  {

    BufferedReader reader = createReader(selection.getAbsolutePath());
    String line = null;
    try {
      line = reader.readLine(); //skip first
      line = reader.readLine(); 
      println(line);
      tf_Name.setText(line); 

      // Excitation 
      line = reader.readLine(); 
      println(line);
      Sli_ExciCam1.setValue(Integer.parseInt(line));
      if (Sli_ExciCam1.getValueI() != 0) {
        Float ExciMilliAmps = Sli_ExciCam1.getValueI()*1.4+0.977;
        LbL_ExciStat.setText(String.format ("%.2f", ExciMilliAmps) + "mA - " +Sli_ExciCam1.getValueS()); //1.4 mA) + 0.977
      } else {
        LbL_ExciStat.setText("0mA - 0");
      }
      //Exposure
      line = reader.readLine(); 
      println(line);
      Sli_ExpoCam1.setValue(Integer.parseInt(line));
      LbL_ExpoStat.setText(String.format ("%.2f", (float)Sli_ExpoCam1.getValueI()*0.0012) + "mS - " + Sli_ExpoCam1.getValueI());

      //Gain
      line = reader.readLine(); 
      println(line);
      Sli_GainCam1.setValue(Integer.parseInt(line));
      //LbL_GainStat.setText( Integer.toString(Sli_GainCam1.getValueI()) ); 
      LbL_GainStat.setText(Integer.toString(Sli_GainCam1.getValueI()>>7) + "." + Integer.toString((Sli_GainCam1.getValueI()&0x007F)*100/127));

      //BlackOffset
      line = reader.readLine(); 
      println(line);
      Sli_BlackOffsetCam1.setValue(Integer.parseInt(line));
      LbL_BlackOffsetStat.setText(Integer.toString(Sli_BlackOffsetCam1.getValueI()));

      // Excitation 
      line = reader.readLine(); 
      println(line);
      Sli_ExciCam2.setValue(Integer.parseInt(line));
      if (Sli_ExciCam2.getValueI() != 0) {
        Float ExciMilliAmps = Sli_ExciCam2.getValueI()*1.4+0.977;
        LbL_ExciStat2.setText(String.format ("%.2f", ExciMilliAmps) + "mA - " +Sli_ExciCam2.getValueS()); //1.4 mA) + 0.977
      } else {
        LbL_ExciStat2.setText("0mA - 0");
      }
      //Exposure
      line = reader.readLine(); 
      println(line);
      Sli_ExpoCam2.setValue(Integer.parseInt(line));
      LbL_ExpoStat2.setText(String.format ("%.2f", (float)Sli_ExpoCam2.getValueI()*0.0012) + "mS - " + Sli_ExpoCam2.getValueI());

      //Gain
      line = reader.readLine(); 
      println(line);
      Sli_GainCam2.setValue(Integer.parseInt(line));
      LbL_GainStat2.setText(Integer.toString(Sli_GainCam2.getValueI()>>7) + "." + Integer.toString((Sli_GainCam2.getValueI()&0x007F)*100/127));

      //BlackOffset 2
      line = reader.readLine(); 
      println(line);
      Sli_BlackOffsetCam2.setValue(Integer.parseInt(line));
      LbL_BlackOffsetStat2.setText(Integer.toString(Sli_BlackOffsetCam2.getValueI()));

      //Settings
      line = reader.readLine(); 
      println(line);
      Sli_OptoGen.setValue(Integer.parseInt(line));
      int OptoMilliAmps = Sli_OptoGen.getValueI()*11;
      LbLOptoBrightState.setText(OptoMilliAmps + "mA - " +Sli_OptoGen.getValueS()); 

      line = reader.readLine(); 
      println(line);
      tf_PulseOn.setText(line);

      line = reader.readLine(); 
      println(line);
      tf_PulseOn.setText(line);

      line = reader.readLine(); 
      println(line);
      tf_StrDelay.setText(line);

      line = reader.readLine(); 
      println(line);
      tf_BurstCnt.setText(line);

      line = reader.readLine(); 
      println(line);
      tf_Pause.setText(line);

      line = reader.readLine(); 
      println(line);
      tf_LoopCnt.setText(line);

      line = reader.readLine(); 
      println(line);      
      if (line.equals("true"))
        OG_OptoAuto.setSelected(true); 
      else
        OG_OptoAuto.setSelected(false); 

      line = reader.readLine(); 
      println(line);
      if (line.equals("true"))
        ChkBox_TriggerInput.setSelected(true); 
      else
        ChkBox_TriggerInput.setSelected(false); 

      line = reader.readLine(); 
      println(line);
      if (line.equals("true"))
      {
        Chkbox_FramesPT.setSelected(true);
        LbL_FramesPT.setVisible(true);
        tf_FramesPT.setVisible(true);
      } else
        Chkbox_FramesPT.setSelected(false); 

      line = reader.readLine(); 
      println(line);
      tf_FramesPT.setText(line);

      line = reader.readLine(); 
      println(line);
      if (line.equals("true"))
      {
        Chkox_RecFixedFrames.setSelected(true); 
        LbL_RecFrameCnt.setVisible(true);
        tf_RecFrmeCnt.setVisible(true);
      } else
        Chkox_RecFixedFrames.setSelected(false); 

      line = reader.readLine(); 
      println(line);
      tf_RecFrmeCnt.setText(line);  

      line = reader.readLine(); 
      println(line);
      Sld_Cam1.setValueX(Integer.parseInt(line));
      line = reader.readLine(); 
      println(line);
      Sld_Cam1.setValueY(Integer.parseInt(line));

      line = reader.readLine(); 
      println(line);
      Sld_Cam2.setValueX(Integer.parseInt(line));
      line = reader.readLine(); 
      println(line);
      Sld_Cam2.setValueY(Integer.parseInt(line));

      line = reader.readLine(); 
      println(line);
      SerialList.setSelected(SearchDropList( SerialList, line));

      line = reader.readLine(); 
      println(line);
      SerialPort2List.setSelected(SearchDropList( SerialPort2List, line));

      line = reader.readLine(); 
      println(line);
      BehavList1.setSelected(SearchDropList( BehavList1, line));      

      line = reader.readLine(); 
      println(line);
      if (line.equals("true"))
        ChBox_AutoCal.setSelected(true); 
      else
        ChBox_AutoCal.setSelected(false); 

      line = reader.readLine(); 
      println(line);
      if (line.equals("true"))
        ChBox_AutoCal2.setSelected(true); 
      else
        ChBox_AutoCal2.setSelected(false); 

      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
    println("User selected " + selection.getAbsolutePath());
  }
}



public void SetWarning ( String StrWarning )
{
  LbL_warning.setText(StrWarning);
  LbL_warning.setTextBold();
  WindowWarning.setVisible(true);
}


public void SaveSettings()
{
  Calendar ScopeCal = Calendar.getInstance();
  SimpleDateFormat TimeNow = new SimpleDateFormat("HH:mm:ss");
  PWriteNotes.println("TIME:" + TimeNow.format(ScopeCal.getTime()));

  PWriteNotes.println("Settings NINScope 1:");
  if (Sli_ExciCam1.getValueI() != 0) {
    Float ExciMilliAmps = Sli_ExciCam1.getValueI()*1.4+0.977;
    PWriteNotes.println("Excitation: " + String.format ("%.2f", ExciMilliAmps) + "mA - " +Sli_ExciCam1.getValueS()); //1.4 mA) + 0.977
  } else {
    PWriteNotes.println("Excitation: 0mA - 0");
  }
  PWriteNotes.println("Exposure: " + String.format ("%.2f", (float)Sli_ExpoCam1.getValueI()*0.0012) + "mS - " + Sli_ExpoCam1.getValueI());
  PWriteNotes.println("Gain: " + Integer.toString(Sli_GainCam1.getValueI()));
  PWriteNotes.println("Black Offset: " + Integer.toString(Sli_BlackOffsetCam1.getValueI()));
  if (ChBox_AutoCal.isSelected() == true)
    PWriteNotes.println("Auto Cal=true");
  else
    PWriteNotes.println("Auto Cal=false");             

  PWriteNotes.println("ROI X: " + Sld_Cam1.getValueXI());
  PWriteNotes.println("ROI Y: " + Sld_Cam1.getValueYI());


  if (fCam2Enabled == true)
  {
    PWriteNotes.println("");
    PWriteNotes.println("Settings NINScope 2:");
    if (Sli_ExciCam2.getValueI() != 0) {
      Float ExciMilliAmps = Sli_ExciCam2.getValueI()*1.4+0.977;
      PWriteNotes.println("Excitation: " + String.format ("%.2f", ExciMilliAmps) + "mA - " +Sli_ExciCam2.getValueS()); //1.4 mA) + 0.977
    } else {
      PWriteNotes.println("Excitation: 0mA - 0");
    }
    PWriteNotes.println("Exposure: " + String.format ("%.2f", (float)Sli_ExpoCam2.getValueI()*0.0012) + "mS - " + Sli_ExpoCam2.getValueI());
    PWriteNotes.println("Gain: " + Integer.toString(Sli_GainCam2.getValueI()));
    PWriteNotes.println("Black Offset: " + Integer.toString(Sli_BlackOffsetCam2.getValueI()));
    if (ChBox_AutoCal2.isSelected() == true)
      PWriteNotes.println("Auto Cal = true");
    else
      PWriteNotes.println("Auto Cal = false");
    PWriteNotes.println("ROI X: " + Sld_Cam2.getValueXI());
    PWriteNotes.println("ROI Y: " + Sld_Cam2.getValueYI());
  }
  PWriteNotes.println("");
  PWriteNotes.println("Settings OptoGenetics:");

  int OptoMilliAmps = Sli_OptoGen.getValueI()*11;
  PWriteNotes.println("LED Brightness: " + OptoMilliAmps + "mA - " +Sli_OptoGen.getValueS());
  PWriteNotes.println("Puls Time On: " + tf_PulseOn.getText() + "mS");
  PWriteNotes.println("Puls Time Off: " + tf_PulseOff.getText() + "mS");
  PWriteNotes.println("Start Delay: " + tf_StrDelay.getText() + "mS");
  PWriteNotes.println("Burst count: " + tf_BurstCnt.getText() );
  PWriteNotes.println("Pause time: " + tf_Pause.getText() + "mS");
  PWriteNotes.println("Loop count: " + tf_LoopCnt.getText() );

  PWriteNotes.println("");
  PWriteNotes.println("Settings Trigger:");

  if ( ChkBox_TriggerInput.isSelected() == true)
  {
    PWriteNotes.println("Trigger Input: Enabled");
    if (!tf_FramesPT.getText().equals("0"))
      PWriteNotes.println("Frames per Trigger: " +  tf_FramesPT.getText());
  } else
  {
    PWriteNotes.println("Trigger Input: Disabled");
  }

  if (Chkox_RecFixedFrames.isSelected() == true)
  {
    PWriteNotes.println("Recording Fixed frames: Enabled");
    if (!tf_FramesPT.getText().equals("0"))
      PWriteNotes.println("Frames #: " +  tf_RecFrmeCnt);
  } else
  {
    PWriteNotes.println("Recording Fixed frames: Disabled");
  }
}

public void StopRecording ()
{
  myPort.write(new byte[]{0x02, CMD_STOP_RECORD, 0, 0x02});
  //wait till pointers are equal
  while ( TimeStpC1write != TimeStpC1read )
  {
    delay(3);
  }
  PWriteLogData.flush();  // Writes the remaining data to the file
  PWriteLogData.close();  // Finishes the file
  PWriteNotes.flush();
  PWriteNotes.close();
  PWriteTimeStFile.flush();
  PWriteTimeStFile.close();
  fRecord = false;
  Btn_Record.setText("Record");
}

public void UpdateDropList()
{
  ConsoleArea.appendText("Camera Check.");
  String[] cameras = Capture.list();

  if (cameras == null) 
  {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } else if (cameras.length == 0) 
  {
    println("There are no cameras available for capture.");
    ConsoleArea.appendText("ERROR: No Camera found!");
    SetWarning("No Camera found!");
  } else 
  {
    ConsoleArea.appendText("Camera found!");

    if (PApplet.platform == MACOSX )
    {
      String[] CamIndex = {"0", "1", "2", "3", "4"};
      ConsoleArea.appendText("No device names available.");
      ConsoleArea.appendText("Please use 0-4 in the droplist");
      ConsoleArea.appendText("to select Cam");
      NINscopeList = CamIndex.clone(); 
      BehavList1.setItems(CamIndex, 5); 
      NINscope2List = CamIndex.clone();
    } else
    {
      NINscopeList = cameras.clone();
      NINscope2List = cameras.clone(); 
      BehavList1.setItems(cameras, cameras.length); 
      int SelectedUVCCAM = 0;
      for (int SearchUVCCam = 0; SearchUVCCam < cameras.length; SearchUVCCam++)
      {
        BehavList1.setSelected(SearchUVCCam);
        println(BehavList1.getSelectedText() + " " + SearchUVCCam);
        if (!BehavList1.getSelectedText().contains("NINScope") )
        {
          SelectedUVCCAM = SearchUVCCam;
        }
      }
      BehavList1.setSelected(SelectedUVCCAM);
    }


    ConsoleArea.appendText("Serial port Check..");
    if (Serial.list().length>0)
    {
      SerialList.setItems(Serial.list(), Serial.list().length);
      SerialPort2List.setItems(Serial.list(), Serial.list().length);
      if (Serial.list().length > 1)
        SerialPort2List.setSelected(Serial.list().length-2);
      ConsoleArea.appendText("Serial port found!");
    } else
    {
      ConsoleArea.appendText("ERROR: No Serial port!");
      SetWarning("No Serial port!");
      String[] None = {"No Serial Port", "Available"};
      SerialList.setItems(None, 1);
    }
  }
}

public void SaveImgData1 () {
  if ( Tiff1write != Tiff1read )
  {
    saveBytes(Tiff1Filename[Tiff1write], TiffData[Tiff1write]);
    if (Tiff1read>Tiff1write)
    {
      Tiff1diff = Tiff1read-Tiff1write;
      if (Tiff1diff > Tiff1diffSve )
      {
        Tiff1diffSve = Tiff1diff;
      }

      if ((Tiff1read-Tiff1write) > IMGBUFSIZE - 10)
      {
        ConsoleArea.appendText("Buffer Warning");
        SetWarning("Buffer Warning");
      }
    } else
    {

      Tiff1diff = Tiff1read-Tiff1write+IMGBUFSIZE;
      if (Tiff1diff > Tiff1diffSve )
      {
        Tiff1diffSve = Tiff1diff;
      }
      if ( (Tiff1read-Tiff1write+IMGBUFSIZE) > IMGBUFSIZE - 10 )
      {
        ConsoleArea.appendText("Buffer Warning");
        SetWarning("Buffer Warning");
      }
    }
    Tiff1write++;
    if ( Tiff1write > IMGBUFSIZE-1 )
      Tiff1write = 0;
  }
}

public void SaveImgData2 () {

  if ( Tiff2write != Tiff2read )
  {
    saveBytes(Tiff2Filename[Tiff2write], TiffData2[Tiff2write]);
    if (Tiff2read>Tiff2write)
    {
      Tiff2diff = Tiff2read-Tiff2write;
      if (Tiff2diff > Tiff2diffSve )
      {
        Tiff2diffSve = Tiff2diff;
      }

      if ((Tiff2read-Tiff2write) > IMGBUFSIZE - 10)
      {
        ConsoleArea.appendText("Buffer 2 Warning");
        SetWarning("Buffer 2 Warning");
      }
    } else
    {

      Tiff2diff = Tiff2read-Tiff2write+IMGBUFSIZE;
      if (Tiff2diff > Tiff2diffSve )
      {
        Tiff2diffSve = Tiff2diff;
      }
      if ( (Tiff2read-Tiff2write+IMGBUFSIZE) > IMGBUFSIZE - 10 )
      {
        ConsoleArea.appendText("Buffer 2 Warning");
        SetWarning("Buffer 2 Warning");
      }
    }
    Tiff2write++;
    if ( Tiff2write > IMGBUFSIZE-1 )
      Tiff2write = 0;
  }
}

public void SaveBehaveImg ()
{
  if ( Behav3write != Behav3read )
  {
    if ( BehavFormat == 0)
      BehavImage[Behav3write].save(Behav3Filename[Behav3write]);
    else
      BehavImage[Behav3write].get(0, 0, 320, 240).save(Behav3Filename[Behav3write]);

    //saveBytes(Behav3Filename[Behav3write], TiffData2[Behav3write]);
    if (Behav3read>Behav3write)
    {
      Behav3diff = Behav3read-Behav3write;
      if (Behav3diff > Behav3diffSve )
      {
        Behav3diffSve = Behav3diff;
      }

      if ((Behav3read-Behav3write) > IMGBUFSIZE - 10)
      {
        ConsoleArea.appendText("Buffer 3 Warning");
        SetWarning("Buffer 3 Warning");
      }
    } else
    {

      Behav3diff = Behav3read-Behav3write+IMGBUFSIZE;
      if (Behav3diff > Behav3diffSve )
      {
        Behav3diffSve = Behav3diff;
      }
      if ( (Behav3read-Behav3write+IMGBUFSIZE) > IMGBUFSIZE - 10 )
      {
        ConsoleArea.appendText("Buffer 3 Warning");
        SetWarning("Buffer 3 Warning");
      }
    }
    Behav3write++;
    if ( Behav3write > IMGBUFSIZE-1 )
      Behav3write = 0;
  }
}

public void SaveTimeStampToFile()
{
  if ( TimeStpC1write != TimeStpC1read )
  {
    PWriteTimeStFile.println( TimeStpC1Buf[TimeStpC1write] );
    TimeStpC1write++;
    if ( TimeStpC1write > IMGBUFSIZE-1 )
      TimeStpC1write = 0;
  }
  if ( TimeStpC2write != TimeStpC2read )
  {
    PWriteTimeStFile.println( TimeStpC2Buf[TimeStpC2write] );
    TimeStpC2write++;
    if ( TimeStpC2write > IMGBUFSIZE-1 )
      TimeStpC2write = 0;
  }  
  if ( TimeStpC3write != TimeStpC3read )
  {
    PWriteTimeStFile.println( TimeStpC3Buf[TimeStpC3write] );
    TimeStpC3write++;
    if ( TimeStpC3write > IMGBUFSIZE-1 )
      TimeStpC3write = 0;
  }
}


public void captureEvent(Capture c) 
{
  if ( c == cam )                                                                            //Event is for Miniscope 1
  {
    cam.read();             //capture from MiniScope

    Boolean fOptoActive = false;
    if ( (byte)cam.pixels[360955] == (byte)0xFF)
    {
      fOptoActive = true;
      ROI1.OptoActive();
    } 

    if ( fRecord ) {                                                                       //only when recording
      CamRecordCnt  = 0x000000FF&(byte)cam.pixels[360959];                         //extract frame count from image
      CamRecordCnt |= 0x0000FF00&(byte)cam.pixels[360958] *0x100;                  //     frame count middle low 8bit
      CamRecordCnt |= 0x00FF0000&(byte)cam.pixels[360957] *0x10000;                //     frame count midele high 8 bit
      CamRecordCnt |= 0xFF000000&(byte)cam.pixels[360956] *0x1000000;              //     frame count high 8 bit ( total 32 bit )



      if ( CamRecordCnt == 1 || fStartRecord == true)                               //wait for first image to arrived
      {

        fStartRecord = true;                                                      //first image is arrived recording is started

        RecCntScp1++;                                                              //increase Record counter for every image arrived and saved
        DropScp1 = RecCntScp1 - CamRecordCnt;                                      //Drops 

        if (fOptoActive == true)
        {
          for (int i = 0; i < 359456; i++)                                           //copy lower byte of pixel info
            TiffData[Tiff1read][i+0x100] = (byte)cam.pixels[i];                               //starting at 0x100 offset for tiff header
          for (int i = 359456; i < 360960; i++)  
            TiffData[Tiff1read][i+0x100] = (byte)0xFF;
        } else
          for (int i = 0; i < 360960; i++)                                           //copy lower byte of pixel info
            TiffData[Tiff1read][i+0x100] = (byte)cam.pixels[i];                               //starting at 0x100 offset for tiff header

        Tiff1Filename[Tiff1read] =  FilePrefix  + "/" +  "Scope1" + "/" + CamRecordCnt + ".tiff";   

        Tiff1read ++;
        if ( Tiff1read > IMGBUFSIZE-1 )
          Tiff1read = 0;

        TimeStpC1Buf[TimeStpC1read] = "Scope1,"+ CamRecordCnt + "," +(millis()-RecStartTime);

        TimeStpC1read ++;
        if ( TimeStpC1read > IMGBUFSIZE-1 )
          TimeStpC1read = 0;

        DropScp1Sve = DropScp1;  

        if ( CamRecordCnt >= FixedRecCnt && FixedRecCnt != 0)
          StopRecording();
      }
    }
    FrameCnt++;                    //frame rate display ( see timer1 )
  } else 
  if ( c == cam2 )
  {
    cam2.read();
    if ( fRecord )
    {  
      Cam2RecordCnt  = 0x000000FF&(byte)cam2.pixels[360959];                         //extract frame count from image
      Cam2RecordCnt |= 0x0000FF00&(byte)cam2.pixels[360958] *0x100;                  //     frame count middle low 8bit
      Cam2RecordCnt |= 0x00FF0000&(byte)cam2.pixels[360957] *0x10000;                //     frame count midele high 8 bit
      Cam2RecordCnt |= 0xFF000000&(byte)cam2.pixels[360956] *0x1000000;              //     frame count high 8 bit ( total 32 bit )

      if ( Cam2RecordCnt == 1 || fStartRecord2 == true)
      {  
        fStartRecord2 = true;

        RecCntScp2++;
        DropScp2 = RecCntScp2 - Cam2RecordCnt;

        for (int i = 0; i < 360960; i++)                                           //copy lower byte of pixel info
          TiffData2[Tiff2read][i+0x100] = (byte)cam2.pixels[i];                               //starting at 0x100 offset for tiff header

        Tiff2Filename[Tiff2read] =  FilePrefix  + "/" +  "Scope2" + "/" + Cam2RecordCnt + ".tiff";   

        Tiff2read ++;
        if ( Tiff2read > IMGBUFSIZE-1 )
          Tiff2read = 0;

        TimeStpC2Buf[TimeStpC2read] = "Scope2,"+ Cam2RecordCnt + "," +(millis()-RecStartTime);
        TimeStpC2read ++;
        if ( TimeStpC2read > IMGBUFSIZE-1 )
          TimeStpC2read = 0;


        DropScp2Sve = DropScp2;
      }
    }
    FrameCnt2++;
  } else 
  if ( c == BehavCam )
  {
    BehavCam.read();

    if (fRecord == true && fStartRecord == true)
    {       
      RecCntBehav++;

      Behav3Filename[Behav3read] = FilePrefix + "/"  + "Behaviour" + "/" + RecCntBehav +  ".tiff";
      if ( BehavFormat == 0)
      {
        BehavImage[Behav3read].copy(BehavCam, 0, 0, 640, 480, 0, 0, 640, 480);
      } else
      {
        BehavImage[Behav3read].copy(BehavCam, 0, 0, 320, 240, 0, 0, 320, 240);
      }

      TimeStpC3Buf[TimeStpC3read] = "BehaveCam,"+ RecCntBehav + "," +(millis()-RecStartTime);
      TimeStpC3read ++;
      if ( TimeStpC3read > IMGBUFSIZE-1 )
        TimeStpC3read = 0;      


      Behav3read ++;
      if ( Behav3read > IMGBUFSIZE-1 )
        Behav3read = 0;
    }
    FramBehaveCnt++;
  }
}
