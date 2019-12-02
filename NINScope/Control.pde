
public void handleToggleControlEvents(GToggleControl CheckBox, GEvent event) {
  print(CheckBox);
  
  if( fSerialEnabled == true)
  {
          if( CheckBox == ChkBox_TriggerInput)
          {
        
              if(ChkBox_TriggerInput.isSelected() == true) 
              {
                    Btn_Record.setVisible(false);
              }
              else
              {
                     Btn_Record.setVisible(true);
              }
        
          }
          else if(CheckBox == Opt_Gain1)
          {
            myPort.write(new byte[] { 0x02,CMD_AGAIN,(byte)0x00,(byte)0xE1});
            int VarSliGainCam1 = Sli_GainCam1.getValueI();
            if(Opt_Gain2.isSelected() == true )
                  VarSliGainCam1 *= 2;
            LbL_GainStat.setText(Integer.toString(VarSliGainCam1>>7) + "." + Integer.toString((VarSliGainCam1&0x007F)*100/127)); 
          }
          else if(CheckBox == Opt_Gain2)
          {
            myPort.write(new byte[] { 0x02,CMD_AGAIN,(byte)0x00,(byte)0xC1});
            int VarSliGainCam1 = Sli_GainCam1.getValueI();
            if(Opt_Gain2.isSelected() == true )
                  VarSliGainCam1 *= 2;
            LbL_GainStat.setText(Integer.toString(VarSliGainCam1>>7) + "." + Integer.toString((VarSliGainCam1&0x007F)*100/127));
          }
          else if(  CheckBox == Chkbox_FramesPT)
          {
            if(Chkbox_FramesPT.isSelected() == true) 
            {
              LbL_FramesPT.setVisible(true);
              tf_FramesPT.setVisible(true);
            }
            else 
            {
              LbL_FramesPT.setVisible(false);
              tf_FramesPT.setVisible(false);
              tf_FramesPT.setText("0");
            } 
          }
          else if( CheckBox == OG_OptoManual)
          {
              Btn_Stimulate.setVisible(true);
          }
          else if( CheckBox == OG_OptoAuto)
          {
              Btn_Stimulate.setVisible(false);
          }
          else if(CheckBox == Chkox_RecFixedFrames)
          {
            if(Chkox_RecFixedFrames.isSelected() == true) 
            {
              LbL_RecFrameCnt.setVisible(true);
              tf_RecFrmeCnt.setVisible(true);
            }
            else 
            {
              LbL_RecFrameCnt.setVisible(false);
              tf_RecFrmeCnt.setVisible(false);
              tf_RecFrmeCnt.setText("0");
            } 
          }
          else if(CheckBox == ChBox_AutoCal)
          {
              if( ChBox_AutoCal.isSelected() == true) 
              {
                    SveBlackOffset = Sli_BlackOffsetCam1.getValueI();
                    myPort.write(new byte[] { 0x02,CMD_AUTOCAL_ON,0,0});
                    Sli_BlackOffsetCam1.setLimits(1,1,255);
                    Lbl_BlackOffset.setText("Desired black level");
                    Sli_BlackOffsetCam1.setValue(SveBlackLevel);
                    LbL_BlackOffsetStat.setText(Integer.toString(SveBlackLevel));
                    
              }
              else
              {
                    SveBlackLevel = Sli_BlackOffsetCam1.getValueI();
                    myPort.write(new byte[] { 0x02,CMD_AUTOCAL_OFF,0,0});
                    Sli_BlackOffsetCam1.setLimits(1,1,1023);
                    Lbl_BlackOffset.setText("Black Offset");
                    Sli_BlackOffsetCam1.setValue(SveBlackOffset);
                    LbL_BlackOffsetStat.setText(Integer.toString(SveBlackOffset-512));
              }
          }
          else if(CheckBox == ChBox_AutoCal2)
          {
              if( fSerial2Enabled == true)
              {
                    if( ChBox_AutoCal2.isSelected() == true) 
                    {
                          SveBlackOffset2 = Sli_BlackOffsetCam2.getValueI();
                          myPort2.write(new byte[] { 0x02,CMD_AUTOCAL_ON,0,0});
                          Sli_BlackOffsetCam2.setLimits(1,1,255);
                          Lbl_BlackOffset2.setText("Desired black level");
                          Sli_BlackOffsetCam2.setValue(SveBlackLevel2);
                          LbL_BlackOffsetStat2.setText(Integer.toString(SveBlackLevel2));
                          
                    }
                    else
                    {
                          SveBlackLevel2 = Sli_BlackOffsetCam2.getValueI();
                          myPort2.write(new byte[] { 0x02,CMD_AUTOCAL_OFF,0,0});
                          Sli_BlackOffsetCam2.setLimits(1,1,1023);
                          Lbl_BlackOffset2.setText("Black Offset");
                          Sli_BlackOffsetCam2.setValue(SveBlackOffset2);
                          LbL_BlackOffsetStat2.setText(Integer.toString(SveBlackOffset2-512));
                    }
                    
              }
              else
              {
                    ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope not connected");
                    SetWarning("NINScope not connected");
              }
          }
          else if(CheckBox == Opt_Gain1_Cam2)
          {
            if( fSerial2Enabled == true)
            {
                    myPort2.write(new byte[] { 0x02,CMD_AGAIN,(byte)0x00,(byte)0xE1});
                    int VarSliGainCam2 = Sli_GainCam2.getValueI();
                    if(Opt_Gain2_Cam2.isSelected() == true )
                          VarSliGainCam2 *= 2;
                    LbL_GainStat2.setText(Integer.toString(VarSliGainCam2>>7) + "." + Integer.toString((VarSliGainCam2&0x007F)*100/127)); 
            }
            else
            {
                  ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope not connected");
                  SetWarning("NINScope not connected");
            }
            
          }
          else if(CheckBox == Opt_Gain2_Cam2)
          {
            if( fSerial2Enabled == true)
            {
                  myPort2.write(new byte[] { 0x02,CMD_AGAIN,(byte)0x00,(byte)0xE4});
                  int VarSliGainCam2 = Sli_GainCam2.getValueI();
                  if(Opt_Gain2_Cam2.isSelected() == true )
                        VarSliGainCam2 *= 2;
                  LbL_GainStat2.setText(Integer.toString(VarSliGainCam2>>7) + "." + Integer.toString((VarSliGainCam2&0x007F)*100/127));
            }
            else
            {
                  ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope not connected");
                  SetWarning("NINScope not connected");
            } 
          }
    }
    else
    {
      ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope not connected");
      SetWarning("NINScope not connected");
      if(ChkBox_TriggerInput.isSelected() == true)
            ChkBox_TriggerInput.setSelected(false);
      if(Chkbox_FramesPT.isSelected() == true)
            Chkbox_FramesPT.setSelected(false);            
    }   
}

