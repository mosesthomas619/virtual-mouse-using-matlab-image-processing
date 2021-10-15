
% Red only to track
% Red & blue -> left click
% Red & green -> right click
% Red,green & blue -> double click
% Blue only to scroll


function mouse()

 
    redThresh = 0.22; 
    greenThresh = 0.15;
    blueThresh = 0.33;
    numFrame = 2000; 


cam = imaqhwinfo;
cameraName = char(cam.InstalledAdaptors(end));
cameraId = 3;
cameraFormat = char('YUY2_640x480');


jRobot = java.awt.Robot; 
vidDevice = imaq.VideoDevice(cameraName, cameraId, cameraFormat, ... 
                    'ReturnedColorSpace', 'RGB');

vidInfo = imaqhwinfo(vidDevice);  
screenSize = get(0,'ScreenSize'); 
hblob = vision.BlobAnalysis('AreaOutputPort', false, ...
                                'CentroidOutputPort', true, ... 
                                'BoundingBoxOutputPort', true', ...
                                'MaximumBlobArea', 3000, ...
                                'MinimumBlobArea', 100, ...
                                'MaximumCount', 3);
hshapeinsBox = vision.ShapeInserter('BorderColorSource', 'Input port', ... 
                                    'Fill', true, ...
                                    'FillColorSource', 'Input port', ...
                                    'Opacity', 0.4);
hVideoIn = vision.VideoPlayer('Name', 'Final Video', ...
                                'Position', [100 100 vidInfo.MaxWidth+20 vidInfo.MaxHeight+30]);
nFrame = 0; 
lCount = 0; rCount = 0; dCount = 0;
iPos = vidInfo.MaxHeight/2;




while (nFrame < numFrame)
    rgbFrame = step(vidDevice); 
    rgbFrame = flip(rgbFrame,2); 
    diffFrameRed = imsubtract(rgbFrame(:,:,1), rgb2gray(rgbFrame)); 
    binFrameRed = im2bw(diffFrameRed, redThresh); 
    [centroidRed, bboxRed] = step(hblob, binFrameRed); 

    diffFrameGreen = imsubtract(rgbFrame(:,:,2), rgb2gray(rgbFrame));
    binFrameGreen = im2bw(diffFrameGreen, greenThresh);
    [~, bboxGreen] = step(hblob, binFrameGreen); 
    
    diffFrameBlue = imsubtract(rgbFrame(:,:,3), rgb2gray(rgbFrame));
    binFrameBlue = im2bw(diffFrameBlue, blueThresh); 
    [centroidBlue, bboxBlue] = step(hblob, binFrameBlue); 
    
    
    if (length(bboxRed(:,1)) == 1) && (isempty(bboxGreen(:,1))) && (isempty(bboxBlue(:,1)))
      jRobot.mouseMove(1.5*centroidRed(:,1)*screenSize(3)/vidInfo.MaxWidth, 1.5*centroidRed(:,2)*screenSize(4)/vidInfo.MaxHeight);
    end
    
    
   if (~isempty(bboxBlue(:,1))) || (~isempty(bboxGreen(:,1)))
    if (length(bboxBlue(:,1)) == 1) && (length(bboxRed(:,1)) == 1)  && (isempty(bboxGreen(:,1))) 
               lCount=lCount+1;
            if lCount >=3
                jRobot.mousePress(16);
                pause(0.1);
                jRobot.mouseRelease(16);
                 pause(0.7); 
            end
    
         
         
    elseif (length(bboxGreen(:,1)) == 1) && (length(bboxRed(:,1)) == 1) && (isempty(bboxBlue(:,1)))
            rCount = rCount + 1;
            if rCount >=3 
                jRobot.mousePress(4);
                pause(0.1);
                jRobot.mouseRelease(4);
                pause(0.7);
            end
    
    
    elseif (length(bboxBlue(:,1)) == 1) && (length(bboxGreen(:,1)) == 1) && (length(bboxRed(:,1)) == 1)
              dCount = dCount + 1;
            if dCount >= 3
                jRobot.mousePress(16);
                pause(0.1);
                jRobot.mouseRelease(16);
                pause(0.1);
                jRobot.mousePress(16);
                pause(0.1);
                jRobot.mouseRelease(16);
                pause(0.7);
            end
    end
    else
      lCount = 0; rCount = 0; dCount = 0; 
    end
   if (length(bboxBlue(:,1)) == 1) && (isempty(bboxGreen(:,1))) && (isempty(bboxRed(:,1)))
         if (mean(centroidBlue(:,2)) - iPos) < -2
            jRobot.mouseWheel(-1);
             jRobot.mouseWheel(-1);
             jRobot.mouseWheel(-1);
              
        elseif (mean(centroidBlue(:,2)) - iPos) > 2
            jRobot.mouseWheel(1);
            jRobot.mouseWheel(1);
             jRobot.mouseWheel(1);
             
           
        end
        iPos = mean(centroidBlue(:,2));
   end
    
    
    vidIn = step(hshapeinsBox, rgbFrame, bboxRed,single([1 0 0])); 
    vidIn = step(hshapeinsBox, vidIn, bboxGreen,single([0 1 0]));
    vidIn = step(hshapeinsBox, vidIn, bboxBlue,single([0 0 1])); 
    step(hVideoIn, vidIn); 
    nFrame = nFrame+1;
    clc;
end

release(hVideoIn); 
release(vidDevice);
clc;
end
         
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
      