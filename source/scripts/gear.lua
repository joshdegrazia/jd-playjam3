import "CoreLibs/object"

local gears = {}

class("Gear").extends(Object)

function Gear:init(maxSpeed, minSpeed, friction, crankFactor)
    self.rotation = 0;
    self.speed = 0;
    self.maxSpeed = maxSpeed;
    self.minSpeed = minSpeed;
    self.friction = friction;
    self.crankFactor = crankFactor;

    table.insert(gears, self);
end

function Gear:getRotation()
    return self.rotation;
end

function Gear:update()
	-- apply friction to reduce speed towards 0
	if self.speed > 0 then
		-- use max and min to avoid crossing back into negatives
		self.speed = math.max(0, self.speed - self.friction);
	elseif self.speed < 0 then
		self.speed = math.min(0, self.speed + self.friction)
	end

    self.rotation = self.rotation + self.speed;
end

function Gear:onCranked(c, ac)
    self.speed = math.min(math.max(self.speed + (ac * self.crankFactor), self.minSpeed), self.maxSpeed);
end

function Gear.updateAll()
    for _, g in ipairs(gears) do
        g:update();
    end
end

return Gear