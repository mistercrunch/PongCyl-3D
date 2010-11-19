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
//This class is for the ball
class Ball
{
  Vect3d Pos, Speed, Effect;
  float BallSize = 5;
  color c;
  
  Ball()
  {
    c = color(0.66,1,1,1);
    Effect = new Vect3d();
    Pos = new Vect3d(random(CIRCLE_RAY/2), random(CIRCLE_RAY/2),random(CIRCLE_RAY/2));
    Speed = new Vect3d(0,0,4);
  }
  
  void Move()
  { 
    Speed.Add(Effect);
    Vect3d tmp = Speed.Clone();
    tmp.Multiply(zSpeedMultiplier.value);
    Pos.Add(tmp);
    if(Pos.z < -TUBE_LENGTH/2)
    {  
      //Other side
      //Effect = new Vect3d();
      Speed.z=-Speed.z;
      
      daBounces.Add(Pos);
      if(!MUTED)daSound.Pong();
    }
    else if(Pos.z > TUBE_LENGTH/2)
    {
      if(daPaddle1.Pos.DistanceXY(Pos) < ((daPaddle1.Diam.value/2)+(BallSize/2)))
      {
        //Paddle hits
        Speed.z=-Speed.z;
        
        daBounces.Add(Pos, color(1,1,1), 50);
        if(!MUTED)daSound.Ping();        
        Effect = new Vect3d();
        Effect.x = (daPaddle1.LastPos.x - daPaddle1.Pos.x) * (EffectMultiplier.value/1000);
        Effect.y = (daPaddle1.LastPos.y - daPaddle1.Pos.y) * (EffectMultiplier.value/1000);
        
      }
      else
      {
        //Miss!
        Effect = new Vect3d();
        background(1,1,1);
        Speed.z=-Speed.z;
        
        daBounces.Add(Pos, color(1,1,1), 50);
        daDelay=300;
        
      }
    }
    float PosDistanceXY = Pos.DistanceXY() ;
    if(PosDistanceXY > CIRCLE_RAY - (BallSize/2))
    {
      //Tunnel bounce
      daBounces.Add(Pos, color(1), 10);
      float angle1  =  atan2(Speed.y, Speed.x);
      float angle2  =  -atan2(Pos.y, Pos.x);
      float baseAngle = atan2(Speed.x, Speed.y);
      float Distance = Speed.DistanceXY();
      float newAngle = PI + baseAngle + ((angle2+angle1) * 2);
      
      
      float OutsideRatio =PosDistanceXY/((float)CIRCLE_RAY - ((float)BallSize/2)) ;
      Pos.x/=OutsideRatio;
      Pos.x/=OutsideRatio;

      Speed.x= sin(newAngle) * Distance;
      Speed.y= cos(newAngle) * Distance;
    }  
  }
  
  void Draw()
  {
    pushMatrix();  
      noStroke();
      fill(c);
      translate(Pos.x,-Pos.y,Pos.z);
      //ellipse(Pos.x,-Pos.y, BallSize,BallSize);
      float h = millis();
      gl.renderBall(Pos, BallSize, color(h,1,1));
    
      
    popMatrix();
    
    pushMatrix();
      noFill();
      stroke(c);
      strokeWeight(3);
      translate(0,0,Pos.z);
      ellipse(0,0, CIRCLE_DIAM,CIRCLE_DIAM);

    popMatrix();
  }
};
