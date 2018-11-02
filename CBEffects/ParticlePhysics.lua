------------------
--[[
CBEffects ParticlePhysics library

Physics library I wrote for moving particles point-by-point, instead of transitions.
--]]
------------------

local ParticlePhysics={}

local function createPhysics()
	local physics={}
	physics.gravityX=0
	physics.gravityY=0
	physics.objects={}
	physics.fields={}
	
	physics.o=1
	physics.p=1
	
	physics.F=1
	physics.F2=1
	
	function physics.setGravity(x, y)
		physics.gravityX=x
		physics.gravityY=y
	end
	
	function physics.addBody(obj, bodyType, params)
		local obj=obj
		
		if type(bodyType)=="string" then
			bodyType=bodyType
		elseif type(bodyType)=="table" then
			params=bodyType
		end
		
		if params then
			obj.velX=params.velX or 0
			obj.velY=params.velY or 0
			obj.density=params.density or 1.0
			obj.linearDamping=params.linearDamping or 0
			obj.angularDamping=params.angularDamping or 0
			obj.angularVelocity=params.angularVelocity or 0
			obj.bodyType=bodyType or "dynamic"
			obj.sizeX=params.sizeX or 0
			obj.sizeY=params.sizeY or 0
			obj.xbS=params.xbS or 0.1
			obj.ybS=params.ybS or 0.1
			obj.xbL=params.xbL or 3
			obj.ybL=params.ybL or 3
			obj.rotateToVel=params.rotateToVel or false
			obj.offset=params.offset or 0
		else
			obj.velX=obj.velX or 0
			obj.velY=obj.velY or 0
			obj.density=obj.density or 1.0
			obj.linearDamping=obj.linearDamping or 0
			obj.angularDamping=obj.angularDamping or 0
			obj.angularVelocity=obj.angularVelocity or 0
			obj.bodyType=bodyType or "dynamic"
			obj.shrinkX=obj.sizeX or 0
			obj.shrinkY=obj.sizeY or 0
			obj.xbS=obj.xbS or 0.001
			obj.ybS=obj.ybS or 0.001
			obj.xbL=obj.xbL or 3
			obj.ybL=obj.ybL or 3
			obj.rotateToVel=obj.rotateToVel or false
			obj.offset=obj.offset or 0
		end
		
		physics.objects[physics.o]=obj
		obj.num=physics.o
		obj.prevX, obj.prevY=obj.x, obj.y
		
		physics.o=physics.o+1
			
		function obj:applyForce(x, y)
			obj.velX, obj.velY=obj.velX+((x/obj.density)/((obj.width+obj.height))), obj.velY+(y/obj.density)/(obj.width+obj.height)
		end
		
		function obj:setLinearVelocity(x, y)
			obj.velX, obj.velY=x, y
		end
		
		function obj:getLinearVelocity()
			return obj.velX, obj.velY
		end
		
		function obj:applyTorque(value)
			obj.angularVelocity=obj.angularVelocity+(value/obj.density)
		end
	end
	
	function physics.removeBody(n)
		if n and n.num and physics.objects[n.num] then
			physics.p=physics.p+1
			physics.objects[n.num]=nil
		end
	end
	
	local function physicsLoop()
		for i=physics.p, physics.o do
			if physics.objects[i] then
				local p=physics.objects[i]
				
				if p.colorSet then
					p:physicsColor(p.colorSet.r, p.colorSet.g, p.colorSet.b)
				end
				
				if p.density<=0 then
					p.density=1.0
				end
				
				if "dynamic"==p.bodyType then
					p.velX=p.velX+(physics.gravityX*(p.density/(p.width+p.contentHeight/2)))
					p.velY=p.velY+(physics.gravityY*(p.density/(p.width+p.contentHeight/2)))
				end
				
				if p.velX>0 then
					if p.velX-p.linearDamping>=0 then
						p.velX=p.velX-p.linearDamping
					else
						p.velX=0
					end
				else
					if p.velX+p.linearDamping<=0 then
						p.velX=p.velX+p.linearDamping
					else
						p.velX=0
					end
				end
				
				if p.velY>0 then
					if p.velY-p.linearDamping>=0 then
						p.velY=p.velY-p.linearDamping
					else
						p.velY=0
					end
				else
					if p.velY+p.linearDamping<=0 then
						p.velY=p.velY+p.linearDamping
					else
						p.velY=0
					end
				end
				
				p.x, p.y=p.x+p.velX, p.y+p.velY
				p.curX, p.curY=p.x, p.y
				
				if p.rotateToVel==true then
					p.rotation=angleBetween(p.prevX, p.prevY, p.curX, p.curY, p.offset)
				else
					p.rotation=p.rotation+p.angularVelocity
				end
				
				if p.angularVelocity>0 then
					if p.angularVelocity-p.angularDamping>=0 then
						p.angularVelocity=p.angularVelocity-p.angularDamping
					else
						p.angularVelocity=0
					end
				else
					if p.angularVelocity+p.angularDamping<=0 then
						p.angularVelocity=p.angularVelocity+p.angularDamping
					else
						p.angularVelocity=0
					end
				end
								
				if p.xScale<=p.xbL+p.sizeX and p.xScale>=p.xbS+p.sizeX then
					p.xScale=p.xScale+p.sizeX
				end
				
				if p.yScale<=p.ybL+p.sizeY and p.yScale>=p.ybS+p.sizeY then
					p.yScale=p.yScale+p.sizeY
				end
				
				p.prevX, p.prevY=p.x, p.y
				
				
			end
		end
	end
	physics.enterFrame=physicsLoop

	function physics.start()
		Runtime:addEventListener("enterFrame", physics)
	end
	
	function physics.pause()
		Runtime:removeEventListener("enterFrame", physics)
	end
	
	function physics:iterate()
		physicsLoop()
	end
	
	function physics.cancel()
		Runtime:removeEventListener("enterFrame", physicsLoop)
		for k, v in pairs(physics) do
			physics[k]=nil
		end
		physics=nil
		return true
	end
	
	return physics
end

ParticlePhysics.createPhysics=createPhysics
return ParticlePhysics