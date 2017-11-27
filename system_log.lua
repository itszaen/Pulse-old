function system_log()
    sl_xpos = 82
    sl_ypos = 790
    sl_interval = 1
    sl_font="Inconsolata"
    sl_font_slant = CAIRO_FONT_SLANT_NORMAL
    sl_font_face = CAIRO_FONT_WEIGHT_NORMAL
    sl_font_size = 12.5
    sl_spacing = 1.2
    sl_red, sl_green, sl_blue = 0.60 ,0.60 ,1
    sl_alpha = 0.8

    sl_timer = (updates % sl_interval)
    cairo_select_font_face (cr, sl_font, sl_font_slant, sl_font_face)
    cairo_set_font_size (cr, sl_font_size)
    cairo_set_source_rgba(cr,sl_red,sl_green,sl_blue,sl_alpha)

    if sl_timer == 0 or conky_start == 1 then
      sl_content_table = {}
      os.execute("~/.config/conky/journal_dump.sh")
      sl_file = io.open("/home/zaen/.config/conky/tmp/journal.txt", "r")
      for line in sl_file:lines() do
        sl_content = line
        table.insert(sl_content_table, sl_content)
      end
      sl_file:close()
    end
    n = 1
    for i, line in ipairs (sl_content_table) do
      sl_content = line
      sl_ypos = sl_ypos + sl_font_size*sl_spacing
      cairo_move_to (cr,sl_xpos , sl_ypos)
      cairo_show_text (cr, sl_content)
      n = n+1
    end

end
