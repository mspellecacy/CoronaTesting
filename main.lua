-- Project: CoronaTesting
-- Description: Various Test Beds / Scratch Apps
--

-- Get rid of the top title bar, it just makes sense!
display.setStatusBar( display.HiddenStatusBar );

-- require controller module
local storyboard = require( "storyboard" );

-- load first screen
storyboard.gotoScene( "titleScene" );