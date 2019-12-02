import g4p_controls.*;
import java.util.Arrays;


public class ROIAvg
{

  private static final int HEIGHT = 100;
  private static final int WIDTH = 355;
  private static final int SKIPF = 3;

  int x1 = 0, y1 = 0, x2 = 10, y2 = 10;
  PGraphics AvgGraph;
  int Avg = 0, SveAvg = 0;
  int AvgRAW = 0;
  PApplet appcROIAvg;
  int Gain = 1;
  int OptoCnt = 0;
  GButton GainUp; 

  GButton BtnFloor;
  GButton GainDown;
  GButton BtnTshUp;
  GButton BtnTshDown;

  GLabel Lbl_Gain;
  GLabel Lbl_Avg;
  GCheckbox Chk_Threshold; 
  int skipFrames  = 0;
  int Floor;
  int Threshold = HEIGHT/2; 
  Boolean ThresholdActive = false;

  int XPos = 0;
  int YPos = 0;

  int AvgMin;//[];
  int AvgMinCnt = 0;
  boolean OPtoActive = false;
  boolean fRstfloor;

  public void AvgChkBoxEventHandle(GCheckbox CheckBox, GEvent event) 
  {

    if ( CheckBox == Chk_Threshold)
    {
      if ( Chk_Threshold.isSelected() == true)
      {
        BtnTshUp.setVisible(true);
        BtnTshDown.setVisible(true);  
        Chk_Threshold.setText("Chk_Threshold: " + Threshold);
        ThresholdActive = true;
      } else
      {
        BtnTshUp.setVisible(false);
        BtnTshDown.setVisible(false);
        Chk_Threshold.setText("Chk_Threshold:Off");
        ThresholdActive = false;
      }
    }
  }


  public void AvgButtonEventHandle(GButton button, GEvent event) {

    if ( button == BtnFloor)
    { 
      Floor = AvgMin;
      //for ( int ChkMinCnt = 0; ChkMinCnt<255; ChkMinCnt++)
      //{
      //  if ( Floor > AvgMin[ChkMinCnt])
      //    Floor = AvgMin[ChkMinCnt];
      //}
    } else if ( button == GainUp)
    {
      Gain++;
      if ( Gain > 5 )
        Gain = 5;
      Lbl_Gain.setText("Multiplier: " + Gain);
    } else if ( button == GainDown)
    {
      if (Gain>1)
        Gain--;
      Lbl_Gain.setText("Multiplier: " + Gain);
    } else if ( button == BtnTshUp)
    {
      Threshold++;
      if ( Threshold > HEIGHT )
        Threshold = HEIGHT;
      Chk_Threshold.setText("Threshold: " + Threshold);
    } else if ( button == BtnTshDown)
    {
      if (Threshold>1)
        Threshold--;
      Chk_Threshold.setText("Threshold: " + Threshold);
    }
  }



  ROIAvg(PApplet appcRoisAvgSet, int X, int Y)
  {
    AvgGraph = createGraphics(WIDTH, HEIGHT);
    AvgGraph.beginDraw();
    AvgGraph.background(0);
    appcROIAvg = appcRoisAvgSet;

    //AvgMin = new int[255];
    //Arrays.fill(AvgMin, 255);

    XPos =  X;
    YPos = Y;

    Lbl_Gain = new GLabel(appcROIAvg, XPos+25, YPos+HEIGHT+5, 110, 20);
    Lbl_Gain.setText("Multiplier: " + Gain);
    Lbl_Gain.setVisible(false);

    Lbl_Avg = new GLabel(appcROIAvg, XPos+100, YPos+HEIGHT+5, 110, 20);
    Lbl_Avg.setText("Average: " + Avg);
    Lbl_Avg.setVisible(false);



    Chk_Threshold = new GCheckbox(appcROIAvg, XPos+200, YPos+HEIGHT+5, 189, 20);
    Chk_Threshold.setText("Threshold:Off");
    Chk_Threshold.setVisible(false);
    Chk_Threshold.addEventHandler(this, "AvgChkBoxEventHandle");

    BtnTshUp = new GButton(appcROIAvg, XPos, YPos+75, 20, 20);
    BtnTshUp.setVisible(false);
    BtnTshUp.setText("^");
    BtnTshUp.addEventHandler(this, "AvgButtonEventHandle");

    BtnTshDown = new GButton(appcROIAvg, XPos, YPos+100, 20, 20);
    BtnTshDown.setVisible(false);
    BtnTshDown.setText("v");
    BtnTshDown.addEventHandler(this, "AvgButtonEventHandle");    

    BtnFloor = new GButton(appcROIAvg, XPos, YPos, 20, 20);
    BtnFloor.setVisible(false);
    BtnFloor.setText("F");
    BtnFloor.addEventHandler(this, "AvgButtonEventHandle");

    GainUp = new GButton(appcROIAvg, XPos, YPos+25, 20, 20);
    GainUp.setVisible(false);
    GainUp.setText("+");
    GainUp.addEventHandler(this, "AvgButtonEventHandle");

    GainDown = new GButton(appcROIAvg, XPos, YPos+50, 20, 20);
    GainDown.setVisible(false);
    GainDown.setText("-");
    GainDown.addEventHandler(this, "AvgButtonEventHandle");

    fRstfloor = true;
  }

  void OptoActive ()
  {
    OPtoActive = true;
    OptoCnt++;
    println(OptoCnt);
  }