public void handleButtonEvents(GButton button, GEvent event) {

    if( button == Btn_ConnectScope1)
            BtnAutoConnectScope1();
    else if( button == Btn_ConnectScope2)
            BtnAutoConnectScope2();
    else if( button == Btn_ConnectBehav)
            BtnConnectBehav();
    else if(button == Btn_SnapShotCam1)
            BtnSnapShotCam1();
    else if(button == Btn_SnapShotCam2)
            BtnSnapShotCam2();
    else if(button == Btn_SnapShotBehav)
            Btn_SnapShotBehav();
    else if( button == Btn_Zoom_behave)
            windowZoomBehav.setVisible(true);
    else if( button == Btn_AppendNotes)
            BtnAppendNotes();
    else if( button == Btn_DualHead)
            BtnDualHead();
    else if( button == Btn_Scan)    
            UpdateDropList();
    else if( button == Btn_ConsoleClr)
            ConsoleArea.setText("");
    else if( button == Btn_SaveSettings)
            BtnSaveSettings();
    else if( button == Btn_LoadSettings)
            BtnLoadSettings();        
    else if(  button == Btn_Warning)
              WindowWarning.setVisible(false);
    else if( button == Btn_CentreSLDCam1)
              BtnCentreSLDCam1();
    else if( button == Btn_FineGainCam1_Down)
    {      
            int VarSli_GainCam1 = Sli_GainCam1.getValueI() & 0xFFC0;
            VarSli_GainCam1 -= 64;
            Sli_GainCam1.setValue((float)VarSli_GainCam1);
            Sli_GainCam1.draw();


    }
    else if( button == Btn_FineGainCam1_Up)
    {      
            int VarSli_GainCam1 = Sli_GainCam1.getValueI() & 0xFFC0;
            VarSli_GainCam1 += 64;
            Sli_GainCam1.setValue((float)VarSli_GainCam1);
            Sli_GainCam1.draw();


    } 
    else if( fSerialEnabled == true)
    {    
         if( button == Btn_Record)
            BtnRecord();
         else if( button == Btn_GsensorOn)
            BtnGsensorOn();
         else if( button == Btn_GsensorOff)
            BtnGsensorOff();         
         else if( button == Btn_Stimulate)
            BtnStimulate();
         else if(button == Btn_OKSettings)
            BtnOKSettings();
         else if( button == Btn_Settings) 
            SettingsWnd.setVisible(true);
         else if( button == Btn_TempRead)
            myPort.write(new byte[] { 0x02,CMD_TEMP_RD,0,0});
         else if( button == Btn_TempPyRead)
            myPort.write(new byte[] { 0x02,CMD_PYTEMP_RD,0,0});   
         else if( button == Btn_Zoom_Cam1)
            WindowZoomCam1.setVisible(true);
         else if(  button == Btn_Detect1)
              BtnDetect1();
         else if( button == Btn_CentreSLDCam1)
              BtnCentreSLDCam1();
         else if( button == Btn_CentreSLDCam2)
         {
            if( fSerial2Enabled == true )
            {
              BtnCentreSLDCam2();
            }
            else
            {
              ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope 2 not connected");
              SetWarning("NINScope 2 not connected");
            }
            
         }
         else if( button == Btn_Zoom_Cam2)
         {
            if( fSerial2Enabled == true )
            {
                    WindowZoomCam2.setVisible(true);
            }
            else
            {
              ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope 2 not connected");
              SetWarning("NINScope 2 not connected");
            }
         }
         else if(  button == Btn_Detect2)
         {
            if( fSerial2Enabled == true )
            {
                    BtnDetect2();
            }
            else
            {
              ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope 2 not connected");
              SetWarning("NINScope 2 not connected");
            }
         }
         else if( button == Btn_FineGainCam2_Down)
         {      
             if( fSerial2Enabled == true )
             {
                  int VarSli_GainCam2 = Sli_GainCam2.getValueI() & 0xFFC0;
                  VarSli_GainCam2 -= 64;
                  Sli_GainCam2.setValue((float)VarSli_GainCam2);
                  Sli_GainCam2.draw();
             }
             else
             {
              ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope 2 not connected");
              SetWarning("NINScope 2 not connected");
             }
      
      
         }
         else if( button == Btn_FineGainCam2_Up)
         {      
             if( fSerial2Enabled == true )
             {                  
                  int VarSli_GainCam2 = Sli_GainCam2.getValueI() & 0xFFC0;
                  VarSli_GainCam2 += 64;
                  Sli_GainCam2.setValue((float)VarSli_GainCam2);
                  Sli_GainCam2.draw();
             }
             else
             {
              ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope 2 not connected");
              SetWarning("NINScope 2 not connected");
             }
          } 
    }
    else
    {
      ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope not connected");
      SetWarning("NINScope not connected");
    }        
}

