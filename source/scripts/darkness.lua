import "CoreLibs/object"
import "CoreLibs/graphics"

class("Darkness").extends(Object);

local shadeCanvas = playdate.graphics.image.new(400, 240, playdate.graphics.kColorBlack);
shadeCanvas:addMask();

local lightSources = {};
local id = 1;
function Darkness.registerLightSource(source)
    sourceId = id;
    id += 1;

    lightSources[sourceId] = source;
    return sourceId;
end

function Darkness.deregisterLightSource(sourceId)
    lightSources[sourceId] = nil;
end

function Darkness.update()
    shadeMask = shadeCanvas:getMaskImage()
	shadeCanvas:clearMask(1);
	playdate.graphics.pushContext(shadeMask)
    for _, l in pairs(lightSources) do
        l:drawLight();
    end
    playdate.graphics.popContext()

	shadeCanvas:drawBlurred(0, 0, 3, 4, playdate.graphics.image.kDitherTypeBayer2x2);
end

return Darkness