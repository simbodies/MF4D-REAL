// Draw all planets (behind character)
if (planet_display_active && ds_list_size(planet_list) > 0) {
    // Get character dimensions
    var char_width = sprite_get_width(current_sprite) * current_scale;
    var char_height = sprite_get_height(current_sprite) * current_scale;
    
    // Calculate character center (original top-left at display_x, display_y)
    var char_center_x = display_x + (char_width / 2);
    var char_center_y = display_y + (char_height / 2);
    
    // Get actual visible bottom of character
    var char_visible_bottom = char_center_y + (get_sprite_visible_bottom(current_sprite, current_scale));
    
    var spacing_from_character = 2; // Small gap between character and first planet
    var spacing_between_planets = 120; // Small gap between planets
    var current_y = char_visible_bottom + spacing_from_character;
    var last_planet_bottom = 0;
    
    // Calculate position offsets with multipliers (apply when planets or leg sprites are active)
    var pos_x_offset = 0;
    var pos_y_offset = 0;
    
    if (planet_display_active || active_leg_sprite != noone) {
        pos_x_offset = model_x_offset * auto_position_x_multiplier;
        pos_y_offset = model_y_offset * auto_position_y_multiplier;
    }
    
    for (var i = 0; i < ds_list_size(planet_list); i++) {
        var planet_data = planet_list[| i];
        var planet_sprite = planet_data[0];
        var planet_scale = planet_data[1] * current_scale;
        
        // Center planets relative to character's center X
        var planet_width = sprite_get_width(planet_sprite) * planet_scale;
        var planet_x = char_center_x - (planet_width / 2);
        
        draw_sprite_ext(planet_sprite, 0, planet_x + pos_x_offset, current_y + pos_y_offset, 
                        planet_scale, planet_scale, 0, c_white, 1);
        
        // Get actual visible bottom of this planet
        var planet_visible_bottom = get_sprite_visible_bottom(planet_sprite, planet_scale);
        
        // Store the bottom position of the last planet
        last_planet_bottom = current_y + planet_visible_bottom;
        
        // Move down by visible height + spacing for next planet
        current_y += planet_visible_bottom + spacing_between_planets;
    }
    
    // Determine leg sprite Y position (bottom of last planet + 3 pixels)
    var leg_sprite_y_pos = last_planet_bottom + 3;
    
    // Draw character centered at char_center_x, char_center_y
    if (current_sprite != noone) {
        var char_x = char_center_x - (char_width / 2) + pos_x_offset;
        var char_y = char_center_y - (char_height / 2) + pos_y_offset;
        
        if (use_shader) {
            shader_set(shd_replace_white);
            
            var uni_color = shader_get_uniform(shd_replace_white, "u_replace_color");
            var r = (replace_color >> 16) & 255;
            var g = (replace_color >> 8) & 255;
            var b = replace_color & 255;
            shader_set_uniform_f(uni_color, r/255.0, g/255.0, b/255.0, 1.0);
            
            draw_sprite_ext(current_sprite, 0, char_x, char_y, current_scale, current_scale, 0, c_white, 1);
            
            // Draw active body sprite overlay with shader
            if (active_body_sprite != noone) {
                draw_sprite_ext(active_body_sprite, 0, char_x + body_sprite_x_offset, char_y + body_sprite_y_offset, current_scale * body_sprite_scale, current_scale * body_sprite_scale, 0, c_white, 1);
            }
            
            // Draw active leg sprite overlay with shader at bottom edge
            if (active_leg_sprite != noone) {
                var leg_sprite_height = sprite_get_height(active_leg_sprite) * (current_scale * leg_sprite_scale);
                var final_y = leg_sprite_y_pos + leg_sprite_y_offset + (leg_sprite_height * leg_sprite_y_multiplier) + pos_y_offset;
                draw_sprite_ext(active_leg_sprite, 0, char_x + leg_sprite_x_offset, final_y, current_scale * leg_sprite_scale, current_scale * leg_sprite_scale, 0, c_white, 1);
            }
            
            shader_reset();
        } else {
            draw_sprite_ext(current_sprite, 0, char_x, char_y, current_scale, current_scale, 0, c_white, 1);
            
            // Draw active body sprite overlay without shader
            if (active_body_sprite != noone) {
                draw_sprite_ext(active_body_sprite, 0, char_x + body_sprite_x_offset, char_y + body_sprite_y_offset, current_scale * body_sprite_scale, current_scale * body_sprite_scale, 0, c_white, 1);
            }
            
            // Draw active leg sprite overlay without shader at bottom edge
            if (active_leg_sprite != noone) {
                var leg_sprite_height = sprite_get_height(active_leg_sprite) * (current_scale * leg_sprite_scale);
                var final_y = leg_sprite_y_pos + leg_sprite_y_offset + (leg_sprite_height * leg_sprite_y_multiplier) + pos_y_offset;
                draw_sprite_ext(active_leg_sprite, 0, char_x + leg_sprite_x_offset, final_y, current_scale * leg_sprite_scale, current_scale * leg_sprite_scale, 0, c_white, 1);
            }
        }
    }
} else {
    // No planets active - draw character normally
    if (current_sprite != noone) {
        // Calculate position offsets (only apply when leg sprite is active)
        var pos_x_offset = 0;
        var pos_y_offset = 0;
        
        if (active_leg_sprite != noone) {
            pos_x_offset = model_x_offset * auto_position_x_multiplier;
            pos_y_offset = model_y_offset * auto_position_y_multiplier;
        }
        
        // Get character bottom edge
        var char_height = sprite_get_height(current_sprite) * current_scale;
        var char_bottom = display_y + char_height;
        var leg_sprite_y_pos = char_bottom + 3;
        
        if (use_shader) {
            shader_set(shd_replace_white);
            
            var uni_color = shader_get_uniform(shd_replace_white, "u_replace_color");
            var r = (replace_color >> 16) & 255;
            var g = (replace_color >> 8) & 255;
            var b = replace_color & 255;
            shader_set_uniform_f(uni_color, r/255.0, g/255.0, b/255.0, 1.0);
            
            draw_sprite_ext(current_sprite, 0, display_x + pos_x_offset, display_y + pos_y_offset, current_scale, current_scale, 0, c_white, 1);
            
            // Draw active body sprite overlay with shader
            if (active_body_sprite != noone) {
                draw_sprite_ext(active_body_sprite, 0, display_x + pos_x_offset + body_sprite_x_offset, display_y + pos_y_offset + body_sprite_y_offset, current_scale * body_sprite_scale, current_scale * body_sprite_scale, 0, c_white, 1);
            }
            
            // Draw active leg sprite overlay with shader at bottom edge
            if (active_leg_sprite != noone) {
                var leg_sprite_height = sprite_get_height(active_leg_sprite) * (current_scale * leg_sprite_scale);
                var final_y = leg_sprite_y_pos + leg_sprite_y_offset + (leg_sprite_height * leg_sprite_y_multiplier) + pos_y_offset;
                draw_sprite_ext(active_leg_sprite, 0, display_x + pos_x_offset + leg_sprite_x_offset, final_y, current_scale * leg_sprite_scale, current_scale * leg_sprite_scale, 0, c_white, 1);
            }
            
            shader_reset();
        } else {
            draw_sprite_ext(current_sprite, 0, display_x + pos_x_offset, display_y + pos_y_offset, current_scale, current_scale, 0, c_white, 1);
            
            // Draw active body sprite overlay without shader
            if (active_body_sprite != noone) {
                draw_sprite_ext(active_body_sprite, 0, display_x + pos_x_offset + body_sprite_x_offset, display_y + pos_y_offset + body_sprite_y_offset, current_scale * body_sprite_scale, current_scale * body_sprite_scale, 0, c_white, 1);
            }
            
            // Draw active leg sprite overlay without shader at bottom edge
            if (active_leg_sprite != noone) {
                var leg_sprite_height = sprite_get_height(active_leg_sprite) * (current_scale * leg_sprite_scale);
                var final_y = leg_sprite_y_pos + leg_sprite_y_offset + (leg_sprite_height * leg_sprite_y_multiplier) + pos_y_offset;
                draw_sprite_ext(active_leg_sprite, 0, display_x + pos_x_offset + leg_sprite_x_offset, final_y, current_scale * leg_sprite_scale, current_scale * leg_sprite_scale, 0, c_white, 1);
            }
        }
    }
}