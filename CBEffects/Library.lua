------------------
--[[
CBEffects library

This is the main CBEffects library.
--]]
------------------

local CBEffects={}

local masterPresets=require("CBEffects.ParticlePresets")
require("CBEffects.ParticleHelper")
local masterPhysics=require("CBEffects.ParticlePhysics")
local masterCollisions=require("CBEffects.ParticleCollisions")

local function VentGroup(params)
	local master={x=display.contentCenterX, y=display.contentCenterY}
	local vent={}
	local field={}
	local titleReference={}
	
	local numVents=#params
		
	for i=1, numVents do
		vent[i]={}
		vent[i].particle={}
		
		local velAngles={}
		local e=1
		
		local params=params
		local preset=masterPresets.vents[params[i].preset] or masterPresets.vents.default
		
		local par=params[i] or {}
		local pPar=preset

		local build           = fnn( par.build, pPar.build, function()return display.newRect(0, 0, 10, 10) end )
		local color           = fnn( par.color, pPar.color, {{255, 255, 255}} )
		
		local emitDelay       = fnn( par.emitDelay, pPar.emitDelay, 500 )
		local perEmit         = fnn( par.perEmit, pPar.perEmit, 5 )
		local emissionNum     = fnn( par.emissionNum, pPar.emissionNum, 50 )
		emissionNum = math.abs(math.round(emissionNum))

		local lifeSpan	      = fnn( par.lifeSpan, pPar.lifeSpan, 1000 )
		local alpha           = fnn( par.alpha, pPar.alpha, 1)
		local startAlpha      = fnn( par.startAlpha, pPar.startAlpha, 0 )
		local endAlpha        = fnn( par.endAlpha, pPar.endAlpha, 0 )
		local lifeStart       = fnn( par.lifeStart, pPar.lifeStart, 1000)
		local fadeInTime      = fnn( par.fadeInTime, pPar.fadeInTime, 500 )
		local onCreation      = fnn( par.onCreation, pPar.onCreation, function()end )
		local onDeath	      	= fnn( par.onDeath, pPar.onDeath, function()end )
		local propertyTable   = fnn( par.propertyTable, pPar.propertyTable, {} )
		local scale						= fnn( par.scale, pPar.scale, 1 )
		
		local parPhysics      = par.physics or {}
		local pParPhysics     = pPar.physics
		
		local linearDamping   = fnn( parPhysics.linearDamping, pParPhysics.linearDamping, 0 )
		local density         = fnn( parPhysics.density, pParPhysics.density, 1 )
		local velocity        = fnn( parPhysics.velocity, pParPhysics.velocity, 15 )
		local angularVelocity = fnn( parPhysics.angularVelocity, pParPhysics.angularVelocity, 0 )
		local angularDamping  = fnn( parPhysics.angularDamping, pParPhysics.angularDamping, 0 )
		local sizeX           = fnn( parPhysics.sizeX, pParPhysics.sizeX, 0.01 )
		local sizeY           = fnn( parPhysics.sizeY, pParPhysics.sizeY, 0.01 )
		local maxX            = fnn( parPhysics.maxX, pParPhysics.maxX, 3 )
		local maxY            = fnn( parPhysics.maxY, pParPhysics.maxY, 3 )
		local minX            = fnn( parPhysics.minX, pParPhysics.minX, 0.1 )
		local minY            = fnn( parPhysics.minY, pParPhysics.minY, 0.1 )
		local velFunction     = fnn( parPhysics.velFunction, pParPhysics.velFunction, function()end )
		local useFunction     = fnn( parPhysics.useFunction, pParPhysics.useFunction, false )
		
		local autoAngle       = fnn( parPhysics.autoAngle, pParPhysics.autoAngle, false )
		local angles          = fnn( parPhysics.angles, pParPhysics.angles, {1})

		local gravX           = fnn( parPhysics.gravityX, pParPhysics.gravityX, 0 )
		local gravY           = fnn( parPhysics.gravityY, pParPhysics.gravityY, 9.8 )
		
		local positionType    = fnn( par.positionType, pPar.positionType, "alongLine")
		
		local point1          = fnn( par.point1, pPar.point1, {0,0} )
		local point2          = fnn( par.point2, pPar.point2, {500, 0} )
		
		local posRadius       = fnn( par.posRadius, pPar.posRadius, 10 )
		local posInner        = fnn( par.posInner, pPar.posInner, 1 )
		
		local rectLeft        = fnn( par.rectLeft, pPar.rectLeft, 0 )
		local rectTop         = fnn( par.rectTop, pPar.rectTop, 0 )
		local rectWidth       = fnn( par.rectWidth, pPar.rectWidth, 50 )
		local rectHeight      = fnn( par.rectHeight, pPar.rectHeight, 50 )
		
		local rotation        = par.rotation or {}
		local pRotation       = pPar.rotation
		
		local towardVel       = fnn( rotation.towardVel, pRotation.towardVel, false )
		local offset          = fnn( rotation.offset, pRotation.offset, 0 )
		
		local pointTable      = pointsAlongLine(point1[1]*scale, point1[2]*scale, point2[1]*scale, point2[2]*scale)
		
		if ( autoAngle ) then
			for i=1, #angles do
				for i=angles[i][1], angles[i][2], 0.5 do
					velAngles[#velAngles+1]=forcesByAngle(velocity, i)
				end
			end
		else
			for i=1, #angles do
				velAngles[#velAngles+1]=forcesByAngle(velocity, angles[i])
			end
		end
		
		local pPhysics=masterPhysics.createPhysics()
		pPhysics.start()
		pPhysics.setGravity(gravX, gravY)
		
		vent[i].x, vent[i].y=par.x or pPar.x, par.y or pPar.y	
		vent[i].velAngles, vent[i].angles, vent[i].e, vent[i].pPhysics, vent[i].color, vent[i].emitDelay, vent[i].perEmit, vent[i].emissionNum, vent[i].lifeSpan, vent[i].alpha, vent[i].startAlpha, vent[i].endAlpha, vent[i].onCreation, vent[i].onDeath, vent[i].propertyTable, vent[i].scale, vent[i].linearDamping, vent[i].density, vent[i].velocity, vent[i].velFunction, vent[i].useFunction, vent[i].angularVelocity, vent[i].angularDamping, vent[i].sizeX, vent[i].sizeY, vent[i].maxX, vent[i].maxY, vent[i].minX, vent[i].minY, vent[i].positionType, vent[i].point1, vent[i].point2, vent[i].posRadius, vent[i].posInner, vent[i].towardVel, vent[i].offset, vent[i].pointTable, vent[i].rectLeft, vent[i].rectTop, vent[i].rectWidth, vent[i].rectHeight, vent[i].lifeStart, vent[i].fadeInTime=velAngles, angles, e, pPhysics, color, emitDelay, perEmit, emissionNum, lifeSpan, alpha, startAlpha, endAlpha, onCreation, onDeath, propertyTable, scale, linearDamping, density, velocity, velFunction, useFunction, angularVelocity, angularDamping, sizeX, sizeY, maxX, maxY, minX, minY, positionType, point1, point2, posRadius, posInner, towardVel, offset, pointTable, rectLeft, rectTop, rectWidth, rectHeight, lifeStart, fadeInTime
		vent[i].isActive=par.isActive or pPar.isActive
		vent[i].title=fnn( par.title, pPar.title, "vent" )
		titleReference[vent[i].title]=vent[i]
		
		vent[i].emit=function()
			for l=1, vent[i].perEmit do
				vent[i].particle[vent[i].e]=build()
				local p=vent[i].particle[vent[i].e]
				vent[i].e=vent[i].e+1
				pPhysics.addBody(p, "dynamic", {density=vent[i].density*vent[i].scale, xbL=vent[i].maxX*vent[i].scale, ybL=vent[i].maxY*vent[i].scale, xbS=vent[i].minX*vent[i].scale, ybS=vent[i].minY*vent[i].scale, sizeX=vent[i].sizeX*vent[i].scale, sizeY=vent[i].sizeY*vent[i].scale, rotateToVel=vent[i].towardVel, offset=vent[i].offset})
				p.prevX, p.prevY=p.x, p.y
				p.ParticleCollision=false

				p.alpha=vent[i].startAlpha
				
				p.width, p.height=p.width*vent[i].scale, p.height*vent[i].scale
				
				p.linearDamping=vent[i].linearDamping*vent[i].scale
				p.angularDamping=vent[i].angularDamping
				
				p.n=vent[i].e-1
								
				if type(vent[i].angularVelocity)=="number" then
					p.angularVelocity=vent[i].angularVelocity
				elseif type(vent[i].angularVelocity)=="function" then
					p.angularVelocity=vent[i].angularVelocity()
				end
				
				if type(vent[i].lifeSpan)=="number" then
					p.lifeSpan=vent[i].lifeSpan
				elseif type(vent[i].lifeSpan)=="function" then
					p.lifeSpan=vent[i].lifeSpan()
				end
				
				if type(vent[i].lifeStart)=="number" then
					p.lifeStart=vent[i].lifeStart
				elseif type(vent[i].lifeStart)=="function" then
					p.lifeStart=vent[i].lifeStart()
				end
				
				for k, v in pairs(vent[i].propertyTable) do
					p[k]=vent[i].propertyTable[k]
				end
				
				if vent[i].useFunction==true then
					local xVel, yVel=vent[i].velFunction()
					p:setLinearVelocity(xVel*vent[i].scale, yVel*vent[i].scale)
				else
					p.angleTable=either(vent[i].velAngles)
					p:setLinearVelocity(p.angleTable.x*vent[i].scale, p.angleTable.y*vent[i].scale)
				end
				
				if "inRadius"==vent[i].positionType then
					p.x, p.y=inRadius(vent[i].x, vent[i].y, vent[i].posRadius*vent[i].scale, vent[i].posInner*vent[i].scale)
				elseif "alongLine"==vent[i].positionType then
					p.x, p.y=unpack(either(vent[i].pointTable))
				elseif "inRect"==vent[i].positionType then
					p.x, p.y=inRect(vent[i].x, vent[i].y, vent[i].rectLeft*vent[i].scale, vent[i].rectTop*vent[i].scale, vent[i].rectWidth*vent[i].scale, vent[i].rectHeight*vent[i].scale)
				elseif "atPoint"==vent[i].positionType then
					p.x, p.y=vent[i].x, vent[i].y
				elseif type(vent[i].positionType)=="function" then
					p.x, p.y=vent[i].positionType()
				end
				
				if p["setFillColor"] then
					p.physicsColor=p["setFillColor"]
					if type(vent[i].color)=="table" then
						local pColor=either(vent[i].color)
						p.colorSet={r=pColor[1] or 0, g=pColor[2] or pColor[1], b=pColor[3] or pColor[1], a=pColor[4] or 255}
						p:setFillColor(unpack(pColor))
						p.colorChange=function(colorTo, time, delay, trans)
							if colorTo then
								p.colorTrans=transition.to(p.colorSet, {r=colorTo[1] or p.colorSet.r, g=colorTo[2] or p.colorSet.g, b=colorTo[3] or p.colorSet.b, a=colorTo[4] or p.colorSet.a, time=time or 1000, delay=delay or 0, transition=trans or easing.linear})
							end
						end
					elseif type(vent[i].color)=="function" then
						p:setFillColor(vent[i].color())
					end
				elseif p["setTextColor"] then
					p.physicsColor=p["setTextColor"]
					if type(vent[i].color)=="table" then
						local pColor=either(vent[i].color)
						p.colorSet={r=pColor[1] or 0, g=pColor[2] or pColor[1], b=pColor[3] or pColor[1], a=pColor[4] or 255}
						p:setTextColor(unpack(pColor))
						p.colorChange=function(colorTo, time, delay, trans)
							if colorTo then
								p.colorTrans=transition.to(p.colorSet, {r=colorTo[1] or p.colorSet.r, g=colorTo[2] or p.colorSet.g, b=colorTo[3] or p.colorSet.b, a=colorTo[4] or p.colorSet.a, time=time or 1000, delay=delay or 0, transition=trans or easing.linear})
							end
						end
					elseif type(vent[i].color)=="function" then
						p:setTextColor(vent[i].color())
					end
				end
				
				p.kill=function()
					vent[i].onDeath(vent[i].particle[p.n], vent[i])
					if vent[i].particle[p.n].colorTrans then 
						transition.cancel(vent[i].particle[p.n].colorTrans) 
					end 
					vent[i].pPhysics.removeBody(vent[i].particle[p.n])
					display.remove(vent[i].particle[p.n]) 
					vent[i].particle[p.n]=nil
				end
				
				p.inTrans=transition.to(p, {alpha=vent[i].alpha, time=vent[i].fadeInTime}) 
				p.trans=transition.to(p, {alpha=vent[i].endAlpha, time=p.lifeSpan, delay=p.lifeStart+vent[i].fadeInTime, onComplete=p.kill})
				
				vent[i].onCreation(vent[i].particle[p.n], vent[i])
			end
		end
		
	end
	
	function master:startMaster()
		for i=1, numVents do
			if vent[i] then
				if vent[i].isActive==true then
					vent[i].particleTimer=timer.performWithDelay(vent[i].emitDelay, vent[i].emit, vent[i].emissionNum)
				end
			end
		end
	end
	
	function master:emitMaster()
		for i=1, numVents do
			if vent[i] then
				if vent[i].isActive==true then
					vent[i].emit()
				end
			end
		end
	end
	
	function master:stopMaster()
		for i=1, numVents do
			if vent[i] then
				if vent[i].particleTimer then
					timer.cancel(vent[i].particleTimer)
				end
			end
		end
	end
	
	function master:start(t)
		local v=titleReference[t]
		if v then
			v.particleTimer=timer.performWithDelay(v.emitDelay, v.emit, v.emissionNum)
		end
	end
	
	function master:emit(t)
		local v=titleReference[t]
		if v then
			v.emit()
		end
	end
	
	function master:stop(t)
		local v=titleReference[t]
		if v then
			if v.particleTimer then
				timer.cancel(v.particleTimer)
			end
		end
	end
	
	function master:get(t)
		return titleReference[t]
	end
	
	function master:clean(t)
		local v=titleReference[t]
		if v then
			for i=1, v.e do
				if v.particle[i] then
					if v.particle[i].inTrans then
						transition.cancel(v.particle[i].inTrans)
					end
					
					if v.particle[i].trans then
						transition.cancel(v.particle[i].trans)
					end
					
					v.pPhysics.removeBody(v.particle[i])
					display.remove(v.particle[i])
					v.particle[i]=nil
				end
			end
			v.e=1
		else
			return false
		end
	end
	
	function master:destroy(t)
		local ve=titleReference[t]
		for i=1, ve.e do
			if ve.particle[i] and ve.particle[i].num then
				transition.cancel(ve.particle[i].trans)
				transition.cancel(ve.particle[i].inTrans)
				ve.pPhysics.removeBody(ve.particle[i])
				display.remove(ve.particle[i]) 
				ve.particle[i]=nil
			end
		end
		if ve.particleTimer then
			timer.cancel(ve.particleTimer)
			ve.particleTimer=nil
		end
		ve.pPhysics.cancel()
		for k, v in pairs(ve) do
			ve[k]=nil
		end
		ve=nil
		return true
	end
	
	function master:destroyMaster()
		for i=1, #vent do
			master:destroy(vent[i].title)
		end
		for k, v in pairs(master) do
			master[k]=nil
		end
		master=nil
	end

	return master
end

local function FieldGroup(params)
	local numFields=#params
	local field={}
	local titleReference={}
	
	for i=1, numFields do
		local fieldParams={}
		
		local preset=masterPresets.fields[params[i].preset] or masterPresets.fields["default"]
		
		fieldParams.shape							= fnn( params[i].shape, preset.shape, "rect")
		fieldParams.rectLeft					= fnn( params[i].rectLeft, preset.rectLeft, 0)
		fieldParams.rectTop						= fnn(params[i].rectTop, preset.rectTop, 0)
		fieldParams.rectWidth					= fnn(params[i].rectWidth, preset.rectWidth, 100)
		fieldParams.rectHeight				= fnn(params[i].rectHeight, preset.rectHeight, 100)
		fieldParams.x, fieldParams.y	= fnn(params[i].x, preset.x, 0), fnn(params.y, preset.y, 0)
		fieldParams.radius						= fnn(params[i].radius, preset.radius, 50)
		fieldParams.points						= fnn(params[i].points, preset.points, {0, 0, 500, 500, 500, 0})
		fieldParams.onCollision				= fnn(params[i].onCollision, preset.onCollision, function()end)
		fieldParams.singleEffect		 	= fnn(params[i].singleEffect, preset.singleEffect, false)
		
		local targetVent=params[i].targetVent
		fieldParams.targetPhysics=targetVent.pPhysics
		
		field[i]=masterCollisions.createCollisionGroup(fieldParams)
		field[i].title								= fnn(params[i].title, preset.title, "field")
		titleReference[field[i].title]=field[i]
	end
	
	function field:start(t)
		if titleReference[t] then
			titleReference[t].start()
		end	
	end
	
	function field:stop(t)
		if titleReference[t] then
			titleReference[t].stop()
		end
	end
	
	function field:destroy(t)
		if titleReference[t] then
			titleReference[t].cancel()
			titleReference[t]=nil
		end
	end
	
	function field:startMaster()
		for i=1, #field do
			field[i].start()
		end
	end
	
	function field:stopMaster()
		for i=1, #field do
			field[i].stop()
		end
	end
	
	function field:destroyMaster()
		for i=1, #field do
			field:destroy(field[i].title)
		end
		for k, v in pairs(field) do
			field[k]=nil
		end
		field=nil
	end
	
	function field:get(t)
		return titleReference[t]
	end
	
	return field
end

CBEffects.VentGroup=VentGroup
CBEffects.FieldGroup=FieldGroup
return CBEffects