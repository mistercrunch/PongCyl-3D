/*
    Copyright 2010 Maxime Beauchemin/

    This file is part of PongCyl3D.

    PongCyl3D is free software: you can redistribute it and/or modify it under the terms of the GNU General 
    Public License as published by the Free Software Foundation, either version 3 of the License, or 
    (at your option) any later version.

    PongCyl3D is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the 
    implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
    You should have received a copy of the GNU General Public License along with PongCyl3D. If not, see http://www.gnu.org/licenses/.
*/
//Class to store data about the tube
class Tube
{
  private int nbLines;
  private float NB_CIRCLES;
  Tube()
  {
    nbLines = 48;
    NB_CIRCLES=24;
    gl.DrawQuads((int)(nbLines* (1+NB_CIRCLES)));
    GenerateVertexArray();  
    
  }
  void UpdateColors()
  {
    gl.cSquareBuffer.clear();
    //pushMatrix();    
    
    float x1,x2,y1,y2,z1,z2;
  
    float CircleZDistance = (float)TUBE_LENGTH / (float)NB_CIRCLES;
      for(int cptCircle=0; cptCircle<NB_CIRCLES;cptCircle++)
      {
        z1=((float)cptCircle*CircleZDistance) - TUBE_LENGTH/2;
        z2=z1 + CircleZDistance;
        
        for(int cptQuad=0; cptQuad<nbLines;cptQuad++)
        {
 
          color c;
          
          float h=(((float)cptCircle/NB_CIRCLES) + ((float)cptQuad/nbLines) + ((float)millis()/5000) ) % 1;
          float s=1;
          float b= ((float)cptCircle/NB_CIRCLES)+0.2;
          
          if((cptQuad+cptCircle)%2==1)
            c = color(h,s,b);
          else
            c = color((h+0.5)%1,s,b);
          gl.SetColor(c);
        }
        
      }
      float x3,y3,x4,y4;
        for(int cptQuad=0; cptQuad<nbLines;cptQuad++)
        {
          color c = color(0.1);
   
          float h=(((float)(NB_CIRCLES-1)/NB_CIRCLES) + ((float)cptQuad/nbLines) + ((float)millis()/5000) ) % 1;float s=1;
          float b=0.5;
          if((cptQuad+(NB_CIRCLES-1))%2==1)
            c = color(h,s,b);
          else
            c = color((h+0.5)%1,s,b);
                 
          float z=(float)TUBE_LENGTH/2;  
          gl.SetColor(c);
        }
      
  }
  void GenerateVertexArray()
  {

    //gl.DrawQuads((int)(nbLines* (1+NB_CIRCLES)));
    float x1,x2,y1,y2,z1,z2;
  
    float CircleZDistance = (float)TUBE_LENGTH / (float)NB_CIRCLES;
      for(int cptCircle=0; cptCircle<NB_CIRCLES;cptCircle++)
      {
        z1=((float)cptCircle*CircleZDistance) - TUBE_LENGTH/2;
        z2=z1 + CircleZDistance;
        
        for(int cptQuad=0; cptQuad<nbLines;cptQuad++)
        {
          //println(cptCircle+":"+ cptQuad);
          x1 = sin(((float)cptQuad/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          y1 = cos(((float)cptQuad/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          x2 = sin(((float)(cptQuad+1)/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          y2 = cos(((float)(cptQuad+1)/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          
          gl.AddSquare(x1,x2,y1,y2,z1,z2);
        }
        
      }
      float x3,y3,x4,y4;
        for(int cptQuad=0; cptQuad<nbLines;cptQuad++)
        {
          //println(cptCircle+":"+ cptQuad);
          x1 = sin(((float)cptQuad/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          y1 = cos(((float)cptQuad/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          x2 = sin(((float)(cptQuad+1)/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          y2 = cos(((float)(cptQuad+1)/(float)nbLines) * TWO_PI) * CIRCLE_RAY;
          x3 = sin(((float)cptQuad/(float)nbLines) * TWO_PI) * (CIRCLE_RAY+5);
          y3 = cos(((float)cptQuad/(float)nbLines) * TWO_PI) * (CIRCLE_RAY+5);
          x4 = sin(((float)(cptQuad+1)/(float)nbLines) * TWO_PI) * (CIRCLE_RAY+5);
          y4 = cos(((float)(cptQuad+1)/(float)nbLines) * TWO_PI) * (CIRCLE_RAY+5);
                 
          float z=(float)TUBE_LENGTH/2;  
          gl.AddQuad(new Vect3d(x3,y3,z), new Vect3d(x1,y1,z) , new Vect3d(x2,y2,z), new Vect3d(x4,y4,z));
        }
  }
};

