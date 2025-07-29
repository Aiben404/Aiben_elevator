local ESX = exports['es_extended']:getSharedObject()
local PlayerData = {}
local currentFloor = nil
local isInElevator = false


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)


CreateThread(function()
    for elevatorId, elevator in pairs(Config.Elevators) do
        for floorIndex, floor in ipairs(elevator.floors) do
            if floor.blip and floor.blip.enabled then
                local blip = AddBlipForCoord(floor.coords.x, floor.coords.y, floor.coords.z)
                SetBlipSprite(blip, floor.blip.sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, floor.blip.scale)
                SetBlipColour(blip, floor.blip.color)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(floor.blip.label)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)


local function GetCurrentFloorIndex(elevatorId)
    local playerCoords = GetEntityCoords(PlayerPedId())
    
    for floorIndex, floor in ipairs(Config.Elevators[elevatorId].floors) do
        local distance = #(playerCoords - floor.coords)
        if distance < 5.0 then
            return floorIndex
        end
    end
    
    return nil
end


local function IsNearElevator(elevatorId)
    local playerCoords = GetEntityCoords(PlayerPedId())
    
    for _, floor in ipairs(Config.Elevators[elevatorId].floors) do
        local distance = #(playerCoords - floor.coords)
        if distance < Config.InteractionDistance then
            return true
        end
    end
    
    return false
end


local function GetElevatorIdFromLocation()
    local playerCoords = GetEntityCoords(PlayerPedId())
    
    for elevatorId, elevator in pairs(Config.Elevators) do
        for _, floor in ipairs(elevator.floors) do
            local distance = #(playerCoords - floor.coords)
            if distance < Config.InteractionDistance then
                return elevatorId
            end
        end
    end
    
    return nil
end


local function TeleportToFloor(elevatorId, floorIndex)
    if isInElevator then return end
    
    local floor = Config.Elevators[elevatorId].floors[floorIndex]
    if not floor then return end
    

    local currentFloorIndex = GetCurrentFloorIndex(elevatorId)
    

    TriggerServerEvent('elevator:use', elevatorId, currentFloorIndex or 1, floorIndex)
end


RegisterNetEvent('elevator:teleport')
AddEventHandler('elevator:teleport', function(elevatorId, floorIndex)
    if isInElevator then return end
    
    local floor = Config.Elevators[elevatorId].floors[floorIndex]
    if not floor then return end
    
    isInElevator = true
    

    DoScreenFadeOut(Config.FadeTime)
    Wait(Config.FadeTime)
    

    SetEntityCoords(PlayerPedId(), floor.coords.x, floor.coords.y, floor.coords.z, false, false, false, true)
    SetEntityHeading(PlayerPedId(), floor.heading)
    

    Wait(500)
    DoScreenFadeIn(Config.FadeTime)
    

    currentFloor = floorIndex
    

    lib.notify({
        title = 'Elevator',
        description = 'You have arrived at ' .. floor.name,
        type = 'success'
    })
    
    isInElevator = false
end)


local function ShowElevatorMenu(elevatorId)
    local currentFloorIndex = GetCurrentFloorIndex(elevatorId)
    local elevator = Config.Elevators[elevatorId]
    local options = {}
    
    for floorIndex, floor in ipairs(elevator.floors) do
        local isCurrentFloor = (floorIndex == currentFloorIndex)
        local label = floor.name
        if isCurrentFloor then
            label = label .. ' (Current Floor)'
        end
        
        table.insert(options, {
            title = label,
            description = 'Travel to ' .. floor.name,
            icon = 'elevator',
            disabled = isCurrentFloor,
            onSelect = function()
                TeleportToFloor(elevatorId, floorIndex)
            end
        })
    end
    
    lib.registerContext({
        id = 'elevator_menu',
        title = elevator.name,
        options = options
    })
    
    lib.showContext('elevator_menu')
end


if Config.UseTarget then
    CreateThread(function()
        for elevatorId, elevator in pairs(Config.Elevators) do
            for floorIndex, floor in ipairs(elevator.floors) do
                exports.ox_target:addBoxZone({
                    coords = floor.coords,
                    size = vector3(1.5, 1.5, 3.0),
                    rotation = floor.heading,
                    options = {
                        {
                            name = 'elevator_' .. elevatorId .. '_' .. floorIndex,
                            icon = 'fas fa-elevator',
                            label = 'Use Elevator',
                            distance = Config.TargetDistance,
                            onSelect = function()
                                ShowElevatorMenu(elevatorId)
                            end
                        }
                    }
                })
            end
        end
    end)
else

    CreateThread(function()
        while true do
            local sleep = 1000
            local playerCoords = GetEntityCoords(PlayerPedId())
            local nearElevator = false
            
            for elevatorId, elevator in pairs(Config.Elevators) do
                for _, floor in ipairs(elevator.floors) do
                    local distance = #(playerCoords - floor.coords)
                    if distance < Config.InteractionDistance then
                        nearElevator = true
                        sleep = 0
                        
                        
                        lib.showTextUI('[E] - Use ' .. elevator.name)
                        
                        if IsControlJustPressed(0, 38) then 
                            lib.hideTextUI()
                            ShowElevatorMenu(elevatorId)
                        end
                        break
                    end
                end
                if nearElevator then break end
            end
            
            if not nearElevator then
                lib.hideTextUI()
            end
            
            Wait(sleep)
        end
    end)
end


RegisterCommand('elevator', function()
    local elevatorId = GetElevatorIdFromLocation()
    if elevatorId then
        ShowElevatorMenu(elevatorId)
    else
        lib.notify({
            title = 'Elevator',
            description = 'You are not near an elevator',
            type = 'error'
        })
    end
end, false)


if Config.Debug then
    RegisterCommand('elevator_debug', function()
        local playerCoords = GetEntityCoords(PlayerPedId())
        print('Player coordinates: ' .. playerCoords.x .. ', ' .. playerCoords.y .. ', ' .. playerCoords.z)
        
        for elevatorId, elevator in pairs(Config.Elevators) do
            print('Elevator: ' .. elevator.name)
            for floorIndex, floor in ipairs(elevator.floors) do
                local distance = #(playerCoords - floor.coords)
                print('  Floor ' .. floorIndex .. ': ' .. floor.name .. ' - Distance: ' .. distance)
            end
        end
    end, false)
end


RegisterNetEvent('elevator:reloadConfig')
AddEventHandler('elevator:reloadConfig', function()

    for elevatorId, elevator in pairs(Config.Elevators) do
        for floorIndex, floor in ipairs(elevator.floors) do
            if floor.blip and floor.blip.enabled then
                local blip = AddBlipForCoord(floor.coords.x, floor.coords.y, floor.coords.z)
                SetBlipSprite(blip, floor.blip.sprite)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, floor.blip.scale)
                SetBlipColour(blip, floor.blip.color)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(floor.blip.label)
                EndTextCommandSetBlipName(blip)
            end
        end
    end
    
    print('[ELEVATOR] Configuration reloaded')
end) 