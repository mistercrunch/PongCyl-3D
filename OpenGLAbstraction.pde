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
int cptBidon=0;

//import com.sun.opengl.util.texture.*;
import javax.media.opengl.*;
import javax.media.opengl.glu.*;
import com.sun.opengl.util.*;
import processing.opengl.*;
import java.nio.*;
import com.sun.opengl.util.texture.*;

class OpenGLAbstraction
{

  FloatBuffer vSquareBuffer;
  FloatBuffer cSquareBuffer;
  Texture texBall;
  Texture texPaddle;
  
  int              nbQuad;
  PGraphicsOpenGL  pgl;
  GL               gl;
  int squareList;

  OpenGLAbstraction()
  {
    pgl         = (PGraphicsOpenGL) g;
    gl          = pgl.gl;
    gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE);    
    nbQuad=0;
    gl.setSwapInterval(1);
    pgl.beginGL();
    squareList = gl.glGenLists(1);
    gl.glNewList(squareList, GL.GL_COMPILE);
    gl.glBegin(GL.GL_POLYGON);
    gl.glTexCoord2f(0, 0);    gl.glVertex2f(-.5, -.5);
    gl.glTexCoord2f(1, 0);    gl.glVertex2f( .5, -.5);
    gl.glTexCoord2f(1, 1);    gl.glVertex2f( .5,  .5);
    gl.glTexCoord2f(0, 1);    gl.glVertex2f(-.5,  .5);
    gl.glEnd();
    gl.glEndList();
    pgl.endGL();
    
    //Loading textures
    try 
    {
        texBall = TextureIO.newTexture(new File(dataPath("ball.png")), true);  
        texPaddle = TextureIO.newTexture(new File(dataPath("paddle.png")), true);  
    }
    catch (IOException e) 
    {    
      println("Texture file is missing");
      exit();
    }
  }
  
  
  
  void renderPaddle(Vect3d _loc, float _diam, float _alpha)
  {
    pgl.beginGL();
//    gl.glPushMatrix();
      texPaddle.bind();
      texPaddle.enable();
  
      
    //  gl.glTranslatef( _loc.x, _loc.y, _loc.z);
      
      //gl.glRotatef(degX,0,1,0);
      //gl.glRotatef(degY+90,1,0,0);
      //gl.glRotatef(random(360),0,0,1);
      
      
      
      gl.glScalef( _diam, _diam, _diam );
      //gl.glColor4f( _col.r, _col.g, _col.b, _alpha );
      gl.glColor4f(1,1,1, 0.8);
      
      gl.glCallList( squareList );
      
      texPaddle.disable();
    //gl.glPushMatrix();
    pgl.endGL();
  }
  
  void renderBall(Vect3d _loc, float _diam, color c)
  {
    pgl.beginGL();
//    gl.glPushMatrix();
      texBall.bind();
      texBall.enable();
  
      
    //  gl.glTranslatef( _loc.x, _loc.y, _loc.z);
      
      //gl.glRotatef(degX,0,1,0);
      //gl.glRotatef(degY+90,1,0,0);
      //gl.glRotatef(random(360),0,0,1);
      
      
      
      gl.glScalef( _diam, _diam, _diam );
      gl.glColor4f(red(c), green(c), blue(c), alpha(c) );
      //gl.glColor4f(1,0,0,1 );
      
      gl.glCallList( squareList );
      
      texBall.disable();
    //gl.glPushMatrix();
    pgl.endGL();
  }

  void OpenGLStartDraw()
  {
    pgl = (PGraphicsOpenGL) g;
    gl.glDepthMask(false);
    gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);
    gl.glBlendEquation(GL.GL_FUNC_ADD);	

  } 
  void DrawQuads(int inNbQuad)
  {
    nbQuad = inNbQuad;
    vSquareBuffer = BufferUtil.newFloatBuffer(nbQuad * 12);
    cSquareBuffer = BufferUtil.newFloatBuffer(nbQuad * 12);
  } 
  
  void SetColor(color c)
  {
    cSquareBuffer.put(red(c));
    cSquareBuffer.put(green(c));
    cSquareBuffer.put(blue(c));
    
    cSquareBuffer.put(red(c));
    cSquareBuffer.put(green(c));
    cSquareBuffer.put(blue(c));    
    
    cSquareBuffer.put(red(c));
    cSquareBuffer.put(green(c));
    cSquareBuffer.put(blue(c));
    
    cSquareBuffer.put(red(c));
    cSquareBuffer.put(green(c));
    cSquareBuffer.put(blue(c));
  
}
  
  void AddSquare(float x1, float x2,float y1,float y2,float z1,float z2)
  {
    vSquareBuffer.put(x1);
    vSquareBuffer.put(y1);
    vSquareBuffer.put(z1);
    
    vSquareBuffer.put(x1);
    vSquareBuffer.put(y1);
    vSquareBuffer.put(z2);
    
    vSquareBuffer.put(x2);
    vSquareBuffer.put(y2);
    vSquareBuffer.put(z2);
    
    vSquareBuffer.put(x2);
    vSquareBuffer.put(y2);
    vSquareBuffer.put(z1);
    
    
  }
  
  void AddQuad(Vect3d v3d1, Vect3d v3d2, Vect3d v3d3, Vect3d v3d4)
  {
    vSquareBuffer.put(v3d1.x);
    vSquareBuffer.put(v3d1.y);
    vSquareBuffer.put(v3d1.z);
    
    vSquareBuffer.put(v3d2.x);
    vSquareBuffer.put(v3d2.y);
    vSquareBuffer.put(v3d2.z);
    
    vSquareBuffer.put(v3d3.x);
    vSquareBuffer.put(v3d3.y);
    vSquareBuffer.put(v3d3.z);
    
    vSquareBuffer.put(v3d4.x);
    vSquareBuffer.put(v3d4.y);
    vSquareBuffer.put(v3d4.z);

  }
  void OpenGLEndDraw()
  {
 
    pgl.beginGL();
      
        gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA);
        gl.glBlendEquation(GL.GL_FUNC_ADD);
      
      //  gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE);    
        
        vSquareBuffer.rewind();
        cSquareBuffer.rewind();
 
        gl.glEnableClientState(GL.GL_VERTEX_ARRAY);
        
        gl.glVertexPointer(3, GL.GL_FLOAT, 0, vSquareBuffer);
        gl.glEnableClientState(GL.GL_COLOR_ARRAY);
        gl.glColorPointer(3, GL.GL_FLOAT, 0, cSquareBuffer);
        gl.glPushMatrix();

          gl.glLineWidth(1);
          gl.glEnable (gl.GL_LINE_SMOOTH);
          gl.glDrawArrays(GL.GL_QUADS, 0, nbQuad*4);
          
        gl.glPopMatrix();
        
      
    pgl.endGL();
  }

};
