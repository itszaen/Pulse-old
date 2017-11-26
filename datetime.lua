function datetime()
local extents=cairo_text_extents_t:create()
tolua.takeownership(extents)

dtcenter_font="Noto Sans"
dtcenter_font_slant = CAIRO_FONT_SLANT_NORMAL
dtcenter_font_face = CAIRO_FONT_WEIGHT_NORMAL
dtcenter_font_size=96
dtcenter_seconds=os.date("%S")
dtcenter_minutes=os.date("%M")
dtcenter_hours=os.date("%H")
dtcenter_text = dtcenter_hours .. ":" .. dtcenter_minutes .. ":" .. dtcenter_seconds

cairo_select_font_face (cr, dtcenter_font, dtcenter_font_slant, dtcenter_font_face)
cairo_set_font_size (cr, dtcenter_font_size)
cairo_set_source_rgba (cr,1,1,1,0.6)
cairo_text_extents (cr, dtcenter_text, extents)
dtcenter_xpos = screen_x/2 - (extents.width/2 + extents.x_bearing)
dtcenter_ypos = screen_y/2 - (extents.height/2 + extents.y_bearing)
cairo_move_to (cr, dtcenter_xpos, dtcenter_ypos)
cairo_show_text (cr, dtcenter_text)
cairo_stroke(cr)
end
