------------------
--[[
CBEffects ParticleHelper library

Includes a lot of helpful functions used by CBEffects.

If your function is in this library, thank you for it. I used a lot of people's functions I pulled out of libraries and the such.

If you see that I've changed your function, please note that I switched them around to be the most helpful for CBEffects.
--]]
------------------
local mrand=math.random
math.randomseed(os.time())

function wrapAddition(start, value, low, high)
	if start+value>high then
		local margin=(start+value)-(high)
		return low+margin
	else
		return start+value
	end
end

function formatForPolygon(obj, t)
	local polygon={}
	for i=1, #t, 2 do
		polygon[#polygon+1]={x=t[i]+obj.x, y=t[i+1]+obj.y}
	end
	return polygon
end

function fnn( ... ) 
	for i = 1, #arg do
		local theArg = arg[i]
		if(theArg ~= nil) then return theArg end
	end
	return nil
end

function pointInRect(x, y, left, top, width, height )
	if( x >= left and x <= left + width and y >= top and y <= top + height ) then 
	   return true
	else
		return false
	end
end

function angleBetween( srcX, srcY, dstX, dstY, offset )
   local angle = ( math.deg( math.atan2( dstY-srcY, dstX-srcX ) )+90 ) +offset
   if ( angle < 0 ) then angle = angle + 360 end
   return angle % 360
end

function either(table)
	if #table==0 then
		return nil
	else
		return table[mrand(#table)]
	end
end

function inRadius(x, y, radius, innerRadius)
	local X
	local Y
	local Radius=radius*radius
	if (innerRadius) then
		inRad=innerRadius*innerRadius
	end

	if (inRad) then
		repeat
			X = mrand(-radius, radius)
			Y = mrand(-radius, radius)
		until X*X+Y*Y<=Radius and X*X+Y*Y>=inRad
		finalX, finalY=x+X, y+Y
	else
		repeat
			X = mrand(-radius, radius)
			Y = mrand(-radius, radius)
		until X*X+Y*Y<=Radius
	end
		
	return finalX, finalY
end

function inRect(x, y, left, top, width, height)
	local X
	local Y
	repeat
		X, Y=mrand(left, left+width), mrand(top, top+height)
	until pointInRect(X, Y, left, top, width, height)==true
	return X, Y
end

function copyTable(t1, t2)
	for i=1, #t1 do
		t2[i]=t1[i]
	end
end

function lengthOf( a, b, c, d )
  local width, height = c-a, d-b
	return (width*width + height*height)^0.5
end

function pointsAlongLine(x1, y1, x2, y2)
	local points={}
	
	local diffX=x2-x1
	local diffY=y2-y1
		
	local x, y=x1, y1
	
	local distBetween=lengthOf(x1, y1, x2, y2)
	
	local addX, addY=diffX/distBetween, diffY/distBetween
	
	for i=1, distBetween do
		points[#points+1]={x, y}
		x, y=x+addX, y+addY
	end
	
	return points
end

function forcesByAngle(totalForce, angle)
  local forces = {}
  local radians = -math.rad(angle)
 
  forces.x = math.cos(radians) * totalForce
  forces.y = math.sin(radians) * totalForce
 
  return forces
end

local cloudTable={
	"CBEffects/cloud1.png",
	"CBEffects/cloud2.png",
	"CBEffects/cloud3.png",
	"CBEffects/cloud4.png",
	"CBEffects/cloud5.png"
}

function velNil()
	return 0, 0
end

local curAngle=1
function velPixelWheel()
	vel=forcesByAngle(20, curAngle)
	curAngle=curAngle+50
	return vel.x, vel.y
end

function buildDefault()
	return display.newRect(0, 0, 20, 20)
end

function buildHyperspace()
	local b=display.newRect(0, 0, 10, 10)
	b:setReferencePoint(display.CenterLeftReferencePoint)
	return b
end

function buildPixelWheel()
	return display.newRect(0, 0, 50, 50)
end

function buildCircles()
	local size=mrand(10, 60)
	return display.newImageRect("CBEffects/glowcircle.png", size, size)
end

function buildEmbers()
	local size=mrand(10, 20)
	return display.newImageRect("CBEffects/glowcirclefilled.png", size, size)
end

function buildFlame()
	local size=mrand(100, 300)
	return display.newImageRect(either(cloudTable), size, size)
end

function buildSmoke()
	local size=mrand(100, 200)
	return display.newImageRect(either(cloudTable), size, size)
end

function buildSteam()
	local size=mrand(50, 100)
	return display.newImageRect(either(cloudTable), size, size)
end

function buildSparks()
	return display.newCircle(0, 0, mrand(3, 6))
end

function buildRain()
	return display.newRect(0, 0, mrand(2,4), mrand(6,15))
end

function buildConfetti()
	local width=mrand(10, 15)
	local height=mrand(10, 15)
	return display.newRect(0, 0, width, height)
end

function buildSnow()
	local size=mrand(10,40)
	return display.newImageRect("CBEffects/glowcirclefilled.png", size, size)
end

function velSnow()
	return mrand(-1,1), mrand(10)
end

function buildBeams()
	local beam=display.newRect(0, 0, math.random(800), 20)
	beam:setReferencePoint(display.CenterLeftReferencePoint)
	return beam
end