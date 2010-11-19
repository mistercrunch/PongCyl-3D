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
//This only kinda work, I think there might be issues with the lib
import ddf.minim.*;

class Sound
{
  Minim minim;
  AudioSample ping, pong;
  Sound(PApplet p)
  {
    minim = new Minim(p);
    ping = minim.loadSample("pong1.wav", 4096);
    pong = minim.loadSample("pong2.wav", 4096);

  }
  
  void Ping()
  {
    ping.trigger();
  }
  void Pong()
  {
    //cptBidon++;
    //println(cptBidon);
    pong.trigger();
  }
  
  void Stop()
  {
    ping.close();
    pong.close();
    minim.stop();
 
  }
}


void stop()
{
  // always close Minim audio classes when you are done with them
  daSound.Stop(); 
  super.stop();
}
