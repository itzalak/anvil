local awful = require "awful"

-- General awesome keybindings
awful.keyboard.append_global_keybindings {
    awful.key({ MetaKey, ControlKey }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ MetaKey, ControlKey }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
}

awful.keyboard.append_global_keybindings {
    awful.key {
        modifiers = { MetaKey },
        keygroup = "numrow",
        description = "View tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers = { MetaKey, ShiftKey },
        keygroup = "numrow",
        description = "Move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
}

-- Layout bindings
awful.keyboard.append_global_keybindings {
    awful.key({ MetaKey, ControlKey }, "space", function()
        awful.layout.inc(1)
    end, { description = "Select next layout", group = "layout" }),
}

-- Client bindings
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        awful.key({ MetaKey }, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, { description = "Toggle window fullscreen", group = "client" }),
        awful.key({ MetaKey }, "q", function(c)
            c:kill()
        end, { description = "Close window", group = "client" }),

        awful.key({ MetaKey }, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, { description = "Minimize", group = "client" }),

        awful.key({ MetaKey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(Un)maximize", group = "client" }),
    }
end)
