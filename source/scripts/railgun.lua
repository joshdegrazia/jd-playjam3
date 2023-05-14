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
end

function Railgun:onCranked(c, ac)
    self.rotation += c;
end

function Railgun:update()

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