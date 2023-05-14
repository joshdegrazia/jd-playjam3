import "CoreLibs/object"
import "CoreLibs/sprites"

import "bullet"
import "darkness"

class("Railgun").extends(Object);

-- the center of the screen
local center = playdate.geometry.vector2D.new(200, 120);

-- size of the gun to draw
local length = 20;
local width = 8;

function Railgun:init()
    self.rotation = 0;
    self.enabled = false;
    self.hurtbox = playdate.graphics.sprite.new();
    self.hurtbox:setCollideRect(-15,-15, 30, 30)
    self.hurtbox:setGroups(3); -- player is group 3
    self.hurtbox:setCollidesWithGroups(2); -- enemy sprites are collision group 2
    self.hurtbox:moveTo(200,120);
    self.hurtbox:add();
end

function Railgun:setEnabled(enabled, score)
    if not enabled then
        self.rotation = 0;
    end
    self.score = score
   
    self.enabled = enabled;
end

function Railgun:onCranked(c, ac)
    if not self.enabled then
        return
    end

    self.rotation += c;
end

function Railgun:update()
    if not self.enabled then
        return;
    end

    -- draw our beautiful gun
    local direction = playdate.geometry.vector2D.newPolar(length, self.rotation);
    assert(direction);

    local gunEdge = center + direction;
    assert(gunEdge);

    playdate.graphics.setLineWidth(width);
    playdate.graphics.drawLine(center.x, center.y, gunEdge.x, gunEdge.y);

    -- if applicable, spawn ourselves a bullet
    if (playdate.buttonJustPressed(playdate.kButtonA)) then
        Bullet(gunEdge, direction, self.score);
    end
end

return Railgun