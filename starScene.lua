local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local cX = display.viewableContentWidth;
local cY = display.viewableContentHeight;
local cCX = cX / 2;
local cCY = cY / 2;

local stars = {};
local starCount = 100;

local transitions = {};
local rand = math.random;

local function doStars(hitLoc)

   -- Kill the use text
   display.remove(useText);

   --> Build some stars
   for i=1,starCount,1 do 
      stars[i] = display.newImageRect("star.png", 45, 45);
      stars[i].x = hitLoc.x;
      stars[i].y = hitLoc.y;
   end

   --> Animate some stars
   for i=1,#stars,1 do

      starType = rand(1,4);

      if(starType == 1) then
	 -- Down and to the Right
	 rT = { x = (hitLoc.x+rand(1,(cX-hitLoc.x))), 
		y = (hitLoc.y+rand(1,(cY-hitLoc.y))), 
		rotation=rand(1,920), 
		time=rand(145,500)}
      elseif(starType== 2) then
	 -- Down and to the Left.
	 rT = { x = (hitLoc.x-rand(1,hitLoc.x)), 
		y = (hitLoc.y+rand(1,(cY-hitLoc.y))), 
		rotation=rand(1,920), 
		time=rand(145,500)}
      elseif(starType== 3) then
	 -- Up and to the Right.
	 rT = { x = (hitLoc.x+rand(1,(cX-hitLoc.x))), 
		y = (hitLoc.y-rand(1,hitLoc.y)), 
		rotation=rand(1,920), 
		time=rand(145,500)}
      elseif(starType== 4) then
	 -- Up and to the Left.
	 rT = { x = (hitLoc.x-rand(1,hitLoc.x)), 
		y = (hitLoc.y-rand(1,hitLoc.y)), 
		rotation=rand(1,920), 
		time=rand(145,500)}

      end
      
      -- We want them all to disappear eventually
      rT.alpha = 0;

      -- Flashes the screen giving a nice 'impact' effect.
      flashRect = display.newRect(0,0,cX,cY);
      flashRect:setFillColor(255,255,255);
      flashRect.alpha = 0.05;
      transition.to(flashRect,{time=250, alpha=0});

      -- Fling the stars around
      transition.to(stars[i], rT);
   end

   print("\t" .. ( system.getInfo( "textureMemoryUsed" ) / 1048576 ) .. "mb" );
end

function scene:createScene( event )
	local group = self.view;
end

function scene:enterScene( event )
   local group = self.view

   useText = display.newText(group, "Tap Screen!", 0, 0, native.systemFont, 45);
   useText.x = cCX; useText.y = cCY;

   native.setActivityIndicator( false );	
   Runtime:addEventListener("tap", doStars);
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

