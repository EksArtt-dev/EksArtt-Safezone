Config = {}

Config.Safezones = {
    {coords = vector3(215.23, -810.15, 30.73), radius = 50.0}
}
Config.SpeedlimitAc = false -- True yaparak hız limitini açabilirsiniz !
Config.SpeedLimit = 10.0 -- Araç hız limiti

Config.EmergencyJobs = {"police", "ambulance"} -- Safezone içinde silah çekebilecek meslekler

Config.DisableControls = {
    saldiri = true, -- Saldırı engelleme
    sikma = true, -- Sağ tık nişan alma engelleme
    yumruk = true, -- Yakın dövüş saldırı engelleme
    alternatifsaldiri = true, -- Yineleme saldırı engelleme
    hafif_saldiri = true, -- Hafif saldırı engelleme
    agir_saldiri = true, -- Ağır saldırı engelleme
    silah = true, -- Silah engelleme
}
