local wibox = require("wibox")

-- Battery
local battery = wibox.widget({
	widget = wibox.widget.textbox,
	font = Font,
	markup = "  ",
})

local capacity

awesome.connect_signal("signal::battery", function(bat_zero, bat_one)
	-- Battery signals are not available immediately after startup
	-- This validation avoids error messages
	if not bat_zero and not bat_one then
		capacity = 0
	else
		-- This adds both batteries resulting in values until 200%
		capacity = bat_zero + bat_one
	end

	if capacity < 50 then
		battery.markup = "<span foreground='" .. Color.red .. "'>  " .. capacity .. "% </span>"
	else
		battery.markup = "<span foreground='" .. Color.green .. "'>  </span>"
	end
end)

return {
	battery,
	layout = wibox.layout.fixed.horizontal,
}