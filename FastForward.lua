--- STEAMODDED HEADER
--- MOD_NAME: FastForward
--- MOD_ID: FastForward
--- MOD_AUTHOR: [bloopygup]
--- MOD_DESCRIPTION: More Speed options!

----------------------------------------------
------------MOD CODE-------------------------


FF = { label = { text = "" } }

local orig_hud = create_UIBox_HUD
function create_UIBox_HUD()
    local contents = orig_hud()

    FF.label.text = G.SETTINGS.GAMESPEED .. "X"

    local my_button = {
        n = G.UIT.C,
        config = {
            id = "FastForward",
            button = "speedChange",
            align = "cm",
            minh = 0.42,
            minw = 1.5,
            padding = 0.05,
            r = 0.02,
            colour = G.C.ORANGE,
            hover = true,
            shadow = true,
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText({
                                string = { { ref_table = FF.label, ref_value = "text" } },
                                colours = { G.C.UI.TEXT_LIGHT },
                                shadow = true,
                                scale = 0.36,
                            }),
                        },
                    },
                },
            },
        },
    }
    -- Find multiplayer's fn_calculate_score_button_wrap and insert next to the calculate button
    local hud_nodes = contents.nodes[1].nodes[1].nodes[4].nodes[1].nodes
    for _, node in ipairs(hud_nodes) do
        if node.config and node.config.id == "fn_real_wrap" then
            table.insert(node.nodes, 3, {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.05 },
                nodes = { my_button },
            })
            return contents
        end
    end
    -- Fallback: multiplayer not present, insert as its own row
    table.insert(hud_nodes, {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.1 },
        nodes = { my_button },
    })
    return contents
end

function G.FUNCS.speedChange(e)
    local speeds = { 0.5, 1, 2, 4, 8 }
    for index, value in ipairs(speeds) do
        if G.SETTINGS.GAMESPEED == value and not (index == #speeds) then
            G.SETTINGS.GAMESPEED = speeds[index + 1]
            break
        elseif index == 5 then
            G.SETTINGS.GAMESPEED = .5
        end
    end
    FF.label.text = G.SETTINGS.GAMESPEED .. "X"
end

local tempspeedhold
SMODS.Keybind {
    key_pressed = 'space',
    event = "pressed",
    action = function(self)
        tempspeedhold = G.SETTINGS.GAMESPEED
        G.SETTINGS.GAMESPEED = 35
        FF.label.text = G.SETTINGS.GAMESPEED .. "X"
    end
}
SMODS.Keybind {
    key_pressed = 'space',
    event = "released",
    action = function(self)
        if not (tempspeedhold == nil) then
            G.SETTINGS.GAMESPEED = tempspeedhold
            FF.label.text = G.SETTINGS.GAMESPEED .. "X"

        else
            G.SETTINGS.GAMESPEED = 1
            FF.label.text = G.SETTINGS.GAMESPEED .. "X"
        end
    end
}
