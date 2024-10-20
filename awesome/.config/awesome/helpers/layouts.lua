local awful = require "awful"

local M = {}

M.useless_gap = Dimensions.useless_gap * 2
M.border = Dimensions.border * 2
M.combined_gap = Dimensions.useless_gap + M.border
M.focus_gap = Dimensions.useless_gap * 20

function M.screen_workarea_width(c)
    return c.screen.workarea.width - M.useless_gap * 4
end

function M.screen_workarea_height(c)
    return c.screen.workarea.height - M.useless_gap * 4
end

function M.screen_workarea_x(c)
    return c.screen.workarea.x + M.useless_gap * 2
end

function M.screen_workarea_y(c)
    return c.screen.workarea.y + M.useless_gap * 2
end

function M.cycle_width(c, screen_width)
    local current_width = c:geometry().width
    local widths = {
        (screen_width - 2 * M.combined_gap) / 2,
        (screen_width - 2 * M.combined_gap) / 3,
        (screen_width - 2 * M.combined_gap) / 4,
    }

    local index = 1
    for i, w in ipairs(widths) do
        if math.abs(current_width - w) < 10 then
            index = i
            break
        end
    end

    index = index % #widths + 1
    c:geometry { width = widths[index], height = M.screen_workarea_height(c) }
end

function M.snap_to_right(c, screen_width)
    M.cycle_width(c, screen_width)
    local new_width = c:geometry().width
    local new_x = M.screen_workarea_x(c) + M.screen_workarea_width(c) - new_width
    c:geometry {
        x = new_x,
        y = M.screen_workarea_y(c),
        width = new_width - M.border,
        height = M.screen_workarea_height(c),
    }
end

function M.snap_to_left(c, screen_width)
    M.cycle_width(c, screen_width)
    c:geometry {
        x = M.screen_workarea_x(c),
        y = M.screen_workarea_y(c),
        width = c:geometry().width,
        height = M.screen_workarea_height(c),
    }
end

function M.center_client(c)
    local screen_width = M.screen_workarea_width(c)
    local screen_height = M.screen_workarea_height(c)
    M.cycle_width(c, screen_width)
    local new_width = c:geometry().width
    local new_x = M.screen_workarea_x(c) + (screen_width - new_width) / 2

    c:geometry {
        x = new_x,
        y = M.screen_workarea_y(c),
        width = new_width,
        height = screen_height,
    }
end

function M.swap_clients(c1, c2)
    if not (c1 and c2) then
        return
    end

    local c1_geo = c1:geometry()
    local c2_geo = c2:geometry()

    c1:geometry(c2_geo)
    c2:geometry(c1_geo)
end

function M.get_floating_clients(screen)
    local clients = screen.clients
    local floating_clients = {}

    for _, c in ipairs(clients) do
        if awful.layout.get(screen) == awful.layout.suit.floating or c.floating then
            table.insert(floating_clients, c)
        end
    end

    return floating_clients
end

function M.minimize_all_but_focused()
    local focused_client = client.focus

    if not focused_client then
        naughty.notify { text = "No focused client!" }
        return
    end

    local screen_clients = focused_client.screen.clients
    for _, c in ipairs(screen_clients) do
        if c ~= focused_client and (awful.layout.get(c.screen) == awful.layout.suit.floating or c.floating) then
            c.minimized = true
        end
    end
end

return M
