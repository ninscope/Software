
public int ScaleAndLimit ( int ValScaleLim )
{
        ValScaleLim /= 210;
        ValScaleLim += 105;
        if(ValScaleLim < 0 )
            ValScaleLim = 0;
        if(ValScaleLim > 210)
            ValScaleLim = 210;
         return ValScaleLim;
}

public void GraphGsens ( int GsensX , int GsensY, int GsensZ )
{
        GsensX = ScaleAndLimit( GsensX );
        GsensY = ScaleAndLimit( GsensY );
        GsensZ = ScaleAndLimit( GsensZ );      
            
        GSensPanel.beginDraw();
        GSensPanel.copy(0, 0, 320,210, 1, 0, 320,210);    
        GSensPanel.stroke(54);
        GSensPanel.line(0,0,0,320);
        
        GSensPanel.stroke(255,0,0);
        GSensPanel.line(1,SveGsensX,1,GsensX);
        GSensPanel.stroke(0,255,0);
        GSensPanel.line(1,SveGsensY,1,GsensY);
        GSensPanel.stroke(0,0,255);
        GSensPanel.line(1,SveGsensZ,1,GsensZ);
        GSensPanel.endDraw();
        
        SveGsensX = GsensX;
        SveGsensY = GsensY;
        SveGsensZ = GsensZ;
}


public void ProcessData ( String Data )
{

  int GX = 0;
  int GY = 0;
  int GZ = 0;
  
  if( fRecord && fStartRecord )
      PWriteLogData.println(Data);
  //println(Data);
  Data = Data.substring(0,Data.length()-1);    
  Scanner Scan = new Scanner(Data.replace(',',' '));
  if( Scan.hasNextInt() )
        Scan.nextInt();
  if( Scan.hasNextInt() )
        Scan.nextInt();
  if( Scan.hasNextInt())
      GX = Scan.nextInt();
  if( Scan.hasNextInt())
      GY = Scan.nextInt();
  if( Scan.hasNextInt())
      GZ = Scan.nextInt();
      
  GraphGsens( GX , GY , GZ );
  Scan.close();
}

public void ProcessTemperature ( String StrTemperature )
{
          Temperature = Integer.parseInt(StrTemperature);
          fTempUpdate = true;
          print(StrTemperature);
}

public void ProcessPyTemperature ( String StrTemperature )
{
          TemperaturePy = Integer.parseInt(StrTemperature);
          fTempUpdatePy = true;
          print(StrTemperature);
}



public void TrigRecordingStr()
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
          
          fRecord = true;
          fStartRecord  = false;
          fStartRecord2 = false;    
          Btn_Record.setText("Stop");
        }
}

public void TrigRecordingStop()
{
      myPort.write(new byte[]{0x02,CMD_STOP_RECORD,0,0x02});
    
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



public void serialEvent(Serial myPort) 
{
  String read = myPort.readStringUntil(0x0A);
  if( read != null)
  {
    char SerialCmd = read.charAt(0);
    if(SerialCmd == 'D')    //Data Package
    {
            ProcessData( read.substring(1,read.length()-1));
    } 
    else if(SerialCmd == 'T')    //Temperature Package
    {
            ProcessTemperature( read.substring(1,read.length()-2));
    }
    else if(SerialCmd == 'R')    //Start Recording
    {
        println("Start Recording");
        TrigRecordingStr();
    }
    else if(SerialCmd == 'S')    //Stop Recording
    {
        println("Stop Recording.");
        TrigRecordingStop();
    }
    else if(SerialCmd == 'P')    //Temperature Package from Python480
    {
          ProcessPyTemperature( read.substring(1,read.length()-2));
    }
    else if( SerialCmd == 'V')
    {
      VersionCAM1 = read.substring(1,read.length()-1);
      surface.setTitle("NINScope v" + MAJOR + "." + MINOR + " Cam FW v" + VersionCAM1  );
    }
  }
}