public void handleSlider2DEvents(GSlider2D slider2d, GEvent event) {
  
      if (slider2d == Sld_Cam1 && fSerialEnabled == true)
      {
            myPort.write(new byte[] { 0x02,CMD_ROI,(byte)Sld_Cam1.getValueXI(),(byte)Sld_Cam1.getValueYI()});
      }

      if (slider2d == Sld_Cam2 && fSerial2Enabled == true)
      {
          myPort2.write(new byte[] { 0x02,CMD_ROI,(byte)Sld_Cam2.getValueXI(),(byte)Sld_Cam2.getValueYI()});
      }
}



public void handleSliderEvents(GValueControl slider, GEvent event)
{
    if(slider == Sli_OptoGen)
            SliOptoGen();
    else if( fSerialEnabled == true)
    {
        if(slider == Sli_ExpoCam1)
            SliExpoCam1();
        else if(slider == Sli_ExciCam1)
            SliExciCam1();
        else if(slider == Sli_GainCam1)
            SliGainCam1();
        else if(slider == Sli_BlackOffsetCam1)
            SliBlackOffsetCam1();
        else if( fSerial2Enabled == true)
        {
            if(slider == Sli_ExciCam2)
                SliExciCam2();
            else if(slider == Sli_ExpoCam2)
                SliExpoCam2();
            else if(slider == Sli_GainCam2)
                SliGainCam2();
            else if(slider == Sli_BlackOffsetCam2)
                SliBlackOffsetCam2();
        }
        else 
        {
              ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope 2 not connected");
              SetWarning("NINScope 2 not connected");
        }
    }
    else
    {
      ConsoleArea.appendText( ConsoleLineNumb++ + " NINScope not connected");
      SetWarning("NINScope not connected");
    }
}

