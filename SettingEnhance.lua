--- STEAMODDED HEADER
--- MOD_NAME: 设置增强
--- MOD_ID: SettingEnhance
--- MOD_AUTHOR: [Ash_K]
--- MOD_DESCRIPTION: 设置增强，具体功能如下： 显示帧率 开关Shader模式（可减少GPU使用率，默认开启，会使画面变灰,但是解决天机手机黑屏） 开关金手指模式(打开会减少游戏游玩体验)  调整字体大小 渲染比例 帧率限制

----------------------------------------------
------------MOD CODE -------------------------

function SettingEnhance_mod_init()
    if G.SETTINGS.Enhance == nil then
        G.SETTINGS.Enhance = {
            showFPS = false,
            goldFingerEnable = false,
            disableCrtShader = true,
            canvScale = 1.0,
            fontScale = 1.0,
            fpsCap = 60,
        }
    end

    G.recording_mode = G.SETTINGS.Enhance.disableCrtShader
    
    G.FONTS[2].FONTSCALE = 0.12 * G.SETTINGS.Enhance.fontScale
    G.FPS_CAP = G.SETTINGS.Enhance.fpsCap
end


G.FUNCS.reset_SettingEnhance_defualt_settings = function(e)
    G.SETTINGS.Enhance = {
        showFPS = false,
        goldFingerEnable = false,
        disableCrtShader = true,
        canvScale = 1.0,
        fontScale = 1.0,
        fpsCap = 60,
    }
    G.recording_mode = G.SETTINGS.Enhance.disableCrtShader


    G.FONTS[2].FONTSCALE = 0.12 * G.SETTINGS.Enhance.fontScale
end


G.FUNCS.change_CANV_SCALE = function(args)
    G.SETTINGS.Enhance.canvScale = args.to_val
    G:save_settings()
end

G.FUNCS.change_FPS_CAP = function(args)
    G.SETTINGS.Enhance.fpsCap = args.to_val
    G.FPS_CAP = G.SETTINGS.Enhance.fpsCap
    G:save_settings()
end
G.FUNCS.change_Font_Scale = function(args)
    G.SETTINGS.Enhance.fontScale = args.to_val
    G.FONTS[2].FONTSCALE = 0.12 * G.SETTINGS.Enhance.fontScale
    G:save_settings()
end


SettingEnhance_mod_init()


local settings_ref = G.UIDEF.settings_tab
function G.UIDEF.settings_tab(tab)
    local t = settings_ref(tab)
    if tab == 'NewBee' then
        return {
            n = G.UIT.ROOT,
            config = { align = "cm", padding = 0.05, colour = G.C.CLEAR },
            nodes = {
                create_toggle({ label = "显示帧率", ref_table = G.SETTINGS.Enhance, ref_value = 'showFPS',callback =(
                    function(_set_toggle)
                        G:save_settings()
                    end
                )  }),
                create_toggle({ label = "是否关闭Shader(减少GPU占用)", ref_table = G.SETTINGS.Enhance, ref_value = 'disableCrtShader' ,callback =(
                    function(_set_toggle)
                        G.recording_mode = G.SETTINGS.Enhance.disableCrtShader
                        G:save_settings()
                    end
                )  }),

                -- G.FPS_CAP
                create_option_cycle({
                    label = "帧率限制(移动端可能得关闭垂直同步生效)",
                    scale = 0.8,
                    options = { 30, 60, 90, 120, 144 , 180 , 500},
                    opt_callback =
                    'change_FPS_CAP',
                    current_option = (
                        G.SETTINGS.Enhance.fpsCap == 30 and 1 or
                        G.SETTINGS.Enhance.fpsCap == 60 and 2 or
                        G.SETTINGS.Enhance.fpsCap == 90 and 3 or
                        G.SETTINGS.Enhance.fpsCap == 120 and 4 or
                        G.SETTINGS.Enhance.fpsCap == 144 and 5 or
                        G.SETTINGS.Enhance.fpsCap == 180 and 6 or
                        G.SETTINGS.Enhance.fpsCap == 500 and 7
                    )
                }),
                create_option_cycle({
                    label = "字体大小倍率",
                    scale = 0.8,
                    options = { 0.85, 0.95, 1.0, 1.05, 1.1, 1.15, 1.2, 1.3 ,1.5,1.8,2.0,2.5},
                    opt_callback =
                    'change_Font_Scale',
                    current_option = (
                        G.SETTINGS.Enhance.fontScale == 0.95 and 1 or
                        G.SETTINGS.Enhance.fontScale == 0.85 and 2 or
                        G.SETTINGS.Enhance.fontScale == 1.0 and 3 or
                        G.SETTINGS.Enhance.fontScale == 1.05 and 4 or
                        G.SETTINGS.Enhance.fontScale == 1.1 and 5 or
                        G.SETTINGS.Enhance.fontScale == 1.15 and 6 or
                        G.SETTINGS.Enhance.fontScale == 1.2 and 7 or
                        G.SETTINGS.Enhance.fontScale == 1.3 and 8 or
                        G.SETTINGS.Enhance.fontScale == 1.5 and 9 or
                        G.SETTINGS.Enhance.fontScale == 1.8 and 10 or
                        G.SETTINGS.Enhance.fontScale == 2.0 and 11 or
                        G.SETTINGS.Enhance.fontScale == 2.5 and 12
                    )
                }),
                create_option_cycle{
                    label = "渲染比例(减少可以提高性能，但会降低画质,重启生效)",
                    scale = 0.8,
                    options = { 0.2, 0.25, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.2 },
                    opt_callback = 'change_CANV_SCALE',
                    current_option = (
                        G.SETTINGS.Enhance.canvScale == 0.2 and 1 or
                        G.SETTINGS.Enhance.canvScale == 0.25 and 2 or
                        G.SETTINGS.Enhance.canvScale == 0.5 and 3 or
                        G.SETTINGS.Enhance.canvScale == 0.6 and 4 or
                        G.SETTINGS.Enhance.canvScale == 0.7 and 5 or
                        G.SETTINGS.Enhance.canvScale == 0.8 and 6 or
                        G.SETTINGS.Enhance.canvScale == 0.9 and 7 or
                        G.SETTINGS.Enhance.canvScale == 1.0 and 8 or
                        G.SETTINGS.Enhance.canvScale == 1.2 and 9
                    )
                },
                {
                    n = G.UIT.R,
                    config = { align = "cm", minw = 0.8, maxw = 1.5, minh = 0.6, padding = 0.05, r = 0.1, hover = true, colour = G.C.RED, button = "reset_SettingEnhance_defualt_settings", shadow = true, focus_args = { nav = 'wide' } },
                    nodes = {
                        { n = G.UIT.T, config = { text = "还原默认设置", scale = 1.0, colour = G.C.UI.TEXT_LIGHT } }
                    }
                },
            }
        }
    end

    return t
end

--- PRIORITY: 788
--- DISPLAY_NAME: 设置增强
--- BADGE_COLOUR: #EE1289
----------------------------------------------
------------MOD CODE END----------------------