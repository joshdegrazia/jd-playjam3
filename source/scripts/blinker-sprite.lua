import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"

local sprites = {}

class("BlinkerSprite").extends(Object);

--[[

Composite sprite object using a blinker to flicker between two
frames of animation. Requires an image table with two frames and assumes
frames 1 and 2 to be used.

Must call BlinkerSprite.updateAll() in the main loop for any animations to play.

]]
function BlinkerSprite:init(imageTable, blinker)
	assert(imageTable)
	self.imageTable = imageTable;
	
	self.sprite = playdate.graphics.sprite.new(imageTable:getImage(1));
	self.sprite:add();

	self.blinker = blinker or playdate.graphics.animation.blinker.new(200, 200);
	self.blinkerValue = self.blinker.on;
    self.blinker:startLoop();

	table.insert(sprites, self);
end

function BlinkerSprite:update()
    if self.blinker.on ~= self.blinkerValue then
        self.blinkerValue = self.blinker.on; 

        if self.blinker.on then
            self.sprite:setImage(self.imageTable:getImage(1));
        else
            self.sprite:setImage(self.imageTable:getImage(2));
        end
    end
end

function BlinkerSprite.updateAll()
    for _, o in ipairs(sprites) do
        o:update();
    end
end

return BlinkerSprite