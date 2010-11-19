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
//This class is to animate ripples type of effects where the ball bounced previously
class Bounce
{
  Vect3d Pos;
  int Age;
  int LifeDuration;
  color c;
  
  Bounce(Vect3d v3d)
  {
     this(v3d,color(1), 25);
     
     
  }
  
  Bounce(Vect3d v3d, color inC, int inLifeDuration )
  {
    Pos = v3d.Clone();
    LifeDuration = inLifeDuration;
    c = inC;
     
  }
  
  
  void Move()
  {
    Age++;
  }
  
  void Draw()
  {
    pushMatrix();
      noFill();
      stroke(1, (float)(LifeDuration-Age)/(float)LifeDuration);
      //stroke(1);
      strokeWeight(1);
      translate(0,0,Pos.z);
      float fAge = Age;
      ellipse(Pos.x, -Pos.y, fAge/2, fAge/2);
      ellipse(Pos.x, -Pos.y, fAge/4, fAge/4);
      ellipse(Pos.x, -Pos.y, fAge/16, fAge/16);
    popMatrix();
  }
};

class Bounces
{
  //Collection of Bounce
  LinkedList llBounces;
  
  Bounces()
  {
    llBounces = new LinkedList();
  }
  
  void Add(Vect3d v3d)
  {
    Bounce b = new Bounce(v3d);
    llBounces.add(b);
  }
  void Add(Vect3d v3d, color c, int LifeDuration)
  {
    Bounce b = new Bounce(v3d,c, LifeDuration);
    llBounces.add(b);
  }
  
  void Move()
  {
      Iterator it = llBounces.listIterator(); 
      while ( it.hasNext() ) 
      {
        Bounce b = (Bounce)it.next();
        b.Move();
        if(b.Age>b.LifeDuration)it.remove();
      }
  }
  
  void Draw()
  {
      Iterator it = llBounces.listIterator(); 
      while ( it.hasNext() ) 
      {
        Bounce b = (Bounce)it.next();
        b.Draw();
      }
  }
};



