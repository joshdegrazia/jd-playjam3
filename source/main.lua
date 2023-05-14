import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"
import "CoreLibs/timer"

import "scripts/spawner"

playdate.timer.keyRepeatTimerWithDelay(1000, 1000, SpawnCupids);

function playdate.update()
	playdate.timer.updateTimers();
	playdate.graphics.animation.blinker.updateAll();
	playdate.graphics.sprite.update();
	BlinkerSprite.updateAll();
end