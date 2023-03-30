float circleCenterX;
float circleCenterY;
float outerCircleRadius = 3000.00; // This is intentionally larger than the screen size.
FloatList randomEndPointX = new FloatList();
FloatList randomEndPointY = new FloatList();
FloatList innerCircleRadius = new FloatList();
boolean usingOpposingColor;

void setup()
{
  size(1920, 1080);
  fullScreen();
  usingOpposingColor = false;
  circleCenterX = displayWidth / 2;
  circleCenterY = displayHeight / 2;
  for (int i = 0; i < 60; ++i)
  {
    switch(i)
    {
      case 0:
        innerCircleRadius.append(0.0);
        break;
      case 1:
        innerCircleRadius.append(62.5 * 0.25);
        break;
      case 2:
        innerCircleRadius.append(innerCircleRadius.get(1) + (62.5 * 0.5));
        break;
      case 3:
        innerCircleRadius.append(innerCircleRadius.get(2) + (62.5 * 0.75));
        break;
      default:
        innerCircleRadius.append(innerCircleRadius.get(i - 1) + 62.5);
        break;
    }
  }
  innerCircleRadius.reverse(); // We reverse this list to put it in the right order.
  colorMode(HSB); // Set the color mode to Hue/Saturation/Brightness for extra fun.
  background(0); // Background is put here instead of in draw to keep what is put on the canvas already.
}

void draw()
{
  float randomAngle = random(0, (2*PI)); // 2 * Pi = the maximum radians of a circle or 360 degrees.
  float randomStartPointX = circleCenterX + outerCircleRadius * (cos(randomAngle)); // Determines the start and end points of each line.
  float randomStartPointY = circleCenterY + outerCircleRadius * (sin(randomAngle));
  randomEndPointX.clear(); // Clear out the old values from these arrays.
  randomEndPointY.clear();
  
  for (int i = 0; i < innerCircleRadius.size(); ++i)
  {
    randomEndPointX.append(circleCenterX + innerCircleRadius.get(i) * (cos(randomAngle)));
    randomEndPointY.append(circleCenterY + innerCircleRadius.get(i) * (sin(randomAngle)));
  }
  
  int randomColor = int(random(0, 256)); // Picks a random color to use for that segment
  int opposingRandomColor = randomColor + 128; // Calculates the opposite of random color for the inner circle.
  if (opposingRandomColor > 255)
  {
    opposingRandomColor = opposingRandomColor - 255;
  }
  stroke(color(randomColor), 255, 255);
  line(randomStartPointX, randomStartPointY, randomEndPointX.get(0), randomEndPointY.get(0));
  usingOpposingColor = true;
  for (int i = 0; i < (innerCircleRadius.size() - 1); ++i)
  {
    if (usingOpposingColor) // Select the color and then reverse the flag for what color to use.
    {
      stroke(color(opposingRandomColor, 255, 255));
      usingOpposingColor = false;
    }
    else
    {
      stroke(color(randomColor, 255, 255));
      usingOpposingColor = true;
    }
    line(randomEndPointX.get(i), randomEndPointY.get(i), randomEndPointX.get(i + 1), randomEndPointY.get(i + 1));
  }
}

void keyPressed()
{
  if (key == 'e' || key == 'E')
  {
    exit();
  }
}
