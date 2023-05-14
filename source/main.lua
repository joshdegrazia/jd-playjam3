import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"
import "CoreLibs/timer"
import "CoreLibs/ui"

import "scripts/gear"
import "scripts/blinker-sprite"
import "scripts/bullet"
import "scripts/flashlight"
import "scripts/railgun"
import "scripts/spawner"
import "scripts/darkness"

local flashlight = Flashlight();
local railgun = Railgun();
local spawnerTimer = nil;

local running = false;

playdate.ui.crankIndicator:start();

function showInstructions()
	local drawMode = playdate.graphics.getImageDrawMode();
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite);
	playdate.graphics.drawText("A: Shoot\nB: Start/Stop Game\nUp+Crank: Rotate Flashlight\nLeft+Crank: Rotate Gun", 10, 10)
	playdate.graphics.setImageDrawMode(drawMode);
end

function startGame()
	running = true;
	flashlight:setEnabled(true);
	railgun:setEnabled(true);
	spawnerTimer = playdate.timer.keyRepeatTimerWithDelay(1000, 1000, SpawnCupids);
end

function endGame()
	running = false;
	flashlight:setEnabled(false);
	railgun:setEnabled(false);
	spawnerTimer:remove();
	spawnerTimer = nil;
	playdate.graphics.sprite.removeAll();
end

function playdate.update()
	if playdate.buttonJustPressed(playdate.kButtonB) then
		if running then
			endGame()
		else
			startGame()
		end
	end

	playdate.timer.updateTimers();
	playdate.graphics.animation.blinker.updateAll();
	playdate.graphics.sprite.update();
	
	railgun:update();
	Darkness.update();

	if not running then
		showInstructions();
	end
	
	if playdate.isCrankDocked() then
		playdate.ui.crankIndicator:update();
	end
end

function playdate.cranked(c, ac)
	if running then
		if playdate.buttonIsPressed(playdate.kButtonUp) then
			flashlight:onCranked(c, ac);
		elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
			railgun:onCranked(c, ac);
		end
	end
end