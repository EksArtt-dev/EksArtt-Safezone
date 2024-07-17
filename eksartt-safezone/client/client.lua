local QBCore = exports['qb-core']:GetCoreObject()

local wasInSafezone = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local inSafezone = false
        local playerJob = QBCore.Functions.GetPlayerData().job
        local isEmergencyJob = playerJob and contains(Config.EmergencyJobs, playerJob.name)

        for _, safezone in pairs(Config.Safezones) do
            local distance = #(playerCoords - safezone.coords)
            if distance < safezone.radius then
                inSafezone = true
                break
            end
        end

        if inSafezone and not wasInSafezone and not isEmergencyJob then
            SetEntityInvincible(playerPed, true)
            SetPlayerInvincible(playerPed, true)
            ClearPedBloodDamage(playerPed)
            ResetPedVisibleDamage(playerPed)
            QBCore.Functions.Notify('Safezone içindesiniz!', 'success', 5000)
            wasInSafezone = true
        elseif not inSafezone and wasInSafezone then
            SetEntityInvincible(playerPed, false)
            SetPlayerInvincible(playerPed, false)
            QBCore.Functions.Notify('Safezone dışında!', 'error', 5000)
            wasInSafezone = false
        end

        if inSafezone and not isEmergencyJob then
            DisablePlayerFiring(playerPed, true) 

            if Config.DisableControls.saldiri then
                DisableControlAction(0, 24, true) 
            end
            if Config.DisableControls.sikma then
                DisableControlAction(0, 25, true) 
            end
            if Config.DisableControls.yumruk then
                DisableControlAction(0, 142, true) 
            end
            if Config.DisableControls.alternatifsaldiri then
                DisableControlAction(0, 257, true) 
            end
            if Config.DisableControls.hafif_saldiri then
                DisableControlAction(0, 140, true) 
            end
            if Config.DisableControls.agir_saldiri then
                DisableControlAction(0, 141, true) 
            end
            if Config.DisableControls.silah then
                DisableControlAction(0, 143, true) 
            end

            SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
        if Config.SpeedlimitAc then
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetEntityMaxSpeed(vehicle, Config.SpeedLimit)
            end
        else
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel'))
            end
        end
    end
    end
end)

function contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end
