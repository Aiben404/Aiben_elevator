local ESX = exports['es_extended']:getSharedObject()


local function LogElevatorUse(source, elevatorId, fromFloor, toFloor)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end
    
    local playerName = xPlayer.getName()
    local playerIdentifier = xPlayer.getIdentifier()
    
    print(string.format('[ELEVATOR] %s (%s) used elevator %s from floor %s to floor %s', 
        playerName, playerIdentifier, elevatorId, fromFloor, toFloor))
    
end


RegisterNetEvent('elevator:use')
AddEventHandler('elevator:use', function(elevatorId, fromFloor, toFloor)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then
        print('[ELEVATOR] Error: Player not found')
        return
    end
    

    if not Config.Elevators[elevatorId] then
        print('[ELEVATOR] Error: Invalid elevator ID')
        return
    end
    

    if not Config.Elevators[elevatorId].floors[fromFloor] or not Config.Elevators[elevatorId].floors[toFloor] then
        print('[ELEVATOR] Error: Invalid floor index')
        return
    end
    

    if Config.ESX.requireJob then
        local playerJob = xPlayer.getJob().name
        local hasAccess = false
        
        for _, allowedJob in ipairs(Config.ESX.allowedJobs) do
            if playerJob == allowedJob then
                hasAccess = true
                break
            end
        end
        
        if not hasAccess then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Elevator',
                description = 'You do not have access to this elevator',
                type = 'error'
            })
            return
        end
    end
    

    LogElevatorUse(source, elevatorId, fromFloor, toFloor)
    

    TriggerClientEvent('elevator:teleport', source, elevatorId, toFloor)
end)


RegisterCommand('reload_elevators', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer or not xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Elevator',
            description = 'You do not have permission to use this command',
            type = 'error'
        })
        return
    end
    

    TriggerClientEvent('elevator:reloadConfig', -1)
    
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Elevator',
        description = 'Elevator configuration reloaded',
        type = 'success'
    })
    
    print('[ELEVATOR] Configuration reloaded by admin: ' .. xPlayer.getName())
end, false)


RegisterCommand('list_elevators', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer or not xPlayer.getGroup() == 'admin' then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Elevator',
            description = 'You do not have permission to use this command',
            type = 'error'
        })
        return
    end
    
    local elevatorList = 'Available Elevators:\n'
    for elevatorId, elevator in pairs(Config.Elevators) do
        elevatorList = elevatorList .. '- ' .. elevator.name .. ' (' .. elevatorId .. ')\n'
        for floorIndex, floor in ipairs(elevator.floors) do
            elevatorList = elevatorList .. '  Floor ' .. floorIndex .. ': ' .. floor.name .. '\n'
        end
        elevatorList = elevatorList .. '\n'
    end
    
    print(elevatorList)
    TriggerClientEvent('chat:addMessage', source, {
        color = {255, 255, 0},
        multiline = true,
        args = {'Elevator System', elevatorList}
    })
end, false)


CreateThread(function()
    print('[ELEVATOR] Elevator system initialized')
    print('[ELEVATOR] Loaded ' .. #Config.Elevators .. ' elevator(s)')
    
    for elevatorId, elevator in pairs(Config.Elevators) do
        print('[ELEVATOR] - ' .. elevator.name .. ' with ' .. #elevator.floors .. ' floors')
    end
end) 