public void SliOptoGen ()
{
      int OptoMilliAmps = Sli_OptoGen.getValueI()*11;
      LbLOptoBrightState.setText(OptoMilliAmps + "mA - " +Sli_OptoGen.getValueS()); 
}

public void SliGainCam1()
{
  
  myPort.write(new byte[] { 0x02, CMD_GAIN, (byte)(Sli_GainCam1.getValueI()/256), (byte)(Sli_GainCam1.getValueI())}); 
  
  int VarSliGainCam1 = Sli_GainCam1.getValueI();
  if(Opt_Gain2.isSelected() == true )
    VarSliGainCam1 *= 2;
  LbL_GainStat.setText(Integer.toString(VarSliGainCam1>>7) + "." + Integer.toString((VarSliGainCam1&0x007F)*100/127)); 
}

public void SliGainCam2()
{
        int VarSliGainCam2 = Sli_GainCam2.getValueI();
        myPort2.write(new byte[] { 0x02, CMD_GAIN, (byte)(Sli_GainCam2.getValueI()/256), (byte)(Sli_GainCam2.getValueI())}); 
        if(Opt_Gain2_Cam2.isSelected() == true )
        VarSliGainCam2 *= 2;
        LbL_GainStat2.setText(Integer.toString(VarSliGainCam2>>7) + "." + Integer.toString((VarSliGainCam2&0x007F)*100/127)); 
}

public void SliExpoCam1 ()
{
  myPort.write( new byte[]{ 0x02, CMD_EXPOSURE ,(byte)(Sli_ExpoCam1.getValueI()/256) ,(byte)Sli_ExpoCam1.getValueI()});
  LbL_ExpoStat.setText(String.format ("%.2f", (float)Sli_ExpoCam1.getValueI()*0.0012) + "mS - " + Sli_ExpoCam1.getValueI());
}

public void SliExpoCam2 ()
{
  myPort2.write( new byte[]{ 0x02, CMD_EXPOSURE ,(byte)(Sli_ExpoCam2.getValueI()/256) ,(byte)Sli_ExpoCam2.getValueI()});
  LbL_ExpoStat2.setText(String.format ("%.2f", Sli_ExpoCam2.getValueF()*0.0012) + "mS - " + Sli_ExpoCam2.getValueS());
}

public void SliExciCam1()
{
  myPort.write(new byte[] { 0x02, CMD_EXCITATION,(byte)(Sli_ExciCam1.getValueI()/256),(byte)Sli_ExciCam1.getValueI()});
  
  if(Sli_ExciCam1.getValueI() != 0){
      Float ExciMilliAmps = Sli_ExciCam1.getValueI()*1.4+0.977;
      LbL_ExciStat.setText(String.format ("%.2f", ExciMilliAmps) + "mA - " +Sli_ExciCam1.getValueS()); //1.4 mA) + 0.977
  }
  else{
    LbL_ExciStat.setText("0mA - 0"); 
  }
}

