--- Arch Linux Image
--[[
  ali_surface = cairo_image_surface_create_from_png ("~/.config/conky/image/ArchLinux.png")
  ali_width = cairo_image_surface_get_width(ali_image)
  ali_height = cairo_image_surface_get_height(ali_image)

  cairo_scale (cr, 1, 1)
  cairo_set_source_surface (ali_surface, ali_image, 0, 0)
  --cairo_surface_destroy(ali_image)
  cairo_paint (cr) ]]
