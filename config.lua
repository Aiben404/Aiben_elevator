Config = {}


Config.Debug = false -- Enable debug mode
Config.FadeTime = 1000 -- Time in ms for screen fade effect
Config.InteractionDistance = 2.0 -- Distance to interact with elevator buttons

-- Elevator Configurations
Config.Elevators = {
    ['office_building'] = {
        name = 'Office Building Elevator',
        floors = {
            {
                name = 'Ground Floor',
                coords = vector3(-1090.5090, -2707.0383, 14.1213),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 2,
                    scale = 0.8,
                    label = 'Office Building - Ground Floor'
                }
            },
            {
                name = '1st Floor',
                coords = vector3(-1099.6758, -2718.5801, 44.5574),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 2,
                    scale = 0.8,
                    label = 'Office Building - 1st Floor'
                }
            },
            {
                name = '2nd Floor',
                coords = vector3(-1096.0, -2713.0, 33.8),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 2,
                    scale = 0.8,
                    label = 'Office Building - 2nd Floor'
                }
            },
            {
                name = 'Roof',
                coords = vector3(-1096.0, -2713.0, 43.8),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 2,
                    scale = 0.8,
                    label = 'Office Building - Roof'
                }
            }
        }
    },
    

    ['apartment_building'] = {
        name = 'Apartment Building Elevator',
        floors = {
            {
                name = 'Lobby',
                coords = vector3(-266.0, -957.0, 31.2),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 3,
                    scale = 0.8,
                    label = 'Apartment Building - Lobby'
                }
            },
            {
                name = 'Floor 1',
                coords = vector3(-266.0, -957.0, 41.2),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 3,
                    scale = 0.8,
                    label = 'Apartment Building - Floor 1'
                }
            },
            {
                name = 'Floor 2',
                coords = vector3(-266.0, -957.0, 51.2),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 3,
                    scale = 0.8,
                    label = 'Apartment Building - Floor 2'
                }
            }
        }
    },
    

    ['hospital'] = {
        name = 'Hospital Elevator',
        floors = {
            {
                name = 'Emergency Room',
                coords = vector3(295.8, -1446.9, 29.9),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 1,
                    scale = 0.8,
                    label = 'Hospital - Emergency Room'
                }
            },
            {
                name = 'Surgery Floor',
                coords = vector3(295.8, -1446.9, 39.9),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 1,
                    scale = 0.8,
                    label = 'Hospital - Surgery Floor'
                }
            },
            {
                name = 'Patient Rooms',
                coords = vector3(295.8, -1446.9, 49.9),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 1,
                    scale = 0.8,
                    label = 'Hospital - Patient Rooms'
                }
            }
        }
    }
}

-- Target System Integration
Config.UseTarget = true 
Config.TargetDistance = 2.0 

-- ESX Framework Settings
Config.ESX = {
    enabled = true,
    requireJob = false, 
    allowedJobs = {}
} 