public void SliExciCam2()
{
  myPort2.write(new byte[] { 0x02, CMD_EXCITATION,(byte)(Sli_ExciCam2.getValueI()/256),(byte)Sli_ExciCam2.getValueI()});
  
  if(Sli_ExciCam2.getValueI() != 0){
    Float ExciMilliAmps = Sli_ExciCam2.getValueI()*1.4+0.977;
    LbL_ExciStat2.setText(String.format ("%.2f", ExciMilliAmps) + "mA - " +Sli_ExciCam2.getValueS()); //1.4 mA) + 0.977
  }
  else{
    LbL_ExciStat2.setText("0mA - 0"); 

  }
}

public void SliBlackOffsetCam1()
{
        myPort.write(new byte[] { 0x02, CMD_BLACKOFFSET,(byte)(Sli_BlackOffsetCam1.getValueI()/256),(byte)Sli_BlackOffsetCam1.getValueI()});
        if( ChBox_AutoCal.isSelected() == true) 
        {
            LbL_BlackOffsetStat.setText(Integer.toString(Sli_BlackOffsetCam1.getValueI()));
        }
        else
        {
            LbL_BlackOffsetStat.setText(Integer.toString(Sli_BlackOffsetCam1.getValueI()-512));
        }
}


public void SliBlackOffsetCam2()
{
        myPort2.write(new byte[] { 0x02, CMD_BLACKOFFSET,(byte)(Sli_BlackOffsetCam2.getValueI()/256),(byte)Sli_BlackOffsetCam2.getValueI()});
        if( ChBox_AutoCal2.isSelected() == true) 
        {
            LbL_BlackOffsetStat2.setText(Integer.toString(Sli_BlackOffsetCam2.getValueI()));
        }
        else
        {
            LbL_BlackOffsetStat2.setText(Integer.toString(Sli_BlackOffsetCam2.getValueI()-512));
        }
}

public void BtnCentreSLDCam1()
{
  Sld_Cam1.setValueX((int)7);
  Sld_Cam1.setValueY((int)16);
  //Sld_Cam1.draw();
  
  myPort.write(new byte[] { 0x02,CMD_ROI,(byte)Sld_Cam1.getValueXI(),(byte)Sld_Cam1.getValueYI()});
   
  
}


public void BtnCentreSLDCam2()
{
  Sld_Cam2.setValueX((int)7);
  Sld_Cam2.setValueY((int)16);
  //Sld_Cam1.draw();
  
  myPort2.write(new byte[] { 0x02,CMD_ROI,(byte)Sld_Cam2.getValueXI(),(byte)Sld_Cam2.getValueYI()});
   
  
}


public void BtnOKSettings()
{
      if( ChkBox_TriggerInput.isSelected() == true)
            myPort.write(new byte[] {0x02,CMD_TRIG_ON,0,0 });
      else
            myPort.write(new byte[] {0x02,CMD_TRIG_OFF,0,0});
            
      myPort.write(new byte[] {0x02,
                CMD_SETTINGS,
                (byte)(Integer.parseInt(tf_PulseOn.getText())/256),   // pulswidth On
                (byte)Integer.parseInt(tf_PulseOn.getText()),
                (byte)(Integer.parseInt(tf_PulseOff.getText())/256),     // pulswidth Off
                (byte)Integer.parseInt(tf_PulseOff.getText()),
                (byte)(Integer.parseInt(tf_BurstCnt.getText())/256),
                (byte)Integer.parseInt(tf_BurstCnt.getText()),
                (byte)(Integer.parseInt(tf_Pause.getText())/256),        // Pause mide byte
                (byte)Integer.parseInt(tf_Pause.getText()),              // Pause Low byte
                (byte)(Integer.parseInt(tf_LoopCnt.getText())/256),      // LoopCnt
                (byte)Integer.parseInt(tf_LoopCnt.getText()),
                (byte)Sli_OptoGen.getValueI(),
                (byte)(Integer.parseInt(tf_StrDelay.getText())/256),     // StartDelay
                (byte)Integer.parseInt(tf_StrDelay.getText()),
                (byte)(Integer.parseInt(tf_FramesPT.getText())/256),     // StartDelay
                (byte)Integer.parseInt(tf_FramesPT.getText()),
                (byte)(Integer.parseInt(tf_Pause.getText())/65536)        // Pause high byte : at the end version conflicts
        });
        ConsoleArea.appendText( ConsoleLineNumb++ + " Settings Update");
        println( (Integer.parseInt(tf_PulseOn.getText())/256),   // pulswidth On
                (byte)Integer.parseInt(tf_PulseOn.getText()),
                (byte)(Integer.parseInt(tf_PulseOff.getText())/256),     // pulswidth Off
                (byte)Integer.parseInt(tf_PulseOff.getText()),
                (byte)(Integer.parseInt(tf_BurstCnt.getText())/256),
                (byte)Integer.parseInt(tf_BurstCnt.getText()),
               (Integer.parseInt(tf_Pause.getText())/256),        // Pause mid byte
                Integer.parseInt(tf_Pause.getText()),              // Pause Low byte
                (byte)(Integer.parseInt(tf_LoopCnt.getText())/256),      // LoopCnt
                (byte)Integer.parseInt(tf_LoopCnt.getText()),
                (byte)Sli_OptoGen.getValueI(),
                (byte)(Integer.parseInt(tf_StrDelay.getText())/256),     // StartDelay
                (byte)Integer.parseInt(tf_StrDelay.getText()),
                (byte)(Integer.parseInt(tf_FramesPT.getText())/256),     // StartDelay
                (byte)Integer.parseInt(tf_FramesPT.getText()),
             (Integer.parseInt(tf_Pause.getText())/65536) );       // Pause high byte : at the end version conflicts
        SettingsWnd.setVisible(false);
}

