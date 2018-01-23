KeyCheck = {}

--Constructor------------------------------------------------------------------------------------------------------
-- Defines the keycheck
-------------------------------------------------------------------------------------------------------------------
joysticks = love.joystick.getJoysticks()
function KeyCheck:new()
	-- define our parameters here
	local object = {
	keyUp = 0,
	keyDown = 0,
	keyLeft = 0,
	keyRight = 0,
    keyW = 0,
	keyS = 0,
	keyA = 0,
	keyD = 0,
    keyEsc = 0,
	keyP = 0,
  	keyX = 0,
  	keyEnter = 0,
  	keySpace = 0,
    keyF4 = 0,
    keyR = 0,
	keyZ = 0,
        
    joyStiLeft_Up = 0,
    joyStiLeft_Down = 0,
    joyStiLeft_Left = 0,
    joyStiLeft_Right = 0,
        
    joyStiRight_Up = 0,
    joyStiRight_Down = 0,
    joyStiRight_Left = 0,
    joyStiRight_Right = 0,
    
    mouse_Left = 0,
    mouse_Right = 0
	}
	setmetatable(object, { __index = KeyCheck })
	return object
end

--KeyCheck Released------------------------------------------------------------------------------------------------
-- Returns a bool regarding if the key in question has been released
-------------------------------------------------------------------------------------------------------------------
function KeyCheck:released(_inputKey)
	if _inputKey == 0 then
		return true
	else
		return false
	end
end

--KeyCheck Pressed-------------------------------------------------------------------------------------------------
-- Returns a bool regarding if the key in question has been pressed
-------------------------------------------------------------------------------------------------------------------
function KeyCheck:pressed(_inputKey)
	if _inputKey == 1 then
		return true
	else
		return false
	end
end

--KeyCheck Held----------------------------------------------------------------------------------------------------
-- Returns a bool regarding if the key in question has been held
-------------------------------------------------------------------------------------------------------------------
function KeyCheck:held(_inputKey)
	if _inputKey > 0 then
		return true
	else
		return false
	end
end

--Update-----------------------------------------------------------------------------------------------------------
-- Updates the KeyCheck
-------------------------------------------------------------------------------------------------------------------
function KeyCheck:update(keyboard)
	-- Key Up
	self.keyUp = stateCheck(keyboard.isDown("up"), self.keyUp)

	-- Key Down
	self.keyDown = stateCheck(keyboard.isDown("down"), self.keyDown)

	-- Key Left
	self.keyLeft = stateCheck(keyboard.isDown("left"), self.keyLeft)

	-- Key Right
	self.keyRight = stateCheck(keyboard.isDown("right"), self.keyRight)
    
    -- Key W
	self.keyW = stateCheck(keyboard.isDown("w"), self.keyW)

	-- Key S
	self.keyS = stateCheck(keyboard.isDown("s"), self.keyS)

	-- Key A
	self.keyA = stateCheck(keyboard.isDown("a"), self.keyA)

	-- Key D
	self.keyD = stateCheck(keyboard.isDown("d"), self.keyD)

	-- Key Escape
	self.keyEsc = stateCheck(keyboard.isDown("escape"), self.keyEsc)

	-- Key P
	self.keyP = stateCheck(keyboard.isDown("p"), self.keyP)

	-- Key X
	self.keyX = stateCheck(keyboard.isDown("x"), self.keyX)

	-- Key Enter
	self.keyEnter = stateCheck(keyboard.isDown("return"), self.keyX)

	-- Key Space
	self.keySpace = stateCheck(keyboard.isDown(" "), self.keyX)

    -- Key F4
	self.keyF4 = stateCheck(keyboard.isDown("f4"), self.keyF4)
    
    -- Key R
	self.keyR = stateCheck(keyboard.isDown("r"), self.keyR)
	
	-- Key R
	self.keyZ = stateCheck(keyboard.isDown("z"), self.keyZ)
    
    -- Mouse Left 
    self.mouse_Left = stateCheck(love.mouse.isDown( 1), self.mouse_Left)
    
    -- Mouse Right
    self.mouse_Right = stateCheck(love.mouse.isDown( 2), self.mouse_Right)
    
    -- Manage Joystick
    self:manageJoystick()
    
	return self
end

function KeyCheck:manageJoystick()
    self.joyStiLeft_Up = joyCheck("lefty", "neg", self.joyStiLeft_Up)
    self.joyStiLeft_Down = joyCheck("lefty", "pos", self.joyStiLeft_Down)
    self.joyStiLeft_Left = joyCheck("leftx", "neg", self.joyStiLeft_Left)
    self.joyStiLeft_Right = joyCheck("leftx", "pos", self.joyStiLeft_Right)
        
    self.joyStiRight_Up = joyCheck("righty", "neg", self.joyStiRight_Up)
    self.joyStiRight_Down = joyCheck("righty", "pos", self.joyStiRight_Down)
    self.joyStiRight_Left = joyCheck("rightx", "neg", self.joyStiRight_Left)
    self.joyStiRight_Right = joyCheck("rightx", "pos", self.joyStiRight_Right)
end

function joyCheck(_joyInput, _sign, _inputKey)
    local inputKey = _inputKey
    joysticks = love.joystick.getJoysticks()
    if not joysticks[1] then 
        inputKey = 0
    else
        if _sign == "pos" then
            if joysticks[1]:getGamepadAxis(_joyInput) > 0.2 then
                if inputKey == 0 then inputKey = 1
                elseif inputKey == 1 then inputKey = 2
                end
            else
                inputKey = 0
            end
        
        elseif _sign == "neg" then 
            if joysticks[1]:getGamepadAxis(_joyInput) < -0.2 then
                if inputKey == 0 then inputKey = 1
                elseif inputKey == 1 then inputKey = 2
                end
            else
                inputKey = 0
            end
        end
    end
    
    return inputKey
end


--State Check------------------------------------------------------------------------------------------------------
-- Code behind the update to define the state of a keypress
-------------------------------------------------------------------------------------------------------------------
function stateCheck(_isPressed, _inputKey)
	local inputKey = _inputKey
	if _isPressed then
		if inputKey == 0 then inputKey = 1
		elseif inputKey == 1 then inputKey = 2
		end
	else
		inputKey = 0
	end
	return inputKey
end

function KeyCheck:lerp(v0, v1, t)
  return (1-t)*v0 + t*v1;
end

function KeyCheck:distance ( x1, y1, x2, y2 )
	local dx = x1 - x2
	local dy = y1 - y2
	return math.sqrt ( dx * dx + dy * dy )
  end