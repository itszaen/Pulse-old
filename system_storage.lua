function system_storage()
    ss_xpos = 82
    ss_ypos = 420
    ss_interval = 10
    ss_font="Inconsolata"
    ss_font_slant = CAIRO_FONT_SLANT_NORMAL
    ss_font_face = CAIRO_FONT_WEIGHT_NORMAL
    ss_font_size = 18
    ss_spacing = 1.4
    ss_red, ss_green, ss_blue = 0.60 ,0.60 ,1
    ss_alpha = 0.7

    ss_timer = (updates % ss_interval)
    cairo_select_font_face (cr, ss_font, ss_font_slant, ss_font_face)
    cairo_set_font_size (cr, ss_font_size)
    cairo_set_source_rgba(cr,ss_red,ss_green,ss_blue,ss_alpha)

    if ss_timer == 0 or conky_start == 1 then
    ss_content_table = {}
      ss_file = io.popen("df -h")
      for line in ss_file:lines() do
        ss_content = line
        table.insert(ss_content_table, ss_content)
      end
      ss_file:close()
    end
    n = 1
    for i, line in ipairs(ss_content_table) do
      ss_content = line
      ss_ypos = ss_ypos + ss_font_size*ss_spacing
      cairo_move_to (cr,ss_xpos ,ss_ypos)
      cairo_show_text (cr, ss_content)
      n = n + 1
    end
    cairo_stroke (cr)

end
