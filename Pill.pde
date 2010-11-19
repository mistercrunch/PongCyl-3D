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
//NOT IMPLEMENTED YET
//The idea here is to spawn pills that drop randomly ala Arkanoid. Say a green one splits the ball into three, a blue one
//reduces the size of your paddle, a black one accelerate the ball, ...
class Pill
{
  Vect3d Pos,Speed;
  int PillType;
  color bgC;
  float Size;
  
  Pill()
  {
    Pos = new Vect3d(0,0,0);
    bgC = color(1,1,1);
    Speed = new Vect3d(0,0,1);
    Size=3;
  }
  
  void Move()
  {
    Pos.Add(Speed);
  }
  
  void Draw()
  {
    pushMatrix();
      translate(0,0,Pos.z);
      fill(bgC);
      noStroke();
      ellipse(Pos.x, Pos.y, Size/2, Size);
      fill(0);
      text("P",Pos.x, Pos.y,0.5);
    popMatrix();
  }
  
}

class Pills
{
  //Collection of Pill
  LinkedList llPills;
  PFont daFont;
  
  Pills()
  {
    //daFont = loadFont("Verdana-10.vlw");
    llPills = new LinkedList();
  }
  
  void Add()
  {
    Pill b = new Pill();
    llPills.add(b);
  }
  
  void Move()
  {
      Iterator it = llPills.listIterator(); 
      while ( it.hasNext() ) 
      {
        Pill b = (Pill)it.next();
        b.Move();
        //if(b.Age>b.LifeDuration)it.remove();
      }
  }
  
  void Draw()
  {
      Iterator it = llPills.listIterator(); 
      while ( it.hasNext() ) 
      {
        Pill b = (Pill)it.next();
        b.Draw();
      }
  }
};



