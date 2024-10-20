local awful = require "awful"
local naughty = require "naughty"

local useless_gap = Dimensions.useless_gap * 2
local border = Dimensions.border * 2
local combined_gap = useless_gap + border

local function screen_workarea_width(c)
    return c.screen.workarea.width - useless_gap * 4
end

local function screen_workarea_height(c)
    return c.screen.workarea.height - useless_gap * 4
end

local function screen_workarea_x(c)
    return c.screen.workarea.x + useless_gap * 2
end
local function screen_workarea_y(c)
    return c.screen.workarea.y + useless_gap * 2
end

local function cycle_width(c, screen_width)
    -- Get the current width of the client
    local current_width = c:geometry().width

    -- Define the width values to cycle through, adjusted for the useless_gap and border
    local widths = {
        (screen_width - 2 * combined_gap) / 2,
        (screen_width - 2 * combined_gap) / 3,
        (screen_width - 2 * combined_gap) / 4,
    }

    -- Find the current index of the width, if it's not in the list, default to first
    local index = 1
    for i, w in ipairs(widths) do
        if math.abs(current_width - w) < 10 then
            index = i
            break
        end
    end

    -- Cycle to the next width
    index = index % #widths + 1

    c:geometry { width = widths[index], height = screen_workarea_height(c) }
end

local function snap_to_right(c, screen_width)
    -- Cycle the client's width between half, third, and quarter of the screen
    cycle_width(c, screen_width)

    -- Get the updated width after cycling
    local new_width = c:geometry().width
    local new_x = screen_workarea_x(c) + screen_workarea_width(c) - new_width

    c:geometry {
        x = new_x,
        y = screen_workarea_y(c),
        width = new_width - border, -- Resize to adjust for the gap on the right side
        height = screen_workarea_height(c),
    }
end

local function snap_to_left(c, screen_width)
    -- Get the client's new width (cycled)
    cycle_width(c, screen_width)

    c:geometry {
        x = screen_workarea_x(c),
        y = screen_workarea_y(c),
        width = c:geometry().width,
        height = screen_workarea_height(c),
    }
end

local function center_client(c)
    local screen_width = screen_workarea_width(c)
    local screen_height = screen_workarea_height(c)

    -- Cycle the client's width between half, third, and quarter of the screen
    cycle_width(c, screen_width)

    local new_width = c:geometry().width
    -- Center the client horizontally by adjusting the x position
    local new_x = screen_workarea_x(c) + (screen_width - new_width) / 2

    c:geometry {
        x = new_x,
        y = screen_workarea_y(c),
        width = new_width,
        height = screen_height,
    }
end

local function swap_clients(c1, c2)
    if not (c1 and c2) then
        return
    end

    -- Get the current geometry of both clients
    local c1_geo = c1:geometry()
    local c2_geo = c2:geometry()

    -- Swap geometries (position and size)
    c1:geometry(c2_geo)
    c2:geometry(c1_geo)
end

local function get_floating_clients(screen)
    local clients = screen.clients
    local floating_clients = {}

    for _, c in ipairs(clients) do
        if awful.layout.get(screen) == awful.layout.suit.floating or c.floating then
            table.insert(floating_clients, c)
        end
    end

    return floating_clients
end

local function minimize_all_but_focused()
    local focused_client = client.focus

    if not focused_client then
        naughty.notify { text = "No focused client!" }
        return
    end

    local screen_clients = focused_client.screen.clients

    for _, c in ipairs(screen_clients) do
        -- If the client is not the focused one and is floating, minimize it
        if c ~= focused_client and (awful.layout.get(c.screen) == awful.layout.suit.floating or c.floating) then
            c.minimized = true
        end
    end
end

-- Floating layout bindings
awful.keyboard.append_global_keybindings {

    awful.key({ MetaKey, ControlKey }, "g", function()
        local current_layout = awful.layout.get(client.focus.screen)
        local screen = client.focus.screen

        if current_layout == awful.layout.suit.floating or client.focus.floating then
            local floating_clients = get_floating_clients(screen)

            if not initial_client or not next_client_index then
                initial_client = client.focus
                next_client_index = 1
            end

            next_client_index = (next_client_index % #floating_clients) + 1

            local next_client = floating_clients[next_client_index]
            if next_client and next_client ~= initial_client then
                swap_clients(initial_client, next_client)
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
                x = screen_workarea_x(c),
                y = screen_workarea_y(c),
                width = (screen_workarea_width(c) / 2) - border,
                height = (screen_workarea_height(c) / 2) - border,
            }
        end
    end, { description = " Floating: snap to top-left corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "j", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.bottom_left(c, { honor_workarea = true })
            c:geometry {
                x = screen_workarea_x(c),
                width = (screen_workarea_width(c) / 2) - border,
                height = (screen_workarea_height(c) / 2) - combined_gap, -- Resize to adjust for the gap at the bottom
            }
        end
    end, { description = " Floating: snap to bottom-left corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "k", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.bottom_right(c, { honor_workarea = true })
            c:geometry {
                x = screen_workarea_x(c) + (screen_workarea_width(c) / 2) + combined_gap,
                width = (screen_workarea_width(c) / 2) - combined_gap,
                height = (screen_workarea_height(c) / 2) - combined_gap, -- Resize to adjust for the gap at the bottom
            }
        end
    end, { description = " Floating: snap to bottom-right corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "l", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.top_right(c, { honor_workarea = true })
            c:geometry {
                x = screen_workarea_x(c) + (screen_workarea_width(c) / 2) + combined_gap,
                y = screen_workarea_y(c),
                width = (screen_workarea_width(c) / 2) - combined_gap,
                height = (screen_workarea_height(c) / 2) - border, -- Resize to adjust for the gap at the bottom
            }
        end
    end, { description = " Floating: snap to top-right corner", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "a", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.left(c, { honor_workarea = true })
            snap_to_left(c, screen_workarea_width(c))
        end
    end, { description = " Floating: snap to left (half, third, quarter)", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "f", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            awful.placement.right(c, { honor_workarea = true })
            snap_to_right(c, screen_workarea_width(c))
        end
    end, { description = " Floating: snap to right (half, third, quarter)", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "t", function()
        local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
        local c = client.focus
        if current_layout == "floating" or c.floating == true then
            center_client(c)
        end
    end, { description = " Floating: center client (half, third, quarter)", group = "floating-layout" }),

    awful.key({ MetaKey, ControlKey }, "m", function()
        minimize_all_but_focused()
    end, { description = "Floating: Minimize all except focused window", group = "floating-layout" }),
}
