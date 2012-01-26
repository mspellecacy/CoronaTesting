--> Storyboard support stuffs
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local physics = require "physics"
--physics.setDrawMode( "hybrid" );
physics.start();


local cX = display.viewableContentWidth;
local cY = display.viewableContentHeight;
local cCX = cX / 2;
local cCY = cY / 2;
local rand = math.random;

--> Scene Vars
local minDist = 35;
local pegRadius = 15;
local pegs = {};
local ballRadius = 15;
local balls = {};

--> Setup some walls
local leftWall  = display.newRect (0, 0, 1, display.contentHeight)
local rightWall = display.newRect (display.contentWidth, 0, 1, display.contentHeight)
--local ceiling   = display.newRect (0, 0, display.contentWidth, 1)
local floor     = display.newRect (0, display.contentHeight, display.contentWidth, 1)
physics.addBody (leftWall, "static",
		 {density = 1.0, friction = 0, bounce = .02, isSensor = false})
physics.addBody (rightWall, "static",
  		 {density = 1.0, friction = 0, bounce = .02, isSensor = false})
physics.addBody (floor, "static",
		 {density = 1.0, friction = 0, bounce = .02, isSensor = false});

print("cX: "..cX.."; cY: "..cY);

local function spawnBall(loc)
   if loc.phase == "began" then
      physProps = { density=3.0, friction=0.8, bounce=0.7, radius = ballRadius }
      balls[#balls+1] = display.newCircle(loc.x, loc.y, ballRadius);
      balls[#balls]:setFillColor(128, 0, 0);
      balls[#balls].ballName = #balls;
      physics.addBody(balls[#balls], "dynamic", physProps);
   end
end

--> Basic distance calculator between two plot points
local function distance(px, py, qx, qy) 
   local dx = px - qx;
   local dy = py - qy;
   local dist = math.sqrt(dx*dx + dy*dy);
   return dist;
end

--> Checks to see if the point overlaps any pegs. 
local function overlap(loc)
   for i=1,#pegs do
      if distance(pegs[i].x, pegs[i].y, loc.x, loc.y) <= 35 then
	 return true;
      end
   end
   return false;
end


local function pegCollision(self, event)
   if event.phase == "ended" then
      local removeSelf = function () return display.remove(self) end
      timer.performWithDelay(2000, removeSelf);
      
      local function pulseUp()
	 transition.to(self, { alpha = .5, time = 500, onComplete=pulseDown})
      end
      local function pulseDown()
	 transition.to(self, { alpha = 0, time = 500, onComplete=pulseUp})
      end
      self.alpha = .25;
      pulseUp();
   end
end

local function floorCollision(self, event)
   local removeBall = function () return display.remove(event.other) end
   timer.performWithDelay(200, removeBall);
end

--> Dynamically generate a field of circles or "pegs" for the playfield.
local function buildField()
   physProps = { density=3.0, friction=0.8, bounce=0.3, radius = pegRadius }
   y=rand(100, 150);
   while y < cY do
      x = rand(15, 20)
      while x < cX do
	 -- 1 in 10 chance of spawning a new circle, just for entropy.
	 if rand(1,10) == 1 then
	    oCheck = true;
	    wobble = 5;
	    while oCheck do
	       nX, nY = rand(x-wobble,x+wobble), rand(y-wobble,y+wobble);
	       oCheck = overlap({x=nX,y=nY});
	       wobble = wobble + 5;
	    end
	    pegs[#pegs+1] = display.newCircle(nX, nY, pegRadius);
	    if rand(1,3) == 1 then
	       pegs[#pegs]:setFillColor(0,128,0);
	       pegs[#pegs].scorePeg = true;
	    else
	       pegs[#pegs]:setFillColor(128, 128, 128);
	       pegs[#pegs].scorePeg = false;
	    end
	    physics.addBody(pegs[#pegs], "static", physProps);
	    pegs[#pegs].collision = pegCollision;
	    pegs[#pegs].pegName = #pegs;
	    pegs[#pegs]:addEventListener("collision",pegs[#pegs]);
	 end
	 x = x + rand(30, 55);
      end
      x = rand(15, 25)
      y = y + rand(30, 45);
   end
end


function scene:createScene( event )
   local group = self.view
   buildField();
end

function scene:enterScene( event )
   local group = self.view
   Runtime:addEventListener("touch", spawnBall);
   floor.collision = floorCollision;
   floor:addEventListener("collision", floor);
   native.setActivityIndicator(false);
end

function scene:exitScene( event )
   local group = self.view
end

function scene:destroyScene( event )
   local group = self.view
end


-----------------------------------------------------------------------------------

scene:addEventListener( "createScene", scene )

scene:addEventListener( "enterScene", scene )

scene:addEventListener( "exitScene", scene )

scene:addEventListener( "destroyScene", scene )

return scene;