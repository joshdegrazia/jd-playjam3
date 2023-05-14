import "CoreLibs/timer"

import "scripts/blinker-sprite"

local path = "assets/sprites/"

local spawnXCoord = {100, 200, 300}
local spawnYCoord = {20, 120, 180}
function SpawnCupids()
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
        blink:moveTo(new_x, new_y);
    end
    blink.timer = playdate.timer.keyRepeatTimerWithDelay(1000, 1000, moveSprite);
end
