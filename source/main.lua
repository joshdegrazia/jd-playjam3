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
import "scripts/darkness"

local flashlight = Flashlight();
local score = {score = 0};
local cachedScore = 0;
local railgun = Railgun();
local youDied = { endGame = false };
local spawnerTimer = nil;

local current_state = 0
local INSTRUCTIONS_STATE = 0;
local GAME_STATE = 1;
local END_STATE = 2;

playdate.ui.crankIndicator:start();

local path = "assets/sprites/"

function SpawnCupids()
    local spawnXCoord = {100, 200, 300}
    local spawnYCoord = {20, 120, 180}
    local x = spawnXCoord[math.random(3)]
    local y = spawnYCoord[math.random(3)]
	local blink = BlinkerSprite(path .. "cupid")
    blink:moveTo(x,y);
    function moveSprite()
        local x, y = blink:getPosition();
        local new_x, new_y = x, y;
        local moveDist = 10
        if x < 200 and x + moveDist < 200 then
            new_x = x + moveDist
        elseif x > 200 and x - moveDist > 200 then
            new_x = x - moveDist
        end
        if y < 120 and y + moveDist < 120 then
            new_y = y + moveDist
        elseif y > 120 and y - moveDist > 120 then
            new_y = y - moveDist
        end
        local _, _, _, len = blink:moveWithCollisions(new_x, new_y);
        if len ~= 0 then
			print("sprite collision")
            youDied["endGame"] = true;
        end
    end
    blink.timer = playdate.timer.keyRepeatTimerWithDelay(1000, 1000, moveSprite);
end

function showInstructions()
	local drawMode = playdate.graphics.getImageDrawMode();
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite);
	playdate.graphics.drawText("A: Shoot\nB: Start/Stop Game\nUp+Crank: Rotate Flashlight\nLeft+Crank: Rotate Gun", 10, 10)
	playdate.graphics.setImageDrawMode(drawMode);
end

function showEndGame()
	local drawMode = playdate.graphics.getImageDrawMode();
	playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite);
	playdate.graphics.drawText(string.format("YOU DIED\nSCORE: %d", score["score"]), 10, 10)
	playdate.graphics.setImageDrawMode(drawMode);
	youDied = { endGame = false };
end

function startGame()
	current_state = GAME_STATE;
	flashlight:setEnabled(true);
	score = {score = 0};
	youDied = { endGame = false };
	railgun = Railgun();
	railgun:setEnabled(true, score);
	cachedScore = 0;
	spawnerTimer = playdate.timer.keyRepeatTimerWithDelay(5000, 5000, SpawnCupids);
end

function endGame()
	print("called endgame");
	current_state = END_STATE;
	flashlight:setEnabled(false);
	railgun:setEnabled(false);
	spawnerTimer:remove();
	spawnerTimer = nil;
	playdate.graphics.sprite.removeAll();
end

function playdate.update()
	if playdate.buttonJustPressed(playdate.kButtonB) then
		if current_state == INSTRUCTIONS_STATE or current_state == END_STATE then
			startGame();
		end
	end
	
	if youDied["endGame"] then
		current_state = END_STATE;
		endGame();
	end

	playdate.timer.updateTimers();
	playdate.graphics.animation.blinker.updateAll();
	playdate.graphics.sprite.update();
	
	railgun:update();
	Darkness.update();

	if current_state == INSTRUCTIONS_STATE then
		showInstructions();
	end

	if current_state == END_STATE then
		showEndGame();
	end
	
	if playdate.isCrankDocked() then
		playdate.ui.crankIndicator:update();
	end
	if cachedScore < score["score"] then
		cachedScore = score["score"];
	end
	playdate.graphics.drawText(string.format("%d", score["score"]), 5, 5)
	--local drawMode = playdate.graphics.getImageDrawMode();
	--playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeXOR);
	--playdate.graphics.drawText("HLELEEO", 5, 5)
	--playdate.graphics.setImageDrawMode(drawMode);
end

function playdate.cranked(c, ac)
	if current_state == GAME_STATE then
		if playdate.buttonIsPressed(playdate.kButtonUp) then
			flashlight:onCranked(c, ac);
		elseif playdate.buttonIsPressed(playdate.kButtonLeft) then
			railgun:onCranked(c, ac);
		end
	end
end