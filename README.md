# virtual-mouse-using-matlab-image-processing


VIRTUAL MOUSE                                                             

Human Computer Interaction today greatly emphasizes on developing more spontaneous and natural interfaces. 
The Graphical User Interface (GUI) on Personal Computers (PCs) is quiet developed, well defined and provides an efficient 
interface  for  a user  to  interact  with  the computer and access the various  applications effortlessly with the help of mice,
track pad, etc. In the present  day  scenario  most  of  the mobile  phones  uses a  touch  screen technology  to  
interact  with  the  user. But this technology  is still  not cheap  to  be widely used  in  desktops  and  laptops.  
Our  objective  is  to create a  virtual mouse  system using Web camera to  interact  with  the  computer  in  a  more 
user friendly manner  that can  be  an  alternative  approach  for the touch screen.


In our project, we present an approach for human  computer interaction, where  we  try  to control mouse tracking, 
click(left & right) & scroll  events based  on  colour  detection  techniques  using  a cam.  
The  user  wears  coloured  tapes  to  provide information to the system. 
Here,  real  time video  has  been captured  using  the web-camera  integrated on a laptop. 
Individual frames of the live video are separately processed. 
The  processing  techniques  involve  an  image  subtraction  algorithm to  detect colours.
No additional  hardware is  required  by the system other than the standard  webcam  which is 
provided with every laptop computer. Once the colours  are  detected, 
the  system  performs  various  operations to track the pointer and performs control action.
Red colour is used to control the mouse pointer movement while the clicking action is based on 
simultaneous detection of two colours.If  red  along with green colour is detected,
left clicking action is performed  and,if  red  along  with  blue  colour  is  detected, 
right  clicking action is  performed. 
We try to  implement  the system in a MATLAB  environment  using  a MATLAB image processing toolbox.
                                                                                           
