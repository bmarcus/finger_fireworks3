------------------
--[[
CBEffects ParticleCollisions library

A library I wrote to check particle collisions.

The collision checking functions were pulled from two sources - Horacebury's math library for the polygon one, and Rakoonic's shape collision checking for the others.
--]]
------------------

local ParticleCollisions={}

local function pointInPolygon( points, dot )
	local i, j = #points, #points
	local oddNodes = false
	for i=1, #points do
		if ((points[i].y < dot.y and points[j].y>=dot.y or points[j].y< dot.y and points[i].y>=dot.y) and (points[i].x<=dot.x or points[j].x<=dot.x)) then
			if (points[i].x+(dot.y-points[i].y)/(points[j].y-points[i].y)*(points[j].x-points[i].x)<dot.x) then
				oddNodes = not oddNodes
			end
		end
		j = i
	end
 
	return oddNodes
end

local function pointInRect( pointX, pointY, left, top, width, height )
	if pointX >= left and pointX <= left + width and pointY >= top and pointY <= top + height then 
		return true
	else 
		return false 
	end
end

local function pointInCircle( pointX, pointY, centerX, centerY, radius)
	local dX, dY = pointX - centerX, pointY - centerY
	if dX * dX + dY * dY <= radius * radius then 
		return true
	else 
		return false 
	end
end

local function createCollisionGroup(params)
	local cf={}
	
	cf.onCollision=params.onCollision or function() end
	cf.shape=params.shape or "rect"
	
	cf.x=params.x or display.contentCenterX
	cf.y=params.y or display.contentCenterY
	
	cf.rectLeft=params.rectLeft or 0
	cf.rectTop=params.rectTop or 0
	cf.rectWidth=params.rectWidth or 100
	cf.rectHeight=params.rectHeight or 100
	cf.radius=params.radius or 200
	cf.points=params.points or {0, 0, 500, 500, 500, 0}
	cf.polygon=formatForPolygon(cf, cf.points)
	cf.targetPhysics=params.targetPhysics
	cf.singleEffect=params.singleEffect or false
	
	local function checkCollisions()
		for i=cf.targetPhysics.p, cf.targetPhysics.o do
			if cf.targetPhysics.objects[i] then
				if cf.singleEffect==true then
					if cf.targetPhysics.objects[i].ParticleCollision==false then
						cf.targetPhysics.objects[i].ParticleCollision=true
						if cf.shape=="rect" then
							if pointInRect(cf.targetPhysics.objects[i].x, cf.targetPhysics.objects[i].y, cf.rectLeft+cf.x, cf.rectTop+cf.y, cf.rectWidth, cf.rectHeight) then
								cf.onCollision(cf.targetPhysics.objects[i], cf)
							end
						elseif cf.shape=="circle" then
							if pointInCircle(cf.targetPhysics.objects[i].x, cf.targetPhysics.objects[i].y, cf.x, cf.y, cf.radius) then
								cf.onCollision(cf.targetPhysics.objects[i], cf)
							end
						elseif cf.shape=="polygon" then
							cf.polygon=formatForPolygon(cf, cf.points)
							if pointInPolygon(cf.polygon, cf.targetPhysics.objects[i]) then
								cf.onCollision(cf.targetPhysics.objects[i], cf)
							end
						end
					end
				else
					if cf.shape=="rect" then
						if pointInRect(cf.targetPhysics.objects[i].x, cf.targetPhysics.objects[i].y, cf.rectLeft+cf.x, cf.rectTop+cf.y, cf.rectWidth, cf.rectHeight) then
							cf.onCollision(cf.targetPhysics.objects[i], cf)
						end
					elseif cf.shape=="circle" then
						if pointInCircle(cf.targetPhysics.objects[i].x, cf.targetPhysics.objects[i].y, cf.x, cf.y, cf.radius) then
							cf.onCollision(cf.targetPhysics.objects[i], cf)
						end
					elseif cf.shape=="polygon" then
						cf.polygon=formatForPolygon(cf, cf.points)
						if pointInPolygon(cf.polygon, cf.targetPhysics.objects[i]) then
							cf.onCollision(cf.targetPhysics.objects[i], cf)
						end
					end
				end
			end
		end
	end
	cf.enterFrame=checkCollisions
	
	function cf.start()
		Runtime:addEventListener("enterFrame", cf)
	end
	
	function cf.stop()
		Runtime:removeEventListener("enterFrame", cf)
	end
	
	function cf.cancel()
		Runtime:removeEventListener("enterFrame", cf)
		for k, v in pairs(cf) do
			cf[k]=nil
		end
		cf=nil
		return true
	end
	
	return cf
end

ParticleCollisions.createCollisionGroup=createCollisionGroup
return ParticleCollisions
