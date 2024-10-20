local awful = require "awful"

local displays = require "system.displays"

-- Displays
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        awful.key({ MetaKey, ControlKey }, "o", function(c)
            c:move_to_screen()
        end, { description = "Move window between screens", group = "display" }),
    }
end)

awful.keyboard.append_global_keybindings {
    awful.key({ MetaKey }, "o", function()
        awful.screen.focus_relative(1)
    end, { description = "Focus the next screen", group = "display" }),

    awful.key({}, "XF86Display", function()
        displays.update_displays()
    end, { description = "Update displays (F7)", group = "display" }),

    awful.key({ MetaKey }, "r", function()
        displays.update_displays()
    end, { description = "Reload displays", group = "display" }),
}
