import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/animation"

local center = playdate.geometry.vector2D.new(200, 120);
local shadeCanvas = playdate.graphics.image.new(400, 240, playdate.graphics.kColorBlack);
shadeCanvas:addMask();

class("Flashlight").extends(Object)

-- the "width" of the flashlight (in degrees).
local width = 30;
function Flashlight.setWidth(v)
    width = v;
end

-- the length of the triangle we create. should be
-- big enough to go off screen.
local flashlightSize = 300;
local nearbyRadius = 30;

function Flashlight.update()
	shadeMask = shadeCanvas:getMaskImage()
	shadeCanvas:clearMask(1);
	playdate.graphics.pushContext(shadeMask)
		
		local left = playdate.geometry.vector2D.newPolar(flashlightSize, playdate.getCrankPosition() + width/2);
		assert(left);
		left:addVector(center);

		local right = playdate.geometry.vector2D.newPolar(flashlightSize, playdate.getCrankPosition() - width/2);
		assert(right);
		right:addVector(center);

        playdate.graphics.fillCircleAtPoint(center.x, center.y, nearbyRadius);
		playdate.graphics.fillTriangle(center.x, center.y, left.x, left.y, right.x, right.y)
	playdate.graphics.popContext()

	shadeCanvas:drawBlurred(0, 0, 3, 4, playdate.graphics.image.kDitherTypeBayer2x2);
end

return Flashlight