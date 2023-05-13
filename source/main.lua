import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"

import "scripts/blinker-sprite"

local path = "assets/sprites/"

local noMaidens = BlinkerSprite(path .. "no-maidens");
noMaidens.sprite:moveTo(200, 120);

local wizz = BlinkerSprite(path .. "wizz");
wizz.sprite:moveTo(200, 140);

local lilguy = BlinkerSprite(path .. "lilguy");
lilguy.sprite:moveTo(200, 160);

local locke = BlinkerSprite(path .. "locke");
locke.sprite:moveTo(220, 120);

local mappy = BlinkerSprite(path .. "mappy");
mappy.sprite:moveTo(220, 140);

local mimicat = BlinkerSprite(path .. "mimicat");
mimicat.sprite:moveTo(220, 160);

local seele = BlinkerSprite(path .. "seele");
seele.sprite:moveTo(240, 120);

local sneque = BlinkerSprite(path .. "sneque");
sneque.sprite:moveTo(240, 140);

local cupid = BlinkerSprite(path .. "cupid");
cupid.sprite:moveTo(240, 160);

function playdate.update()
	playdate.graphics.animation.blinker.updateAll();
	playdate.graphics.sprite.update();
	BlinkerSprite.updateAll();
end