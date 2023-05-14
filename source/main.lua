import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"
import "CoreLibs/timer"

import "scripts/gear"
import "scripts/blinker-sprite"
import "scripts/bullet"
import "scripts/flashlight"
import "scripts/railgun"
import "scripts/spawner"

playdate.timer.keyRepeatTimerWithDelay(1000, 1000, SpawnCupids);

local flashlight = Flashlight(flashlightGear);
local railgun = Railgun(railgunMoveGear, railgunShootGear);

function playdate.update()
	playdate.timer.updateTimers();
	playdate.graphics.animation.blinker.updateAll();
	playdate.graphics.sprite.update();
	
	Gear.updateAll();
	railgun:update();
	
	flashlight:update();
end

function playdate.cranked(c, ac)
	if playdate.buttonIsPressed(playdate.kButtonUp) then
		flashlight:onCranked(c, ac);
	elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
		railgun:onCranked(c, ac);
	end
end