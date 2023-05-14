import "CoreLibs/timer"

import "scripts/blinker-sprite"

local path = "assets/sprites/"

function SpawnCupids()
    local randAngle = math.random()*math.pi*2;
    local spawnCircleRadius = 100;
    local x = math.cos(randAngle)*spawnCircleRadius+200; -- 200 is x axis center
    local y = math.sin(randAngle)*spawnCircleRadius+120; -- 120 is y axis center
	local blink = BlinkerSprite(path .. "cupid")
    blink.sprite:moveTo(x,y);
    function moveSprite()
        local x, _ = blink.sprite:getPosition();
        local angle = math.acos((x-200)/blink.dist)
        blink.dist = blink.dist - 10;
        local new_x = math.cos(angle)*blink.dist+200;
        local new_y = math.sin(angle)*blink.dist+120;
        blink.sprite:moveTo(new_x, new_y);
        print(new_x,new_y)
    end
    playdate.timer.keyRepeatTimerWithDelay(1000, 1000, moveSprite);
end
