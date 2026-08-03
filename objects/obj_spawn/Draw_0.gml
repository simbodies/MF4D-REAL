// Draw event for obj_spawn

// Safety check - make sure sprite is valid
if (sprite_index == -1 || sprite_index == noone) {
    exit;
}

// Debug: Check if we should be drawing planets
show_debug_message("DRAW: planet_display_active=" + string(planet_display_active) + 
                  ", planet_list_size=" + string(ds_list_size(planet_list)));

// Draw planets first (behind)
if (planet_display_active && ds_list_size(planet_list) > 0) {
    // Get character dimensions
    var char_width = sprite_get_width(sprite_index) * image_scale;
    var char_height = sprite_get_height(sprite_index) * image_scale;
    
    // Calculate character's bottom edge based on sprite origin
    var char_origin_y = y; // The instance's Y position (where origin is)
    var char_bottom_y = char_origin_y + (sprite_get_yoffset(sprite_index) * image_scale);
    
    var spacing = 60; // Gap between planets
    var current_y = char_bottom_y + spacing + 65; // 50 pixel Y offset
    var last_planet_bottom = 0;
    
    // Character's center X is just x (since origin is at center)
    var char_center_x = x;
    
    for (var i = 0; i < ds_list_size(planet_list); i++) {
        var planet_data = planet_list[| i];
        var planet_sprite = planet_data[0];
        var planet_scale = image_scale * 0.065; // 10% of character size
        
        // Safety check for planet sprite
        if (planet_sprite == -1 || planet_sprite == noone) continue;
        
        // Center planets relative to character's center X
        var planet_width = sprite_get_width(planet_sprite) * planet_scale;
        var planet_x = char_center_x - (planet_width / 2) + 60; // 50 pixel X offset
        
        // Debug each planet
        show_debug_message("DRAW PLANET: sprite=" + string(planet_sprite) + 
                          ", x=" + string(planet_x) + 
                          ", y=" + string(current_y) + 
                          ", scale=" + string(planet_scale));
        
        draw_sprite_ext(planet_sprite, 0, planet_x, current_y, 
                        planet_scale, planet_scale, 0, c_white, 1);
        
        // Store bottom of last planet
        var planet_height = sprite_get_height(planet_sprite) * planet_scale;
        last_planet_bottom = current_y + planet_height;
        
        // Move down by planet height + spacing
        current_y += spacing;
    }
    
    // Determine leg sprite Y position (bottom of last planet + 3 pixels)
    var leg_sprite_y_pos = last_planet_bottom + 3;
    
    // Draw character with shader
    if (use_shader) {
        shader_set(shd_replace_white);
        
        var uni_color = shader_get_uniform(shd_replace_white, "u_replace_color");
        var r = (replace_color >> 16) & 255;
        var g = (replace_color >> 8) & 255;
        var b = replace_color & 255;
        shader_set_uniform_f(uni_color, r/255.0, g/255.0, b/255.0, 1.0);
        
        draw_self();
        
        // Draw active body sprite overlay with shader (with multiplier)
        if (active_body_sprite != noone) {
            draw_sprite_ext(active_body_sprite, 0, x + body_sprite_x_offset, y + body_sprite_y_offset, image_scale * body_sprite_multiplier, image_scale * body_sprite_multiplier, 0, c_white, 1);
        }
        
        // Draw active leg sprite overlay with shader (with multiplier)
        if (active_leg_sprite != noone) {
            draw_sprite_ext(active_leg_sprite, 0, x + leg_sprite_x_offset, leg_sprite_y_pos, image_scale * leg_sprite_multiplier, image_scale * leg_sprite_multiplier, 0, c_white, 1);
        }
        
        shader_reset();
    } else {
        draw_self();
        
        // Draw active body sprite overlay without shader (with multiplier)
        if (active_body_sprite != noone) {
            draw_sprite_ext(active_body_sprite, 0, x + body_sprite_x_offset, y + body_sprite_y_offset, image_scale * body_sprite_multiplier, image_scale * body_sprite_multiplier, 0, c_white, 1);
        }
        
        // Draw active leg sprite overlay without shader (with multiplier)
        if (active_leg_sprite != noone) {
            draw_sprite_ext(active_leg_sprite, 0, x + leg_sprite_x_offset, leg_sprite_y_pos, image_scale * leg_sprite_multiplier, image_scale * leg_sprite_multiplier, 0, c_white, 1);
        }
    }
} else {
    // No planets - draw character normally
    var char_height = sprite_get_height(sprite_index) * image_scale;
    var char_bottom = y + (sprite_get_yoffset(sprite_index) * image_scale);
    var leg_sprite_y_pos = char_bottom + 3;
    
    if (use_shader) {
        shader_set(shd_replace_white);
        
        var uni_color = shader_get_uniform(shd_replace_white, "u_replace_color");
        var r = (replace_color >> 16) & 255;
        var g = (replace_color >> 8) & 255;
        var b = replace_color & 255;
        shader_set_uniform_f(uni_color, r/255.0, g/255.0, b/255.0, 1.0);
        
        draw_self();
        
        // Draw active body sprite overlay with shader (with multiplier)
        if (active_body_sprite != noone) {
            draw_sprite_ext(active_body_sprite, 0, x + body_sprite_x_offset, y + body_sprite_y_offset, image_scale * body_sprite_multiplier, image_scale * body_sprite_multiplier, 0, c_white, 1);
        }
        
        // Draw active leg sprite overlay with shader (with multiplier)
        if (active_leg_sprite != noone) {
            draw_sprite_ext(active_leg_sprite, 0, x + leg_sprite_x_offset, leg_sprite_y_pos, image_scale * leg_sprite_multiplier, image_scale * leg_sprite_multiplier, 0, c_white, 1);
        }
        
        shader_reset();
    } else {
        draw_self();
        
        // Draw active body sprite overlay without shader (with multiplier)
        if (active_body_sprite != noone) {
            draw_sprite_ext(active_body_sprite, 0, x + body_sprite_x_offset, y + body_sprite_y_offset, image_scale * body_sprite_multiplier, image_scale * body_sprite_multiplier, 0, c_white, 1);
        }
        
        // Draw active leg sprite overlay without shader (with multiplier)
        if (active_leg_sprite != noone) {
            draw_sprite_ext(active_leg_sprite, 0, x + leg_sprite_x_offset, leg_sprite_y_pos, image_scale * leg_sprite_multiplier, image_scale * leg_sprite_multiplier, 0, c_white, 1);
		
        }
    }
}