public void BtnDualHead()
{
   surface.setResizable(true);
   if( Btn_DualHead.getText() == "Single Cam"){
     Btn_DualHead.setText("Dual Cam");
     surface.setSize(745,855);  
   }
   else{
     Btn_DualHead.setText("Single Cam");
     surface.setSize(1140, 855 );
   }
}

public void BtnAppendNotes()
{
  if(fRecord)
  {
       String [] TextArray = NoteArea.getTextAsArray();
       PWriteNotes.println("");
       PWriteNotes.println("Note at Frame :" + CamRecordCnt);
       
       for(int LineCnt = 0;LineCnt < TextArray.length;LineCnt++)
           PWriteNotes.println(NoteArea.getText(LineCnt));
           
       NoteArea.setText("");
       
  }
  else
  {
      ConsoleArea.appendText(ConsoleLineNumb++ + " Start recording to append notes.");
  }  
}

public void BtnStimulate()
{
 
        myPort.write(new byte[] { 0x02, CMD_STIMULATE,0,0});
        ConsoleArea.appendText("Optogenetics stimulation start");
        if(fRecord == true)
        {
          PWriteNotes.println("");
          PWriteNotes.println("Frame:" + CamRecordCnt);
          PWriteNotes.println("optogenetics stimulation start");
        }
}

public void BtnSnapShotCam1()
{
  if( fCamEnabled )
  {
    Calendar ScopeCal = Calendar.getInstance();
    SimpleDateFormat TimeNow = new SimpleDateFormat("HH_mm_ss");
    String TimeStr = TimeNow.format(ScopeCal.getTime());//.replace(":", "_");
    SimpleDateFormat DateNow = new SimpleDateFormat("yyyyMMdd");
    String DateStr = DateNow.format(ScopeCal.getTime());
    cam.save("./" + DateStr + "/SnapShots/" + TimeStr + "_Scope1Snap_" + SnapCnt + ".tiff");
    SnapCnt++;
  }
  else
  {
      ConsoleArea.appendText(ConsoleLineNumb++ + " NINScope 1 not connected");
      SetWarning("NINScope 1 not connected");
  }
  
}

public void BtnSnapShotCam2()
{
    if( fCam2Enabled )
  {
    Calendar ScopeCal = Calendar.getInstance();
    SimpleDateFormat TimeNow = new SimpleDateFormat("HH_mm_ss");
    String TimeStr = TimeNow.format(ScopeCal.getTime());//.replace(":", "_");
    SimpleDateFormat DateNow = new SimpleDateFormat("yyyyMMdd");
    String DateStr = DateNow.format(ScopeCal.getTime());
    cam2.save("./" + DateStr + "/SnapShots/" + TimeStr + "_Scope2Snap_" + SnapCnt2 + ".tiff");
    SnapCnt2++;
  }
  else
  {
      ConsoleArea.appendText(ConsoleLineNumb++ + " NINScope 2 not connected");
      SetWarning("NINScope 2 not connected");
  }
}

