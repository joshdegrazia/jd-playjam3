import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"
import "CoreLibs/timer"

local gfx = playdate.graphics

class("BlinkerSprite").extends(gfx.sprite);

--[[

Composite sprite object using a blinker to flicker between two
frames of animation. Requires an image table with two frames and assumes
frames 1 and 2 to be used.

]]
function BlinkerSprite:init(spritePath, blinker)
    BlinkerSprite.super.init(self);
    self.imageTable = playdate.graphics.imagetable.new(spritePath);
    assert(self.imageTable);
	
    self:setImage(self.imageTable:getImage(1));
    self:setCollideRect(0,0, self:getSize());
    self:setGroups(2); -- enemy sprites are collision group 2
    self:setCollidesWithGroups(3); -- railgun
    self:add();

    self.blinker = blinker or playdate.graphics.animation.blinker.new(200, 200);
    self.blinkerValue = self.blinker.on;
    self.blinker:startLoop();
    self.timer = nil;
end

function BlinkerSprite:remove()
    if self.timer then
        self.timer:remove();
    else
        print("UH OH BIG OOPSIE");
    end

    BlinkerSprite.super.remove(self);
end

function BlinkerSprite:update()
    BlinkerSprite.super.update(self);
    if self.blinker.on ~= self.blinkerValue then
        self.blinkerValue = self.blinker.on; 

        if self.blinker.on then
            self:setImage(self.imageTable:getImage(1));
        else
            self:setImage(self.imageTable:getImage(2));
        end
    end
end