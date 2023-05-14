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

local flashlightGear = Gear(4, -4, 0.03, 0.1);

local flashlight = Flashlight(flashlightGear);

function playdate.update()
	playdate.timer.updateTimers();
	playdate.graphics.animation.blinker.updateAll();
	playdate.graphics.sprite.update();
	
	Gear.updateAll();
	Railgun.update();
	BlinkerSprite.updateAll();
	Bullet.updateAll();
	
	flashlight:update();
end

function playdate.cranked(c, ac)
	if playdate.buttonIsPressed(playdate.kButtonUp) then
		flashlightGear:onCranked(c, ac);
	elseif playdate.buttonIsPressed(playdate.kButtonLeft) then

	elseif playdate.buttonIsPressed(playdate.kButtonRight) then

	end
end