public void Btn_SnapShotBehav()
{
  if( fBehavCamEnabled )
  {
    Calendar ScopeCal = Calendar.getInstance();
    SimpleDateFormat TimeNow = new SimpleDateFormat("HH_mm_ss");
    String TimeStr = TimeNow.format(ScopeCal.getTime());//.replace(":", "_");
    SimpleDateFormat DateNow = new SimpleDateFormat("yyyyMMdd");
    String DateStr = DateNow.format(ScopeCal.getTime());
    BehavCam.save("./" + DateStr + "/SnapShots/" + TimeStr + "_BehavSnap_" + SnapCnt3 + ".tiff");
    SnapCnt3++;
  }
  else
  {
      ConsoleArea.appendText(ConsoleLineNumb++ + " Behaviour Cam not connected");
      SetWarning("Behaviour Cam not connected");
  }
}


public void BtnAutoConnectScope1()
{
  if(fCamEnabled == false)
  {
    try
    {
      myPort = new Serial(this, SerialList.getSelectedText(), 2000000);
    }
    catch(Exception e)
    {
      println(e);
    }
    if(myPort != null)
    {
        myPort.write( new byte[]{0x02,CMD_GSENSOR_OFF,0,0x02});     // turn off G-sensor in case it was on.
        delay(100);
        myPort.write( new byte[]{0x02,CMD_PAIR_CAM_ON,0,0x02});     // turn off G-sensor in case it was on.
        PairCam = 1;
        camIndex = 0;
    }
    else
    {
        ConsoleArea.appendText("Cannot Connect Port");
        SetWarning("Cannot Connect Port");
    }        
  }
  else
  {
    
    myPort.write(new byte[] {0x02,CMD_GSENSOR_OFF,0,0x02});      // Gsensor Off
    Btn_Record.setVisible(true);
    ChkBox_TriggerInput.setSelected(false);
    myPort.write(new byte[] {0x02,CMD_SETTINGS,CMD_TRIG_OFF,0,0});
    
    myPort.write(new byte[] { 0x02, CMD_EXCITATION,0,0});
    LbL_ExciStat.setText("0mA - 0"); 
    
    LbL_NINscopeSelcted.setText("---");
    
    delay(200);
    
    cam.stop();
    myPort.clear();
    myPort.stop();
    myPort = null;
    fCamEnabled = false;
    fSerialEnabled = false;
    Btn_ConnectScope1.setText("Connect");
    Btn_Record.setVisible(true);
    ChkBox_TriggerInput.setSelected(false);
    Sli_ExciCam1.setValue(0);
    
    surface.setTitle("NINScope v" + MAJOR + "." + MINOR );
  }
}  

public void BtnAutoConnectScope2()
{
  if(fCam2Enabled == false)
  {
    try
    {
      myPort2 = new Serial(this, SerialPort2List.getSelectedText(), 2000000);
    }
    catch(Exception e)
    {
      println(e);
    }
    if(myPort2 != null)
    {
        myPort2.write( new byte[]{0x02,CMD_GSENSOR_OFF,0,0x02});     // turn off G-sensor in case it was on.
        delay(100);
        myPort2.write( new byte[]{0x02,CMD_PAIR_CAM_ON,0,0x02});     // turn off G-sensor in case it was on.
        PairCam2 = 1;
        camIndex2 = 0;
    }
    else
    {
        ConsoleArea.appendText("Cannot Connect Port");
        SetWarning("Cannot Connect Port");
    }        
  }
  else
  {
    myPort2.write(new byte[] { 0x02, CMD_EXCITATION,0,0});
    LbL_ExciStat2.setText("0mA - 0"); 
    Sli_ExciCam2.setValue(0);
    
    LbL_NINscope2Selected.setText("---");
     
    delay(200);
    
    Btn_ConnectScope2.setText("Connect");
    cam2.stop();
    fCam2Enabled = false;
    myPort2.clear();
    myPort2.stop();
    myPort2 = null;
    fSerial2Enabled = false;
  }
}  