  void SetActive ( Boolean ROIState )
  {
    if ( ROIState == true)
    {
      BtnFloor.setVisible(true);
      GainUp.setVisible(true);
      GainDown.setVisible(true);
      Lbl_Gain.setVisible(true);
      Lbl_Avg.setVisible(true);
      Chk_Threshold.setVisible(true);
    } else
    {
      BtnFloor.setVisible(false);
      GainUp.setVisible(false);
      GainDown.setVisible(false);
      Lbl_Gain.setVisible(false);
      Lbl_Avg.setVisible(false);
      Chk_Threshold.setVisible(false);
    }
  }


  void ROISet(int setx1, int sety1, int setx2, int sety2 )
  {
    x1 = setx1;
    x2 = setx2;
    y1 = sety1;
    y2 = sety2;
  }

  void SetStartRect(int setx1, int sety1)
  {
    if (setx1 < 752 && sety1 < 480)
    {
      x1 = setx1;
      y1 = sety1;
      x2 = 1;
      y2 = 1;
    }
  }

  void SetEndRect(int setx2, int sety2 )
  { 
    if (setx2 < 752 && sety2 < 480)
    {
      if (setx2 > x1)
        x2 = setx2 -x1;
      if (sety2 > y1)
        y2 = sety2 - y1;
    }
    fRstfloor = true;
  }

  int ROIGetX1()
  {  
    return x1;
  }
  int ROIGetY1()
  {  
    return y1;
  }
  int ROIGetX2()
  {  
    return x2;
  }
  int ROIGetY2()
  {  
    return y2;
  }

  void ROIGraph( PImage  SrcImg )
  {

    skipFrames++;
    if ( skipFrames > SKIPF)
    {
      skipFrames = 0;

      int PixlCnt = 0;
      // Pixel start location in array
      int PixLoca = y1 * SrcImg.width + x1;
      Avg = 0;

      for (int j = 0; j < y2; j++)
      {
        for (int i = PixLoca; i < PixLoca+x2; i++)
        {            
          Avg += SrcImg.pixels[i]&0xff;
          PixlCnt++;
        }
        PixLoca += SrcImg.width;
      }

      Avg /= PixlCnt;
      AvgRAW = Avg;


      AvgMin = Avg;

      Avg -= Floor; 
      Avg *= Gain; //Scale to 5 pixels
      Avg = HEIGHT - 5 - Avg; //Flip image
      
      if(Avg > Threshold && ThresholdActive)
      {
           //ActivedOpto = true;
      }
          

      AvgGraph.beginDraw();

      AvgGraph.copy(1, 0, WIDTH-1, HEIGHT, 0, 0, WIDTH-1, HEIGHT);

      if ( OPtoActive )
      {
        AvgGraph.stroke(120);
        OPtoActive = false;
      } else
      AvgGraph.stroke(0);

      AvgGraph.line(WIDTH-1, 0, WIDTH-1, HEIGHT);

      AvgGraph.stroke(150, 150, 0);

      AvgGraph.line(WIDTH-1, SveAvg, WIDTH-1, Avg);

      

      AvgGraph.endDraw();

      SveAvg = Avg;
    }



    appcROIAvg.fill(0, 0, 0, 0);        
    appcROIAvg.stroke(150, 150, 0);      
    appcROIAvg.rect(x1, y1, x2, y2);      //rect ROI in zoom window

    appcROIAvg.image(AvgGraph, XPos + 25, YPos );
    
    if ( ThresholdActive == true )
    {
        appcROIAvg.stroke(255, 0, 0);    
        appcROIAvg.line(XPos+25, YPos +HEIGHT-Threshold, XPos+25+WIDTH-1, YPos+HEIGHT-Threshold);
    }
    
    Lbl_Avg.setText("Average: " + AvgRAW);

    if ( fRstfloor == true )
    {
      Floor = AvgMin;
      fRstfloor = false;
    }
  }

  int GetAvg( )
  {
    return AvgRAW;
  }
}


PGraphics Histogram( PImage SrcHisto )
{
  PGraphics DestHisto;
  int[] Histogram = new int[256];
  int HistoMax = 0;
  int HistoMin = 255;
  int HistoTop = 0;
  int HistoTopInd = 0;
  int Histoaverage = 0;

  for (int i = 0; i < SrcHisto.pixels.length-6; i++)
  {            
    int HistoValue = SrcHisto.pixels[i]&0xff;
    Histogram[HistoValue] += 1; 
    if (HistoValue > HistoMax)
      HistoMax = HistoValue;
    if ( HistoMin > HistoValue)
      HistoMin = HistoValue;

    Histoaverage +=  HistoValue;
  }

  Histoaverage /= SrcHisto.pixels.length-6;

  for (int i = 0; i < 256; i++)
  {  
    if ( Histogram[i] > HistoTop)
    {
      HistoTop = Histogram[i];
      HistoTopInd = i;
    }
  }

  HistoTop /= 75;

  DestHisto  = createGraphics(255, 100);
  DestHisto.beginDraw();
  DestHisto.background(20);
  DestHisto.stroke(200);

  DestHisto.text(HistoMin, 2, 95);
  DestHisto.text(HistoMax, 225, 95);
  DestHisto.text(HistoTopInd, 125, 95);
  DestHisto.text(Histoaverage, 2, 15);

  for (int i = 0; i < 256; i++)
    if (Histogram[i] > 0)
      DestHisto.line(i, 80, i, 80-Histogram[i]/HistoTop);
  DestHisto.endDraw();
  return DestHisto;
}
