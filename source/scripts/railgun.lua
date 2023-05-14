import "CoreLibs/object"

import "bullet"

class("Railgun").extends(Object);

local center = playdate.geometry.vector2D.new(200, 120);
local length = 20;
local width = 8;

function Railgun.update()

    -- draw our beautiful gun
    local direction = playdate.geometry.vector2D.newPolar(length, playdate.getCrankPosition());
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