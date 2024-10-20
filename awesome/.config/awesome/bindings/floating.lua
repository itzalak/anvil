local awful = require "awful"
local naughty = require "naughty"

local u = require "helpers.layouts"

-- Focus bindings
awful.keyboard.append_global_keybindings {
    awful.key({ MetaKey, ControlKey }, "n", function()
        awful.client.focus.byidx(1)
    end, { description = "Focus next window by index", group = "client" }),

    awful.key({ MetaKey, ControlKey }, "u", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:activate { raise = true, context = "key.unminimize" }
        end
    end, { description = "Restore minimized windows", group = "client" }),
}

-- Floating layout bindings
awful.keyboard.append_global_keybindings {

    awful.key({ MetaKey, ControlKey }, "g", function()
        local current_layout = awful.layout.get(client.focus.screen)
        local screen = client.focus.screen

        if current_layout == awful.layout.suit.floating or client.focus.floating then
            local floating_clients = u.get_floating_clients(screen)

            if not initial_client or not next_client_index then
                initial_client = client.focus
                next_client_index = 1
            end

            next_client_index = (next_client_index % #floating_clients) + 1

            local next_client = floating_clients[next_client_index]
            if next_client and next_client ~= initial_client then
                u.swap_clients(initial_client, next_client)
            end

            -- Reset when we rotate through all clients
            if next_client_index == 1 then
                -- Reset initial client and index to stop rotating
                initial_client = nil
                next_client_index = nil
            end
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = "Floating: swap windows position", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "h", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.top_left(c, { honor_workarea = true })
            c:geometry {
                x = u.screen_workarea_x(c),
                y = u.screen_workarea_y(c),
                width = (u.screen_workarea_width(c) / 2) - u.border,
                height = (u.screen_workarea_height(c) / 2) - u.border,
            }
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = " Floating: snap to top-left corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "j", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.bottom_left(c, { honor_workarea = true })
            c:geometry {
                x = u.screen_workarea_x(c),
                width = (u.screen_workarea_width(c) / 2) - u.border,
                height = (u.screen_workarea_height(c) / 2) - u.combined_gap, -- Resize to adjust for the gap at the bottom
            }
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = " Floating: snap to bottom-left corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "k", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.bottom_right(c, { honor_workarea = true })
            c:geometry {
                x = u.screen_workarea_x(c) + (u.screen_workarea_width(c) / 2) + u.combined_gap,
                width = (u.screen_workarea_width(c) / 2) - u.combined_gap,
                height = (u.screen_workarea_height(c) / 2) - u.combined_gap, -- Resize to adjust for the gap at the bottom
            }
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = " Floating: snap to bottom-right corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "l", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.top_right(c, { honor_workarea = true })
            c:geometry {
                x = u.screen_workarea_x(c) + (u.screen_workarea_width(c) / 2) + u.combined_gap,
                y = u.screen_workarea_y(c),
                width = (u.screen_workarea_width(c) / 2) - u.combined_gap,
                height = (u.screen_workarea_height(c) / 2) - u.border, -- Resize to adjust for the gap at the bottom
            }
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = " Floating: snap to top-right corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "a", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.left(c, { honor_workarea = true })
            u.snap_to_left(c, u.screen_workarea_width(c))
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = " Floating: snap to left (half, third, quarter)", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "f", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.right(c, { honor_workarea = true })
            u.snap_to_right(c, u.screen_workarea_width(c))
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = " Floating: snap to right (half, third, quarter)", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "t", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            u.center_client(c)
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = " Floating: center client (half, third, quarter)", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "c", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.centered(c, { honor_workarea = true })

            c:geometry {
                x = u.screen_workarea_x(c) + u.focus_gap,
                y = u.screen_workarea_y(c) + u.focus_gap,
                width = u.screen_workarea_width(c) - 2 * u.focus_gap,
                height = u.screen_workarea_height(c) - 2 * u.focus_gap,
            }
        else
            naughty.notify { text = "Not in floating layout or client not floating!" }
        end
    end, { description = "Floating: center with gaps", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "m", function()
        u.minimize_all_but_focused()
    end, { description = "Floating: Minimize all except focused window", group = "floating-layout" }),
}
