-- Generic Title Page...

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
require "sprite"

local cX = display.viewableContentWidth;
local cY = display.viewableContentHeight;
local cCX = cX / 2;
local cCY = cY / 2;



local function onSpawnTouch( self, event )
   function nextScene()
      native.setActivityIndicator( true );
      storyboard.gotoScene( "spawnScene", "fade", 400  );
   end

   if event.phase == "began" then
      self:setTextColor(0,150,0);
      timer.performWithDelay(50, nextScene);
      return true
   end
end

local function onStarTouch( self, event )

   function nextScene()
      native.setActivityIndicator( true );
      storyboard.gotoScene( "starScene", "fade", 400  );
   end

   if event.phase == "began" then
      self:setTextColor(0,150,0);
      timer.performWithDelay(50, nextScene);
      return true
   end

end


function scene:createScene( event )
   local group = self.view;
   
   --> Star Button
   starBtn = display.newText(group, "Star Particles", 0, 0, native.systemFont, 45);
   starBtn:setReferencePoint(display.CenterReferencePoint)
   starBtn.x = cCX; starBtn.y = 45;
   starBtn.touch = onStarTouch;


   --> Spawn Button
   spawnBtn = display.newText(group, "Spawn Objects", 0, 0, native.systemFont, 45);
   spawnBtn:setReferencePoint(display.CenterReferencePoint)
   spawnBtn.x = cCX; spawnBtn.y = 95;
   spawnBtn.touch = onSpawnTouch;
	
end

function scene:enterScene( event )
   local group = self.view
   native.setActivityIndicator( false );	
   starBtn:addEventListener("touch", starBtn );
   spawnBtn:addEventListener("touch", spawnBtn );
end

function scene:exitScene( event )
   local group = self.view
end

function scene:destroyScene( event )
   local group = self.view
end

---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene