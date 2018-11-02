------------------
--[[
CBEffects ParticlePreset Library

Vents
It may seem sparse, but I've created all of the vents I thought people would need the most - you can always build on them after loading them.

DEFAULT - Makes white squares that move radially
HYPERSPACE - Uses "towardVel" option to make white rectangles that move outwardly and grow
PIXELWHEEL - Uses a "velFunction" to make a rotating "wagon wheel"
CIRCLES - A generic, float-up-from-the-bottom vent
EMBERS - Embers that rise upwards
FLAME - Flame effect
SMOKE - Smoke effect
STEAM - White clouds that launch upwards, like an enormous teakettle.
WATERFALL - Waterfall effect
SPARKS - Makes particles that move radially but has y-gravity.
RAIN - Good for anything falling from the sky
CONFETTI - Colorful rectangles that float downwards
SNOW - A generic snow effect
BEAMS - Non-moving red and blue rectangles that radiate from the center


Fields
Preset fields for the FieldGroup function.

DEFAULT - Circular collision shape with radius of 100. Pulls particles inward.
OUT - Circular collision shape with radius of 100. Ejects particles outward.
COLORCHANGE - Demonstrates how to do color change with a collision.

--]]
------------------

local ParticlePresets={}
local mrand=math.random

ParticlePresets.vents={}
ParticlePresets.fields={}

ParticlePresets.vents["default"]={title="default",x=display.contentCenterX,y=display.contentCenterY,isActive=true,build=buildDefault,color={{255,255,255}},emitDelay=5,perEmit=2,emissionNum=0,lifeSpan=1000,alpha=1,startAlpha=1,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=0,positionType="inRadius",posRadius=30,posInner=1,point1={1,1},point2={2,1},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=4,angularVelocity=0,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{0,360}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["hyperspace"]={title="hyperspace",isActive=true,build=buildHyperspace,x=display.contentCenterX,y=display.contentCenterY,color={{255,255,255}},emitDelay=100,perEmit=9,emissionNum=0,lifeSpan=1200,alpha=0.5,startAlpha=0,endAlpha=1,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=500,positionType="inRadius",posRadius=1,posInner=1,point1={100,display.contentHeight},point2={display.contentWidth-100,display.contentHeight-100},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=-0.1,density=1,velocity=-10,angularVelocity=0,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{0,360}},sizeX=0.1,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=true,offset=90}}

