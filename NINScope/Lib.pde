

class ROIAvg
{
   int x1 = 0,y1 = 0,x2 = 10 ,y2 = 10;
   PGraphics AvgGraph;
   int Avg = 0,SveAvg = 0;
   int AvgRAW = 0;
   PApplet appcROIAvg;
   
   ROIAvg(PApplet appcRoisAvgSet)
   {
     AvgGraph = createGraphics(255,70);
     AvgGraph.beginDraw();
     AvgGraph.background(0);
     appcROIAvg = appcRoisAvgSet;
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
     if(setx1 < 752 && sety1 < 480)
     {
           x1 = setx1;
           y1 = sety1;
           x2 = 1;
           y2 = 1;
     }
   }
   
   void SetEndRect(int setx2, int sety2 )
   { 
     if(setx2 < 752 && sety2 < 480)
     {
         if(setx2 > x1)
             x2 = setx2 -x1;
         if(sety2 > y1)
             y2 = sety2 - y1;
     }
   }
   
   int ROIGetX1()
   {  return x1;
   }
   int ROIGetY1()
   {  return y1;
   }
   int ROIGetX2()
   {  return x2;
   }
   int ROIGetY2()
   {  return y2;
   }
   
   void ROIGraph( PImage  SrcImg , int ROIGraphX ,int ROIGraphY)
   {
       int PixlCnt = 0;
       // Pixel start location in array
       int PixLoca = y1 * SrcImg.width + x1;
       Avg = 0;
       
       for (int j = 0   ; j < y2 ;j++)
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
       Avg /= 5; //Scale to 5 pixels
       Avg = 50 - Avg; //Flip image
            
       AvgGraph.beginDraw();
       AvgGraph.copy(0, 0, 255,50,1, 0, 255,50);    
       AvgGraph.stroke(0);
       AvgGraph.line(0,0,0,320);
       AvgGraph.stroke(150,150,0);
       AvgGraph.line(1,SveAvg,1,Avg);
       AvgGraph.fill(0);
       AvgGraph.stroke(0);
       AvgGraph.rect(0,50,30,20);
       AvgGraph.fill(255);
       //AvgGraph.stroke(255);
       //AvgGraph.text(AvgRAW,2,65);
       AvgGraph.endDraw();
      
      SveAvg = Avg;
      appcROIAvg.image(AvgGraph , ROIGraphX , ROIGraphY );
      
      appcROIAvg.fill(0,0,0,0);
      appcROIAvg.stroke(150,150,0);
      appcROIAvg.rect(x1,y1,x2,y2);
   }
   
   int GetAvg( )
   {
      return AvgRAW; 
   }
}