public void BtnDetect1()
{
  int Blink = 5;
  while(Blink>0)
  {
    myPort.write( new byte[]{0x02,CMD_DETECT_ON,0,0x02});
    delay(100);
    myPort.write( new byte[]{0x02,CMD_DETECT_OFF,0,0x02});
    delay(100);
    Blink--;
  }
}

public void BtnDetect2()
{
  int Blink = 5;
  while(Blink>0)
  {
    myPort2.write( new byte[]{0x02,CMD_DETECT_ON,0,0x02});
    delay(100);
    myPort2.write( new byte[]{0x02,CMD_DETECT_OFF,0,0x02});
    delay(100);
    Blink--;
  }
  
}

public void BtnConnectBehav ()
{
  if(fBehavCamEnabled == false)
  {
    Btn_ConnectBehav.setText("Disconnect");
    if(Drpl_BehaveFormat.getSelectedIndex() == 0)
    {
          BehavFormat = 0;
          BehavCam = new Capture(this,640,480, BehavList1.getSelectedText());
    }
    else
    {
          BehavFormat = 1;
          BehavCam = new Capture(this,320,240, BehavList1.getSelectedText());
    }
    BehavCam.start();
    fBehavCamEnabled = true;
  }
  else
  {
    Btn_ConnectBehav.setText("Connect");
    BehavCam.stop();
    fBehavCamEnabled = false;
  }
}


public void BtnRecord ()
{
  if(fRecord == false)
  {
        if( fCamEnabled )
        {
          RecCntScp1 = 0;
          RecCntScp2 = 0;
          RecCntBehav = 0;
          DropScp1 = 0;
          DropScp2 = 0;
          RecStartTime = millis();

          Calendar ScopeCal = Calendar.getInstance();
          SimpleDateFormat TimeNow = new SimpleDateFormat("HH_mm_ss");
          String TimeStr = TimeNow.format(ScopeCal.getTime());//.replace(":", "_");
          SimpleDateFormat DateNow = new SimpleDateFormat("yyyyMMdd");
          String DateStr = DateNow.format(ScopeCal.getTime());
          FilePrefix = "./" + DateStr + "/Rec_" + TimeStr;
          PWriteLogData = createWriter(FilePrefix + "/LogData" + ".csv"); 
          PWriteLogData.println("FRAME,SAMPLE,X,Y,Z,OPTO ACTIVE");
          PWriteNotes = createWriter(FilePrefix + "/Notes" + ".txt"); 
          SaveSettings();
          PWriteTimeStFile = createWriter(FilePrefix + "/TimeStamp" + ".csv"); 
          PWriteTimeStFile.println("CAM,FRAME,TIME(ms)");
          myPort.write(new byte[]{0x02,CMD_START_RECORD,0,0x02});
          
          if(OG_OptoAuto.isSelected() == true) 
              myPort.write(new byte[]{0x02,CMD_STIMULATE,0,0x02});
          
          if( fCam2Enabled ){
                myPort2.write(new byte[]{0x02,CMD_START_RECORD,0,0x02});
          }  
          
          FixedRecCnt = Integer.parseInt(tf_RecFrmeCnt.getText());
          
          fRecord = true;
          fStartRecord  = false;
          fStartRecord2 = false;    
          Btn_Record.setText("Stop");
        }
  }
  else
  {
      myPort.write(new byte[]{0x02,CMD_STOP_RECORD,0,0x02});
      
      if( fCam2Enabled ){
                myPort2.write(new byte[]{0x02,CMD_STOP_RECORD,0,0x02});
      }  

      //wait till pointers are equal
      while( TimeStpC1write != TimeStpC1read )
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
}


public void BtnGsensorOn ()
{
    myPort.write(new byte[] {0x02,CMD_GSENSOR_ON,1,0x02});//  data);
    if (myPort.available() > 1) {
              myPort.clear();
    }
}

public void BtnGsensorOff ()
{
   myPort.write(new byte[] {0x02,CMD_GSENSOR_OFF,0,0x02});//  data);
}
