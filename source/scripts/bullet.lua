import "CoreLibs/object"

class("Bullet").extends(Object)

local bullets = {}
local id = 1;
local cullingRadius = 500;
local speed = 8;
local trailLength = 5;

local center = playdate.geometry.vector2D.new(200, 120);

-- Just takes a position and a velocity.
function Bullet:init(startPosition, direction)
    self.position = startPosition;
    self.direction = direction:normalized();
    
    -- Note down our ID so we can cull the bullet later
    self.id = id;
    id = id + 1;

    bullets[self.id] = self;

    print("Created bullet with id " .. self.id);
end

function Bullet:update()
    self.position = self.position + (self.direction * speed);

    if (self.position - center):magnitude() > cullingRadius then
        bullets[self.id] = nil;
        return;
    end

    local trailPos = self.position - (self.direction * trailLength);

    playdate.graphics.setLineWidth(1);
    playdate.graphics.drawLine(self.position.x, self.position.y, trailPos.x, trailPos.y);
end

function Bullet.updateAll()
    for _, b in pairs(bullets) do
        b:update();
    end
end

return Bullet