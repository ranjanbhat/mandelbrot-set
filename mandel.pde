float x;
float y;
float dx=0.005;
float dy=0.005;
float xmax=1.5;
float ymax=1;
float h,k;
float factor=2;
float t=4;
float times=1;
//float iterlimit=100;
//float max=4;
complex temp=new complex();

void setup()
{
  fullScreen();
  //size(1900,1000);
  colorMode(HSB);
  h=0;
  k=0;
}

void mouseClicked()
{
  exit();
}

void mouseWheel(MouseEvent event)
{
  float e=event.getCount();
  if(e<0)
  {
  h=map(mouseX,0,width,h-xmax,h+xmax);
  k=map(mouseY,0,height,k-ymax,k+ymax);
  xmax/=factor;
  ymax/=factor;
  dx/=factor;
  dy/=factor;
  times*=2;
  }
  else
  {
  xmax*=factor;
  ymax*=factor;
  dx*=factor;
  dy*=factor;
  times/=2;
  }
  background(0);
}

void draw()
{
  strokeWeight(t);
  translate(width/2,height/2);
  
  for(x=h-xmax; x<=h+xmax; x+=dx)
  for(y=k-ymax; y<=k+ymax; y+=dy)
  {
    complex C=new complex(x,y);
    int n=C.check();
    float px=map(x,h-xmax,h+xmax,-width/2,width/2);
    float py=map(y,k-ymax,k+ymax,-height/2,height/2);
    if(n==100) stroke(0);
    else stroke(255-floor(n*2.55),255,255);
    point(px,py);
  } 
  
  stroke(255);
  float xzero=map(0,h-xmax,h+xmax,-width/2,width/2);
  float yzero=map(0,k-ymax,k+ymax,-height/2,height/2);
  line(xzero,-height/2, xzero, height/2);
  line(-width/2,yzero,width/2,yzero);
  stroke(0);
  textSize(40);
  fill(0);
  text(times+"x",-width/2+10,-height/2+50);
}



class complex
{
  float a;
  float b; 
  
  complex(float x, float y){a=x; b=y;}
  
  complex(){a=0; b=0;}
  
  int check()
  {
    int count=0;
    temp.a=0; temp.b=0;
    while(true)
    { temp.square(); temp.addto(this); 
      count++;
      if(count>100) break;
      if(temp.a>2 || temp.b>2) break;
    }
  
    return count-1;
  }
  
  void square()
  {
    float newa=a*a-b*b;
    float newb=a*b+b*a;
    a=newa;
    b=newb;
  }
  
  void conjugate()
  {
    b=-b;
  }
  
  void reciprocal()
  {
    float newa=a/sqrt(a*a+b*b);
    float newb=-b/sqrt(a*a+b*b);
    a=newa;
    b=newb;
  }
  
  void addto(complex C)
  {
    a+=C.a;
    b+=C.b;
  }
  
  void multiplywith(complex C)
  {
    float newa= a*C.a - b*C.b;
    float newb= a*C.b + b*C.a;
    a=newa;
    b=newb;
  }
  
  void divideby(complex C)
  {
    float newa= (a*C.a + b*C.b)/(C.a*C.a + C.b*C.b);
    float newb= (b*C.a - a*C.b)/(C.a*C.a + C.b*C.b);
    a=newa;
    b=newb;
  }
  
  float mod()
  {
    return sqrt(a*a+b*b);
  }
  
  float arg()
  {
    return atan(b/a);
  }
}


//void draw()
//{  
//  loadPixels();
  
//  dx=2*xmax/width;
//  dy=2*ymax/height;
  
//  y=k-ymax;
  
//  for(int j=0; j<height; j++)
//  {
//    x=h-xmax;
//    for(int i=0 ; i<width; i++)
//    {
//      complex C=new complex();
//      C.a=y;
//      C.b=x;
//      int n=0;
      
//      float absOld=0;
//      float Cno=iterlimit;
      
//      while(n<Cno)
//      {
//        float abs=C.mod();
//        if(abs>max)
//        {
//          float difftolast=abs-absOld;
//          float difftomax =max-absOld;
//          Cno=n+difftolast/difftomax;
//          break;
//        }
//        C.square();
//        C.a+=x;
//        C.b+=y;
        
//        n++;
//        absOld=abs;
        
//      }//while
      
      
//      if(n==iterlimit)
//      pixels[i+j*width]=color(0);
//      else
//      {
//        float norm=map(Cno,0,iterlimit,0,1);
//        pixels[i+j*width]=color(255-255*sqrt(norm),255,255);
//      }
//      x+=dx;
//    }//for i
//    y+=dy;
//  }//for j
  
//}
  
  
  
  
