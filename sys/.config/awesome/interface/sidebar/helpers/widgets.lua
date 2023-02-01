local wibox = require("wibox")
local gears = require("gears")

local _widgets = {}

local function bar()
    return function(cr, w, h)
        gears.shape.rounded_bar(cr, w, h)
    end
end

local bar_color = Color.blue
local bar_background = Color.fg
local bar_height = xdpi(10)
local bar_width = xdpi(200)

function _widgets.wrapping_widget(widget)
    return wibox.widget {
        nil,
        {
            nil,
            widget,
            expand = "none",
            layout = wibox.layout.align.horizontal,
        },
        expand = "none",
        layout = wibox.layout.align.vertical,
    }
end

function _widgets.basic_widget(icon)
    return wibox.widget({
        markup = icon,
        font = Bold_Font,
        align = "center",
        widget = wibox.widget.textbox,
    })
end

function _widgets.basic_text()
    return wibox.widget {
        markup = "<span foreground='" .. Color.fg .. "'> ! </span>",
        valign = "center",
        halign = "center",
        widget = wibox.widget.textbox,
    }
end

function _widgets.basic_markup(value, symbol)
    text = tostring(value)
    return "<span foreground='" .. Color.fg .. "'>" .. text .. symbol .. "</span>"
end

function _widgets.grouping_widget(icon, slider)
    return wibox.widget {
        icon,
        slider,
        spacing = xdpi(10),
        layout = wibox.layout.fixed.horizontal,
    }
end

function _widgets.horizontal_group(icon, widget, label)
    return wibox.widget {
        icon,
        widget,
        label,
        forced_height = bar_height,
        spacing = xdpi(5),
        layout = wibox.layout.fixed.horizontal,
    }
end

function _widgets.basic_progressbar(max_bar_value)
    return wibox.widget {
        forced_height = bar_height,
        forced_width = bar_width,
        color = bar_color,
        background_color = bar_background,
        shape = bar(),
        bar_shape = bar(),
        max_value = max_bar_value,
        widget = wibox.widget.progressbar,
    }
end

function _widgets.basic_stack(slider, text)
    return wibox.widget {
        slider,
        text,
        forced_height = bar_height,
        layout = wibox.layout.stack
    }
end
return _widgets