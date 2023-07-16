local mp = require("mp")

local osc = {
    visible = false,
    always = false,
    count = 0
}

osc.inc = function(n)
    osc.count = osc.count + n
end

osc.toggle = function(v)
    osc[v] = not osc[v]

    mp.command_native {
        "script-message",
        "osc-visibility",
        osc[v] and "always" or "auto",
        "no-osd"
    }
end

local osc_show = function()
    if osc.always then
        return
    end

    osc.inc(1)

    if not osc.visible then
        osc.toggle("visible")
    end

    mp.add_timeout(2, function()
        osc.inc(-1)

        if not osc.always and osc.count == 0 then
            osc.toggle("visible")
        end
    end)
end

mp.observe_property("seeking", nil, osc_show)
mp.add_key_binding("o", osc_show)
mp.add_key_binding("O", function() osc.toggle("always") end)
