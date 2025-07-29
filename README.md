# Aiben Elevator System

A lightweight and feature-rich elevator system for FiveM servers that allows players to travel between floors in buildings with smooth transitions and modern UI integration.

## 🚀 Features

- **Multi-floor Support**: Configure unlimited floors with custom coordinates and headings
- **Smooth Transitions**: Screen fade effects for seamless floor transitions
- **ESX Framework Integration**: Full compatibility with ESX Legacy framework
- **Modern UI**: Clean context menus using ox_lib
- **Target System**: Integration with ox_target for enhanced interaction
- **Automatic Blips**: Dynamic blip creation for elevator locations
- **Job Restrictions**: Optional job-based access control
- **Admin Commands**: Built-in admin commands for management
- **Easy Configuration**: Simple config file to add new elevators and floors
- **Debug Mode**: Comprehensive debugging tools for development

## 📋 Dependencies

- [es_extended](https://github.com/esx-framework/esx-legacy) - ESX Framework
- [ox_lib](https://github.com/overextended/ox_lib) - UI Library
- [ox_target](https://github.com/overextended/ox_target) - Target System (optional)

## 🛠️ Installation

1. **Download the resource** and place it in your server's resources folder
2. **Add to server.cfg**:
   ```
   ensure Aiben_elevator
   ```
3. **Configure the elevators** in `config.lua`
4. **Restart your server**

## ⚙️ Configuration

### Basic Configuration

Edit `config.lua` to add your elevators:

```lua
Config.Elevators = {
    ['my_building'] = {
        name = 'My Building Elevator',
        floors = {
            {
                name = 'Ground Floor',
                coords = vector3(x, y, z),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 2,
                    scale = 0.8,
                    label = 'My Building - Ground Floor'
                }
            },
            {
                name = '1st Floor',
                coords = vector3(x, y, z),
                heading = 0.0,
                blip = {
                    enabled = true,
                    sprite = 475,
                    color = 2,
                    scale = 0.8,
                    label = 'My Building - 1st Floor'
                }
            }
        }
    }
}
```

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `Config.Debug` | boolean | false | Enable debug mode |
| `Config.FadeTime` | number | 1000 | Screen fade duration in ms |
| `Config.InteractionDistance` | number | 2.0 | Distance to interact with elevators |
| `Config.UseTarget` | boolean | true | Use ox_target instead of context menu |
| `Config.TargetDistance` | number | 2.0 | Distance for target interaction |

### ESX Settings

```lua
Config.ESX = {
    enabled = true,
    requireJob = false, -- Set to true to restrict access by job
    allowedJobs = {} -- Add job names here if requireJob is true
}
```

## 🎮 Usage

### For Players

1. **Approach an elevator** - Get within 2.0 units of any elevator floor
2. **Interact with the elevator**:
   - If using ox_target: Look at the elevator and click the interaction
   - If using context menu: Press E when near the elevator
3. **Select your destination** from the menu
4. **Wait for the transition** - Screen will fade out/in during teleport

### For Administrators

**Commands:**
- `/elevator` - Open elevator menu (if near an elevator)
- `/elevator_debug` - Show debug information (if debug mode enabled)
- `/reload_elevators` - Reload elevator configuration (admin only)
- `/list_elevators` - List all configured elevators (admin only)

## 🏢 Adding New Elevators

1. **Open `config.lua`**
2. **Add a new elevator entry**:
   ```lua
   ['new_elevator_id'] = {
       name = 'New Elevator Name',
       floors = {
           -- Add your floors here
       }
   }
   ```
3. **Configure each floor** with coordinates, heading, and blip settings
4. **Restart the resource** or use `/reload_elevators` (admin)

## 📝 Example Configurations

### Office Building
```lua
['office_building'] = {
    name = 'Office Building Elevator',
    floors = {
        {
            name = 'Ground Floor',
            coords = vector3(-1090.5090, -2707.0383, 14.1213),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 2, scale = 0.8, label = 'Office Building - Ground Floor' }
        },
        {
            name = '1st Floor',
            coords = vector3(-1099.6758, -2718.5801, 44.5574),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 2, scale = 0.8, label = 'Office Building - 1st Floor' }
        },
        {
            name = '2nd Floor',
            coords = vector3(-1096.0, -2713.0, 33.8),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 2, scale = 0.8, label = 'Office Building - 2nd Floor' }
        },
        {
            name = 'Roof',
            coords = vector3(-1096.0, -2713.0, 43.8),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 2, scale = 0.8, label = 'Office Building - Roof' }
        }
    }
}
```

### Apartment Building
```lua
['apartment_building'] = {
    name = 'Apartment Building Elevator',
    floors = {
        {
            name = 'Lobby',
            coords = vector3(-266.0, -957.0, 31.2),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 3, scale = 0.8, label = 'Apartment Building - Lobby' }
        },
        {
            name = 'Floor 1',
            coords = vector3(-266.0, -957.0, 41.2),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 3, scale = 0.8, label = 'Apartment Building - Floor 1' }
        },
        {
            name = 'Floor 2',
            coords = vector3(-266.0, -957.0, 51.2),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 3, scale = 0.8, label = 'Apartment Building - Floor 2' }
        }
    }
}
```

### Hospital
```lua
['hospital'] = {
    name = 'Hospital Elevator',
    floors = {
        {
            name = 'Emergency Room',
            coords = vector3(295.8, -1446.9, 29.9),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 1, scale = 0.8, label = 'Hospital - Emergency Room' }
        },
        {
            name = 'Surgery Floor',
            coords = vector3(295.8, -1446.9, 39.9),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 1, scale = 0.8, label = 'Hospital - Surgery Floor' }
        },
        {
            name = 'Patient Rooms',
            coords = vector3(295.8, -1446.9, 49.9),
            heading = 0.0,
            blip = { enabled = true, sprite = 475, color = 1, scale = 0.8, label = 'Hospital - Patient Rooms' }
        }
    }
}
```

## 🔧 Troubleshooting

### Common Issues

1. **Elevator not working**: Check if all dependencies are installed and started
2. **Menu not appearing**: Ensure ox_lib is properly installed
3. **Target not working**: Verify ox_target is installed and configured
4. **Coordinates not working**: Use `/elevator_debug` to check your coordinates

### Debug Mode

Enable debug mode in config.lua:
```lua
Config.Debug = true
```

This will enable additional console output and the `/elevator_debug` command.

## 📁 File Structure

```
Aiben_elevator/
├── client/
│   └── main.lua          # Client-side logic
├── server/
│   └── main.lua          # Server-side logic
├── config.lua             # Configuration file
├── fxmanifest.lua         # Resource manifest
└── README.md             # This file
```

## 🆘 Support

For support, please check:
1. All dependencies are installed and working
2. Configuration syntax is correct
3. Server console for error messages
4. Debug mode is enabled for additional information

## 📄 License

This resource is provided as-is for FiveM servers. Feel free to modify and distribute as needed.

---

**Created by Aiben** | **Version 1.0.0** 
