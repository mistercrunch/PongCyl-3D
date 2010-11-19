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
/*
Like the good old pong, but in 3d in a tunnel!
Ideas/Todo:
* Add sounds
* Mixing some Arkanoid concepts
  *"Pill" class
*/
import processing.opengl.*;
import javax.media.opengl.*;
import com.sun.opengl.util.texture.*;

float CIRCLE_DIAM=100;
float TUBE_LENGTH=200;

MyFloat PaddleDiameter = new MyFloat(25);
MyFloat EffectMultiplier = new MyFloat(10);
MyFloat zSpeedMultiplier = new MyFloat(1);
MyFloat PerspectiveShift = new MyFloat(50);


OpenGLAbstraction gl;
VariableMenu Menu;

Ball daBall;
Paddle daPaddle1 = new Paddle(false, true);
Paddle daPaddle2 = new Paddle(true, false);
Bounces daBounces = new Bounces();
Pills daPills = new Pills();

Sound daSound;

boolean PAUSED = false;
boolean MUTED = true;

Tube daTube;

Vect3d CamFrom = new Vect3d(0,0,200);
Vect3d CamTo = new Vect3d(0,0,-200);

float CIRCLE_RAY=CIRCLE_DIAM/2;
int daDelay=0;
void setup()
{
  
  
  colorMode(HSB,1);
  size(700,700, OPENGL);
  gl = new OpenGLAbstraction();
  Menu = new VariableMenu(-20,-20, 1+(int)TUBE_LENGTH/2, 40, 40, 2.5);
  Menu.AddItem("PaddleDiameter:", 1, PaddleDiameter,5, 50);
  Menu.AddItem("EffectMultiplier:", 1, EffectMultiplier,0, 100);
  Menu.AddItem("SpeedMultiplier:", 0.01, zSpeedMultiplier,0, 5);
  Menu.AddItem("PerspectiveShift:", 1, PerspectiveShift,0, 200); 
  
  daSound = new Sound(this);
  background(0);
  noFill();
  stroke(1);
  strokeWeight(2);
  daBall = new Ball();
  noCursor();
  
  hint(DISABLE_OPENGL_2X_SMOOTH);
hint(ENABLE_OPENGL_4X_SMOOTH);
//gl.glHint (gl.GL_LINE_SMOOTH_HINT, gl.GL_NICEST);
//gl.glEnable (gl.GL_LINE_SMOOTH); 
daTube = new Tube();
frameRate(30);
}

void draw()
{
  //println(frameRate);
  //Drifting Ammortissement
  gl.OpenGLStartDraw();
  background(0,0.1);
  if(!PAUSED)
  {
    daBall.Speed.x*=0.999;
    daBall.Speed.y*=0.999;
    //Z Speed Acceleration
    zSpeedMultiplier.value*=1.00005;
      
    if(daDelay!=0){delay(daDelay);daDelay=0;} 
    daPaddle1.Move();
    daPaddle2.Move();
    daPills.Move();
    daBall.Move();
    daBounces.Move();
  }
  
  daPaddle2.Draw();
  daTube.UpdateColors();
  
  gl.OpenGLEndDraw(); 
  
  
  //DrawFrame2();
    
  
  daBounces.Draw();
  daPills.Draw();
  daBall.Draw();
  Menu.Draw();

     daPaddle1.Draw();
      
   //camera(0,0,200, 0,0,0, 0,1,0);
  Vect3d tmpCamFrom = new Vect3d(map(mouseX, 0, width, -PerspectiveShift.value,PerspectiveShift.value),map(mouseY, 0, height, -PerspectiveShift.value,PerspectiveShift.value),200);
  Vect3d tmpCamTo   = new Vect3d(-map(mouseX, 0, width, -PerspectiveShift.value,PerspectiveShift.value),-map(mouseY, 0, height, -PerspectiveShift.value,PerspectiveShift.value),-TUBE_LENGTH/2);
  CamFrom.DriftTowards(tmpCamFrom, 0.01);
  CamTo.DriftTowards(tmpCamTo, 0.01);
      
  
  
  if(!keyPressed) Menu.KeyEvents();
  Camera(CamFrom, CamTo);
  
  
}
void keyPressed()
{
  Menu.KeyEvents(); 
  //println("Hit:"+ key);
  if(key=='p')PAUSED=!PAUSED;
  if(key=='m')MUTED=!MUTED;
  if(key=='z')daPills.Add();
}

void Camera(Vect3d v3dFrom, Vect3d v3dTo)
{
  camera(v3dFrom.x,v3dFrom.y,v3dFrom.z, v3dTo.x,v3dTo.y,v3dTo.z, 0,1,0);
  //camera(v3dFrom.x,v3dFrom.y,v3dFrom.z, v3dTo.x,v3dTo.y,v3dTo.z, sin((float)millis()/10000),cos((float)millis()/10000),0);
}
