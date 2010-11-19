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
//This class is for a menu that is shown within the game by pushing <space bar> you can view tracked variables,
//Use up/down arrows to go from a variable to the next
//Use left/right to increase/decrease the value of the variable
class VariableMenu
{
  PFont font;
  LinkedList MenuItems;
  int MenuWidth, MenuHeight;
  int x,y,z;
  float FontSize;
  color bgC;
  color fgC;
  color selectedColor;
  MenuItem SelectedItem;
  boolean isMenuVisible;
  char lastNumberKey;
  int HOLD_TIME_TO_SAVE = 3000;
  double NumberKeyMillis;
  VariableMenu(int posX, int posY, int posZ, int inMenuWidth, int inMenuHeight, float inFontSize)
  {
    font = loadFont("Arial-Black-36.vlw");
    textFont(font, inFontSize); 
    isMenuVisible=false;
    colorMode(HSB, 1);
    bgC = color(0.5, 0, 0, 0.3);
    fgC = color(1,0,1,0.35);
    selectedColor = color(1,0,1,1);
    MenuWidth = inMenuWidth;
    MenuHeight = inMenuHeight;
    x = posX;
    y = posY;
    z = posZ;
    MenuItems = new LinkedList();
    FontSize = inFontSize;
    NumberKeyMillis=0;
    lastNumberKey=' ';
  }

  void AddItem(String sLabel, float increment, MyFloat f)
  {
    MenuItem newItem = new MenuItem(sLabel, increment, f);
    MenuItems.add(newItem);
    if(MenuItems.size()==1)
      SelectedItem = newItem;
  }
  void AddItem(String sLabel, float increment, MyFloat f, float Min, float Max)
  {
    MenuItem newItem = new MenuItem(sLabel, increment, f, Min, Max);
    MenuItems.add(newItem);
    if(MenuItems.size()==1)
      SelectedItem = newItem;
  }


  void Draw()
  {
    if(isMenuVisible)
    {
      smooth();
      int MARGIN = 1;
      stroke(fgC);
      fill(bgC);
     // fill(bgC);
      translate(0,0,z-1);
      strokeWeight(2);
      rect(x,y, MenuWidth, MenuHeight);
      Iterator it = MenuItems.listIterator();
      int i=0;
      translate(0,0,1);
      while ( it.hasNext() ) 
      {
        MenuItem MI = (MenuItem)it.next();
        i++;
        if(MI==SelectedItem) fill(selectedColor);
        else fill(fgC);
        
        if(MI.CurrentValue.value%1==0)
          text(MI.sLabel+(int)MI.CurrentValue.value, x+MARGIN,y + (i*(FontSize + MARGIN)));
        else
          text(MI.sLabel+((float)round(MI.CurrentValue.value*10000)/10000), x+MARGIN,y + (i*(FontSize + MARGIN)));
      }
    }
  }
  
  void SaveSettings(String filename)
  {
      Iterator it = MenuItems.listIterator();
      
      PrintWriter file = createWriter(filename);
      while ( it.hasNext() ) 
      {
        MenuItem MI = (MenuItem)it.next();
        file.println(MI.sLabel+"\t"+Float.toString(MI.CurrentValue.value));
      }
      file.flush(); // Write the remaining data
      file.close(); // Finish the file
      
      background(1);
  }
  
  void LoadSettings(String filename)
  {
      String[] lines;
      lines = loadStrings(filename);
      if(lines!=null)
      {
        Iterator it = MenuItems.listIterator();
        int i =0;
        while ( it.hasNext() ) 
        {
          String[] pieces = split(lines[i], '\t');
          MenuItem MI = (MenuItem)it.next();
          MI.CurrentValue.value = float(pieces[1]);
          i++;
        }
        
        background(1);
      }
  }
  
  void KeyEvents()
  {
    if(!keyPressed)
    {
      NumberKeyMillis =0;
      if(lastNumberKey!=' ')
      {
        LoadSettings(key+".preset");
        lastNumberKey=' ';
      }
      
    }
    else 
    {
      if (key != CODED)
      {
        if (key==' ')
        {
          isMenuVisible=!isMenuVisible;
        }
        if (key>='1' && key <= '9')
        {
          if(NumberKeyMillis==0)
          {
            lastNumberKey = key;
            NumberKeyMillis = millis();
          }
          else if (lastNumberKey==key&&NumberKeyMillis+HOLD_TIME_TO_SAVE<millis())
          {
            SaveSettings(key+".preset");
            NumberKeyMillis = 0;
          }
        }
      } 
      else if (key == CODED) 
      {
        if(keyCode==UP)
        {
          if(MenuItems.indexOf(SelectedItem) == 0)
            SelectedItem = (MenuItem)MenuItems.getLast();
          else
            SelectedItem = (MenuItem)MenuItems.get(MenuItems.indexOf(SelectedItem) -1);      
        }
        else if(keyCode==DOWN)
        {
          if(SelectedItem == MenuItems.getLast())
            SelectedItem = (MenuItem)MenuItems.getFirst();
          else
            SelectedItem = (MenuItem)MenuItems.get(MenuItems.indexOf(SelectedItem) +1);      
        }
        else if(keyCode==LEFT)
        {  
          if(!SelectedItem.hasMinMax || SelectedItem.CurrentValue.value - SelectedItem.Increment >= SelectedItem.Min)
            SelectedItem.CurrentValue.value-=SelectedItem.Increment;
        }
        else if(keyCode==RIGHT)
        {  
          if(!SelectedItem.hasMinMax || SelectedItem.CurrentValue.value + SelectedItem.Increment <= SelectedItem.Max)
            SelectedItem.CurrentValue.value+=SelectedItem.Increment;
        }
      }
    }
  }
};

class MenuItem
{
  String sLabel;
  float Increment;
  float OrigValue;
  MyFloat CurrentValue;
  boolean hasMinMax;
  float Min,Max;


  MenuItem(String insLab, float inIncrement, MyFloat f)
  {
    Increment=inIncrement;
    sLabel = insLab;
    OrigValue = f.value;
    CurrentValue = f;
    hasMinMax=false;
  }
  MenuItem(String insLab, float inIncrement, MyFloat f, float inMin, float inMax)
  {
    Increment=inIncrement;
    sLabel = insLab;
    OrigValue = f.value;
    CurrentValue = f;
    hasMinMax=true;
    Min = inMin;
    Max = inMax;
  }
  void Reset()
  {
    CurrentValue.value=OrigValue;
  }
  
};


class MyFloat
{
  float value;
  MyFloat(float in)
  {value=in;}
};


