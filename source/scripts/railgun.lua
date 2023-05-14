import "CoreLibs/object"

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
end

function Railgun:setEnabled(enabled)
    if not enabled then
        self.rotation = 0;
    end
   
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
        Bullet(gunEdge, direction);
    end
end

return Railgun