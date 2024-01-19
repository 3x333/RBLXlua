local midpoint = nil
local distance = nil
local adornee = Instance.new("Part")
local line = Instance.new("LineHandleAdornment")
local textLabel = Instance.new("TextLabel")
local billboard = Instance.new("BillboardGui")

local UserInputService = game:GetService("UserInputService")

local raycastPosition = nil
local raycastInstance = nil

local firstSelectedPart = nil
local secondSelectedPart = nil
local firstSelectedPoint = nil
local secondSelectedPoint = nil

local function generateViewPortElements()
	-- Create Reference Part for Line and Billboard
	adornee.Name = "referenceAdornee"
	adornee.Anchored = true
	adornee.Parent = workspace
	adornee.Size = Vector3.new(0,0,0)
	
	-- Create line adornment
	line.Name = "rulerLine"
	line.Parent = workspace
	line.Color3 = Color3.new(1,1,1)
	line.Transparency = 0
	line.Thickness = 3
	line.ZIndex = 1
	line.Adornee = adornee
	
	-- Create billboard and text label
	billboard.Name = "distanceBillboard"
	billboard.Parent = workspace
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.new(0,100,0,20)
	billboard.MaxDistance = 50
	billboard.Adornee = adornee
	
	textLabel.Name = "distanceLabel"
	textLabel.Parent = billboard
	textLabel.Size = UDim2.new(0,100,0,20)
	textLabel.BackgroundColor3 = Color3.new(1,1,1)
	textLabel.Font = "Ubuntu"
	textLabel.TextStrokeColor3 = Color3.new(0,0,0)
	textLabel.TextSize = 14
	textLabel.Text = ""
	textLabel.TextStrokeTransparency = 1
	textLabel.TextColor3 = Color3.new(0,0,0)
	
end

local function updateRulerByParts()
	-- Calculations
	midpoint = firstSelectedPart.Position:Lerp(secondSelectedPart.Position, 0.5) -- interpolate middle coordinate of both selected parts
	print("Midpoint:"..tostring(midpoint))
	distance = (firstSelectedPart.Position - secondSelectedPart.Position).Magnitude
	print("Distance:"..tostring(distance))
	
	-- Set positions of GUI elements
	adornee.CFrame = CFrame.new(midpoint, firstSelectedPart.Position) -- Move reference part to midpoint of parts, aswell as make reference part look at part1 (to make sure line is aligned correctly)
	line.Length = distance
	line.CFrame = CFrame.new(0,0,distance/2) -- Move line CFrame to center of line
	
	textLabel.Text = "Distance: "..tostring((math.floor(distance*100))/100) -- incredibly humorous way to round to 2 decimal places, thanks wiki
end

local function updateRulerByPoints()
	-- Calculations
	midpoint = firstSelectedPoint.Position:Lerp(secondSelectedPoint.Position, 0.5) -- interpolate middle coordinate of both selected parts
	print("Midpoint:"..tostring(midpoint))
	distance = (firstSelectedPoint.Position - secondSelectedPoint.Position).Magnitude
	print("Distance:"..tostring(distance))
	
	-- Set positions of GUI elements
	adornee.CFrame = CFrame.new(midpoint, firstSelectedPoint.Position) -- Move reference part to midpoint of parts, aswell as make reference part look at part1 (to make sure line is aligned correctly)
	line.Length = distance
	line.CFrame = CFrame.new(0,0,distance/2) -- Move line CFrame to center of line
	
	textLabel.Text = "Distance: "..tostring((math.floor(distance*100))/100) -- incredibly humorous way to round to 2 decimal places, thanks wiki
end

local function removeViewPortElements()
	adornee:Destroy()
	billboard:Destroy()
	line:Destroy()

	print("Destroyed all GUI Elements")
end

local function selectionHandler()
	local mouseLocation = UserInputService:GetMouseLocation()
	local screenToWorldRay = workspace.CurrentCamera:ViewportPointToRay(mouseLocation.X, mouseLocation.Y) -- fires ray to the point at which the mouse clicked
	local raycastResult = workspace:Raycast(screenToWorldRay.Origin, screenToWorldRay.Direction * 1000) -- returns what part, face and pos the ray hit

	if raycastResult then -- check if ray hit a part
			raycastPosition = raycastResult.Position
			raycastInstance = raycastResult.Instance
	end
end

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		selectionHandler()
		updateRulerByParts()	
	end
end)

generateViewPortElements()
