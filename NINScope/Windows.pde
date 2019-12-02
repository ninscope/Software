
public void WindowWarningDraw(PApplet appc, GWinData data) { 
      if(WindowWarning.isVisible() == true)
      {
         appc.frameRate(30);
         appc.background(255,0,0);
         appc.fill(54);
         appc.rect(10,10, 300, 100); 
        
      }
      else
      {
        appc.frameRate(3);
      }
}

public void winOptoDraw(PApplet appc, GWinData data) { 
   if(SettingsWnd.isVisible() == true)
   {
      appc.frameRate(30);
      appc.background(54);
      appc.stroke(80);
      appc.rect(20,210,420,1); // line between OptoGen settings and Trigger settings
      appc.rect(20,320,420,1); // line between Trigger settings and Temperature 
      appc.rect(20,410,420,1); // 
      appc.rect(20,503,420,1); // 
   }
   else
   {
     appc.frameRate(3);
   }
}


public void WindZmCam1draw(PApplet appc, GWinData data ) { 

        if(WindowZoomCam1.isVisible() == true)
        {
          appc.background(54);
          appc.frameRate(30);
          if( fCamEnabled )
          {
            appc.image(cam, 0,0);
            if(Chk_HistoCam1.isSelected() == true)
                appc.image(Histogram(cam),10,520);

            if( (byte)cam.pixels[360955] == (byte)0xFF)
            {
                appc.stroke(255);
                appc.fill(255);
                appc.rect(0,460,752,20);
                
            }
                
            if(Chk_ROIAvgCam1.isSelected() == true)
            {
               ROI1.SetActive(true);
               ROI1.ROIGraph(cam);   
            }
            else
            {
              ROI1.SetActive(false);
            }
                

          }
          

        }  
        else
        {
             appc.frameRate(30);
        }

} 

public void WndZmCam1Mouse(PApplet appc, GWinData data, MouseEvent mevent) 
{ 

          if(mevent.getAction() == MouseEvent.PRESS)
          {
              ROI1.SetStartRect(appc.mouseX,appc.mouseY);
          }

          if(mevent.getAction() == MouseEvent.DRAG)
          {
            ROI1.SetEndRect(appc.mouseX,appc.mouseY);
          }
  
}

public void WindZmBehavdraw(PApplet appc, GWinData data) { 
  
  if(windowZoomBehav.isVisible() == true)
  {
          appc.background(54);
          appc.frameRate(30);
          if( fBehavCamEnabled) {
            appc.image(BehavCam,0,0,640,480);
          }
          
  }
  else
  {
       appc.frameRate(3);
  }
} 

public void WindZmCam2draw(PApplet appc, GWinData data) { 
  
  if(WindowZoomCam2.isVisible() == true)
  {
          appc.background(54);
          appc.frameRate(30);
          if( fCam2Enabled) 
          {
            appc.image(cam2,0,0);
          
            if(Chk_HistoCam2.isSelected() == true)
                  appc.image(Histogram(cam2),10,520);
            if(Chk_ROIAvgCam2.isSelected() == true)
            {
               ROI2.SetActive(true);
               ROI2.ROIGraph(cam2);  
            }
            else
            {
               ROI2.SetActive(false);
            }
          }
  }
  else
  {
       appc.frameRate(3);
  }

} 

public void WndZmCam2Mouse(PApplet appc, GWinData data, MouseEvent mevent) 
{ 

          if(mevent.getAction() == MouseEvent.PRESS)
          {
              ROI2.SetStartRect(appc.mouseX,appc.mouseY);
          }

          if(mevent.getAction() == MouseEvent.DRAG)
          {
            ROI2.SetEndRect(appc.mouseX,appc.mouseY);
          }
  
}
