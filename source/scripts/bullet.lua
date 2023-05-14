import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"

import "darkness"

local gfx = playdate.graphics
class("Bullet").extends(gfx.sprite)

local cullingRadius = 500;
local speed = 8;

local center = playdate.geometry.vector2D.new(200, 120);

-- Just takes a position and a velocity.
function Bullet:init(startPosition, direction, score)
    Bullet.super.init(self);
    self.position = startPosition;
    self.direction = direction:normalized();
    self.score = score;
    local img = playdate.graphics.image.new("assets/sprites/mon");
    assert(img);
    self:setImage(img);
    self:add();
    self:setGroups(1); -- bullets are collision group 1
    self:setCollidesWithGroups(2); -- enemy sprites are collision group 2
    self:setCollideRect(0,0, self:getSize());
    self:moveTo(self.position.x, self.position.y);

    self.lightSourceId = Darkness.registerLightSource(self);
    
    -- use a flag to only draw muzzle flare once upon creation
    self.drawMuzzleFlare = true;
end

local lightRadius = 15;
local muzzleFlareRadius = 40;
function Bullet:drawLight()
    if self.drawMuzzleFlare then
        playdate.graphics.fillCircleAtPoint(self.position.x, self.position.y, muzzleFlareRadius)
        self.drawMuzzleFlare = false;
    end

    playdate.graphics.fillCircleAtPoint(self.position.x, self.position.y, lightRadius)
end

function Bullet:remove()
    Darkness.deregisterLightSource(self.lightSourceId);
    Bullet.super.remove(self);
end

function Bullet:update()
    Bullet.super.update(self);
    self.position = self.position + (self.direction * speed);

    if (self.position - center):magnitude() > cullingRadius then
        self:remove();
    end

    local _, _, collisions, len = self:moveWithCollisions(self.position.x, self.position.y);
    if len ~= 0 then
        for _, collision in ipairs(collisions) do
            collision["other"]:remove();
        end
        self:remove();
        self.score["score"] = self.score["score"] + len;
    end
end