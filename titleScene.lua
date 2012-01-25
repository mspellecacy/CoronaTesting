local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
require "sprite"

local cX = display.viewableContentWidth;
local cY = display.viewableContentHeight;
local cCX = cX / 2;
local cCY = cY / 2;

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

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view;

	--> Star Button
	starBtn = display.newText(group, "Star Particles", 0, 0, native.systemFont, 45);
	starBtn:setReferencePoint(display.CenterReferencePoint)
	starBtn.x = cCX; starBtn.y = 45;
	starBtn.touch = onStarTouch;
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	native.setActivityIndicator( false );	
	starBtn:addEventListener("touch", starBtn );
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
   local group = self.view
end

---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene