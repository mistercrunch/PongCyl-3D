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
//Class to store paddle info/methods
class Paddle
{
  Vect3d Pos, LastPos;
  MyFloat Diam;
  color bgC;
  boolean isAI;
  boolean isFront;
  Paddle(boolean _isAI, boolean _isFront)
  {
    isFront = _isFront;
    isAI = _isAI;
    bgC=color(1,0.1);
    Diam=PaddleDiameter;
    Pos = new Vect3d();
    
    if(isFront)Pos.z = TUBE_LENGTH/2;
    else Pos.z = -TUBE_LENGTH/2;
  }
  void Move()
  {
    if(!isAI)
    {
      Pos.x = map(mouseX,0,width, -CIRCLE_RAY, CIRCLE_RAY);
      Pos.y = map(mouseY,0,height, CIRCLE_RAY, -CIRCLE_RAY);  
    }
    else
    {
      Pos.x = daBall.Pos.x;
      Pos.y = daBall.Pos.y;
    }
    //LastPos = Pos.Clone();
    
  }
  void Draw()
  {
    pushMatrix();
      colorMode(HSB,1);  
      //fill(bgC);
      noFill();
      stroke(1);
      translate(Pos.x,-Pos.y,Pos.z);
      gl.renderPaddle(new Vect3d(), Diam.value, 0.5);
      //ellipse(Pos.x, -Pos.y, Diam.value,Diam.value);
      
      LastPos = Pos.Clone();
    popMatrix();
  }
};
