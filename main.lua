--[[
        This is the file called by Corona SDK first.
--]]
local _lifeStart = 1200
local _lifeSpan = 100
local touchedX 
local touchedY

local CBE=require("CBEffects.Library")

local function createParticle()
	local CBObject=CBE.VentGroup{}
    CBObject=CBE.VentGroup{
		{}
    }
---[[
	CBObject=CBE.VentGroup{
		{
		--preset="flame"
		x=touchedX,
		y=touchedY,
        title="confetti",
        lifeStart=_lifeStart,
        lifeSpan=_lifeSpan,
        endAlpha=0,
        posRadius=50,
        --[[
        build = function()
        	local glass = display.newImageRect("images/glass" .. math.random(1) .. ".png",20,7)
        	--local glass = display.newImageRect("images/snoop1.png",50,46)
        	return glass
        end,
--]]
        --[[
        build=function()
        	local myCircle = display.newCircle(100,100, math.random(30) )
				myCircle:setFillColor(128,128,128)
				myCircle.strokeWidth = 5
                myCircle:setStrokeColor(128,0,0) 
       		return myCircle
        end,   --]]
        ---[[
        build=function()
                local width=math.random(5, 15)
                return display.newRect(0, 0, width, 2)
        end, --]]
       --color={{255, 255, 0}, {255, 0, 0}, {0, 0, 255}},
        color={{math.random(255), math.random(255), 0}, {math.random(255), 0, 0}, {0, 0, math.random(255)}},
        emitDelay=500,
        perEmit=20,
        
        physics={
                velocity=15,
                gravityY = 25,
                angles={
                        {0, 360}
                }
        },
        rotation={
                towardVel=true,
                offset=90
        }
	}
}
return CBObject
end 

--[[  works
local CBObject=CBE.new{
	{
--preset="flame"


        title="confetti",
        lifeStart=1200,
        lifeSpan=100,
        endAlpha=0,
        posRadius=5,
        build=function()
                local width=math.random(8, 25)
                return display.newRect(0, 0, width, 8)
        end,
        --color={{255, 255, 0}, {255, 0, 0}, {0, 0, 255}},
        color={{math.random(255), math.random(255), 0}, {math.random(255), 0, 0}, {0, 0, math.random(255)}},
        emitDelay=500,
        perEmit=10,
        
        physics={
                velocity=5,
                gravityY=15,
                angles={
                        {0, 180}
                }
        },
        rotation={
                towardVel=true,
                offset=90
        }
	}
}
 ************************************WORKS
 --]]
local function Explode (event)
	touchedX = event.x
	touchedY = event.y
	local CBObject = createParticle()
	print (event.x .. ", " .. event.y)
	print(CBObject.x ..", " .. CBObject.y)
	CBObject.x = event.x
	CBObject.y = event.y
		print(CBObject.x ..", " .. CBObject.y)
	CBObject:start("confetti")
	CBObject:emit("confetti")
	CBObject:stop("confetti")
end

Runtime:addEventListener ( "tap", Explode )