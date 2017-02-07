local M = {}

local gfxFrameTick = 0
local Toggled = false
local Toggled2 = false
local Locked = false
local ccSpeed

local function updateGFX(dt)
	--smokestuff
	--toplel = electrics.values['throttle']
	--if(gfxFrameTick < toplel*2+1.1) then
	--	obj:addParticleByNodesRelative(ex1, ex4, -(toplel+1)*5, 7, 0, toplel+1)
	--end
	if gfxFrameTick > 7 then
		gfxFrameTick = 0
	end
	gfxFrameTick = gfxFrameTick + 1
	--difflock
	if input.keys['T'] then
		if not Toggled then
			Toggled = true
			Locked = not Locked	
			drivetrain.toggleDifferentialMode()
			if drivetrain.differentialMode == 0 then
				gui.message("Open differential")
				electrics.values['diff'] = 1
			else
				gui.message("Locked differential")
				electrics.values['diff'] = 0
			end
		end
	else
		Toggled = false
	end
	
	if input.keys['F']  and electrics.values['airspeed'] > 2 then
		ccSpeed = electrics.values['airspeed']
		if not Toggled2 then
			if cc == true then
				gui.message("Cruise control disabled")
				input.event("axisy1", 0)
				input.event("axisy0", 0)
			else
				gui.message("Cruise control enabled")
				drivetrain.setShifterMode(4)
			end
			Toggled2 = true
			cc = not cc
		end
	else
		Toggled2 = false
	end
	
	if input.keys['H'] then
		if not Toggled3 then
			Toggled3 = true
			ccSpeed = ccSpeed + (1/3.6)*5
			gui.message("Cruise control + 5km/h")
		end
	else
		Toggled3 = false
	end
	
	if input.keys['G'] and electrics.values['airspeed'] > 2 then
		if not Toggled4 then
			Toggled4 = true
			ccSpeed = ccSpeed - (1/3.6)*5
			gui.message("Cruise control - 5km/h")
		end
	else
		Toggled4 = false
	end
	
	if cc == true then
		if electrics.values['airspeed'] < ccSpeed then
			input.event("axisy0", math.abs(electrics.values['airspeed'] - ccSpeed))
			input.event("axisy1", 0)
		end
		if electrics.values['airspeed'] > ccSpeed then
			input.event("axisy1", math.abs(electrics.values['airspeed'] - ccSpeed)/5)
			input.event("axisy0", 0)
		end
	end
end

local function onInit()
	--if drivetrain.differentialMode == 0 then
	--	gui.message("Open differential")
	--	electrics.values['diff'] = 1
	--else
	--	gui.message("Locked differential")
	--	electrics.values['diff'] = 0
	--end
	cc = false
	for k, node in pairs (v.data.nodes) do
		if node.name == "ex1" then 
			ex1=k  
		end
		if node.name == "ex4" then ex4=k  end
	end
	
end

local function resetdifferential()
	originalmode = drivetrain.differentialMode
	drivetrain.toggleDifferentialMode()
	while originalmode ~= drivetrain.differentialMode do
		drivetrain.toggleDifferentialMode()
	end
end

local function onReset()
	resetdifferential()
	onInit()
end

-- public interface
M.onReset       = onReset
M.onInit		  = onInit
M.update 	  = update
M.updateGFX   = updateGFX

return M