ParticlePresets.vents["pixelwheel"]={title="pixelwheel",isActive=true,build=buildPixelWheel,x=display.contentCenterX,y=display.contentCenterY,color={{120,120,255},{255,255,255}},emitDelay=100,perEmit=9,emissionNum=0,lifeSpan=200,alpha=1,startAlpha=1,endAlpha=1,onCreation=function(p)p.strokeWidth=10 p:setStrokeColor(0,0,255)end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=500,fadeInTime=0,positionType="inRadius",posRadius=1,posInner=1,point1={100,display.contentHeight},point2={display.contentWidth-100,display.contentHeight-100},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=0,angularVelocity=0,angularDamping=0,velFunction=velPixelWheel,useFunction=true,autoAngle=true,angles={{0,360}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["circles"]={title="circles",isActive=true,build=buildCircles,x=display.contentCenterX,y=display.contentCenterY+200,color={{0,0,255},{120,120,255},{0,0,255},{120,120,255},{0,0,255},{120,120,255},{255,0,0}},emitDelay=100,perEmit=4,emissionNum=0,lifeSpan=1000,alpha=1,endAlpha=0,startAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=300,positionType="alongLine",posRadius=30,posInner=1,point1={100,display.contentHeight},point2={display.contentWidth-100,display.contentHeight-100},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=10,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{75,105}},sizeX=-0.01,sizeY=-0.01,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["embers"]={title="embers",isActive=true,build=buildEmbers,x=display.contentCenterX,y=display.contentCenterY+200,color={{255,255,0},{255,255,0},{255,255,0},{255,255,0},{255,0,0}},emitDelay=100,perEmit=2,emissionNum=0,lifeSpan=1000,alpha=1,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=300,positionType="alongLine",posRadius=30,posInner=1,point1={100,display.contentHeight},point2={display.contentWidth-100,display.contentHeight},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=10,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{75,105}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["flame"]={title="flame",isActive=true,build=buildFlame,x=display.contentCenterX,y=display.contentCenterY+200,color={{255,255,0},{255,255,0},{255,255,0},{255,255,0},{200,200,0},{200,200,0},{255,0,0}},emitDelay=100,perEmit=10,emissionNum=0,lifeSpan=1000,alpha=1,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=500,fadeInTime=300,positionType="alongLine",posRadius=30,posInner=1,point1={300,display.contentHeight+100},point2={display.contentWidth-300,display.contentHeight+100},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0.2,density=1,velocity=15,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{75,105}},sizeX=0.03,sizeY=0.03,minX=0.1,minY=0.1,maxX=1000,maxY=1000,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["smoke"]={title="smoke",isActive=true,build=buildSmoke,x=display.contentCenterX,y=display.contentCenterY+200,color={{125},{100},{150},{80}},emitDelay=100,perEmit=8,emissionNum=0,lifeSpan=1200,alpha=1,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=700,positionType="alongLine",posRadius=30,posInner=1,point1={200,display.contentHeight-100},point2={display.contentWidth-200,display.contentHeight-100},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0.2,density=1,velocity=16,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{75,105}},sizeX=0.015,sizeY=0.015,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["steam"]={title="steam",isActive=true,build=buildSteam,x=display.contentCenterX,y=display.contentHeight,color={{255},{230},{200}},emitDelay=50,perEmit=10,emissionNum=0,lifeSpan=800,alpha=1,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=200,positionType="inRadius",posRadius=30,posInner=1,point1={100,display.contentHeight-100},point2={display.contentWidth-100,display.contentHeight-100},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=25,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{85,95}},sizeX=0.05,sizeY=0.05,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["waterfall"]={title="waterfall",isActive=true,build=buildSteam,x=display.screenOriginX,y=100,color={{255,255,255},{230,230,255},{222,222,255}, {230,255,255}},emitDelay=50,perEmit=5,emissionNum=0,lifeSpan=2000,alpha=1,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=200,positionType="inRadius",posRadius=30,posInner=1,point1={100,display.contentHeight-100},point2={display.contentWidth-100,display.contentHeight-100},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=5,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{0,0}},sizeX=0.03,sizeY=0.06,minX=0.1,minY=0.1,maxX=5,maxY=4,gravityX=0,gravityY=40},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["sparks"]={title="sparks",isActive=true,build=buildSparks,x=display.contentCenterX,y=display.contentCenterY,color={{255,255,255},{230,230,255}},emitDelay=1000,perEmit=6,emissionNum=0,lifeSpan=1000,alpha=1,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function(p,v)v.perEmit=math.random(5,15)end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=300,positionType="inRadius",posRadius=30,posInner=1,point1={100,display.contentHeight},point2={display.contentWidth-100,display.contentHeight},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=10,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{0,360}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=9.8},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["rain"]={title="rain",isActive=true,build=buildRain,x=display.contentCenterX,y=display.contentCenterY,color={{255,255,255},{230,230,255}},emitDelay=1,perEmit=6,emissionNum=0,lifeSpan=2000,alpha=0.3,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=300,positionType="alongLine",posRadius=30,posInner=1,point1={0,-10},point2={display.contentWidth+150,-10},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=20,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{250,260}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["confetti"]={title="confetti",isActive=true,build=buildConfetti,x=display.contentCenterX,y=display.contentCenterY,color={{255,0,0},{0,0,255},{255,255,0},{0,255,0}},emitDelay=1,perEmit=6,emissionNum=0,lifeSpan=50,alpha=1,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=1900,fadeInTime=100,positionType="alongLine",posRadius=30,posInner=1,point1={0,-10},point2={display.contentWidth+150,-10},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=10,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{200,340}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=9},rotation={towardVel=true,offset=0}}

ParticlePresets.vents["snow"]={title="snow",isActive=true,build=buildSnow,x=display.contentCenterX,y=display.contentCenterY,color={{255,255,255},{230,230,255}},emitDelay=1,perEmit=6,emissionNum=0,lifeSpan=2000,alpha=0.3,startAlpha=0,endAlpha=0,onCreation=function()end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=300,positionType="alongLine",posRadius=30,posInner=1,point1={0,-10},point2={display.contentWidth+150,-10},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=0,angularVelocity=0.04,angularDamping=0,velFunction=velSnow,useFunction=true,autoAngle=true,angles={{250,260}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}

ParticlePresets.vents["beams"]={title="beams",isActive=true,build=buildBeams,x=display.contentCenterX,y=display.contentCenterY,color={{255, 0, 0},{0, 0, 255}},emitDelay=1,perEmit=6,emissionNum=0,lifeSpan=2000,alpha=0.3,startAlpha=0,endAlpha=0,onCreation=function(p,v)p.rotation=angleBetween(p.x,p.y,v.x,v.y,90)end,onDeath=function()end,propertyTable={},scale=1.0,lifeStart=0,fadeInTime=300,positionType="inRadius",posRadius=30,posInner=1,point1={0,-10},point2={display.contentWidth+150,-10},rectLeft=0,rectTop=0,rectWidth=display.contentWidth,rectHeight=display.contentHeight,physics={linearDamping=0,density=1,velocity=0,angularVelocity=0.04,angularDamping=0,velFunction=velNil,useFunction=false,autoAngle=true,angles={{0,10}},sizeX=0,sizeY=0,minX=0.1,minY=0.1,maxX=100,maxY=100,gravityX=0,gravityY=0},rotation={towardVel=false,offset=0}}


ParticlePresets.fields["default"]={shape="circle",radius=100,x=display.contentCenterX,y=display.contentCenterY,innerRadius=1,rectLeft=0,rectTop=0,rectWidth=100,rectHeight=100,singleEffect=false,points={0,0,500,500,500,0},onCollision=function(p,f)p:applyForce(f.x-p.x, f.y-p.y)end}

ParticlePresets.fields["out"]={shape="circle",radius=100,x=display.contentCenterX,y=display.contentCenterY,innerRadius=1,rectLeft=0,rectTop=0,rectWidth=100,rectHeight=100,singleEffect=false,points={0,0,500,500,500,0},onCollision=function(p,f)p:applyForce(p.x-f.x, p.y-f.y)end}

ParticlePresets.fields["colorChange"]={shape="rect",radius=100,x=display.contentCenterX,y=display.contentCenterY,innerRadius=1,rectLeft=0,rectTop=0,rectWidth=512,rectHeight=1024,singleEffect=true,points={0,0,500,500,500,0},onCollision=function(p,f)p.colorChange({0, 0, 255}, 500, 0)end}

return ParticlePresets