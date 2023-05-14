import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"

import "gear"
import "darkness"

local center = playdate.geometry.vector2D.new(200, 120);

class("Flashlight").extends(Object)

-- the "width" of the flashlight (in degrees).
local width = 30;

-- the length of the triangle we create. should be
-- big enough to go off screen.
local flashlightSize = 300;

-- draws a small circle near the player to denote their vision
local nearbyRadius = 30;

function Flashlight:init()
	self.rotation = 0;
	self.enabled = false;

	Darkness.registerLightSource(self);
end

function Flashlight:onCranked(c, ac)
	if not self.enabled then
		return;
	end

	self.rotation += c;
end

function Flashlight:setEnabled(enabled)
	if not enabled then
		self.rotation = 0
	end

	self.enabled = enabled;
end

function Flashlight:drawLight()
	if not self.enabled then
		return;
	end

	local left = playdate.geometry.vector2D.newPolar(flashlightSize, self.rotation + width/2);
	assert(left);
	left:addVector(center);

	local right = playdate.geometry.vector2D.newPolar(flashlightSize, self.rotation - width/2);
	assert(right);
	right:addVector(center);

	playdate.graphics.fillCircleAtPoint(center.x, center.y, nearbyRadius);
	playdate.graphics.fillTriangle(center.x, center.y, left.x, left.y, right.x, right.y)
end

return Flashlight