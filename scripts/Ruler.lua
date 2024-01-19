local midpoint = nil
local distance = nil
local adornee = Instance.new("Part")
local line = Instance.new("LineHandleAdornment")
local textLabel = Instance.new("TextLabel")
local billboard = Instance.new("BillboardGui")

local function generateViewPortElements()
	-- Create Reference Part for Line and Billboard
	adornee.Name = "referenceAdornee"
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

local function updateRuler(part1, part2)
	-- Calculations
	midpoint = part1.Position:Lerp(part2.Position, 0.5) -- interpolate middle coordinate of both selected parts
	print("Midpoint:"..tostring(midpoint))
	distance = (part1.Position - part2.Position).Magnitude
	print("Distance:"..tostring(distance))
	
	-- Set positions of GUI elements
	adornee.CFrame = CFrame.new(midpoint, part1.Position) -- Move reference part to midpoint of parts, aswell as make reference part look at part1 (to make sure line is aligned correctly)
	line.Length = distance
	line.CFrame = CFrame.new(0,0,distance/2) -- Move line CFrame to center of line
	
	textLabel.Text = "Distance: "..tostring((math.floor(distance*100))/100) -- incredibly humorous way to round to 2 decimal places, thanks wiki
end

local function removeViewPortElements()
	adornee:Destroy()
	billboard:Destroy()
	line:Destroy()
	
	distance = nil
	midpoint = nil
	print("Destroyed all GUI Elements")
end

-- replace with Selection functionality
local part1 = game.Workspace.Part1
local part2 = game.Workspace.Part2

generateViewPortElements()
updateRuler(part1, part2)
