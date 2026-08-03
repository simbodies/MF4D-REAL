// Left Pressed event for button_orange
if (object_exists(obj_character_preview) && obj_character_preview.active_layer == "planet") {
    with (obj_character_preview) {
        // Check if this planet is already in the list
        var index = -1;
        for (var i = 0; i < ds_list_size(planet_list); i++) {
            var planet_data = planet_list[| i];
            if (planet_data[0] == Orange_planet) {
                index = i;
                break;
            }
        }
        
        if (index >= 0) {
            // Remove the planet if already selected
            ds_list_delete(planet_list, index);
            show_debug_message("Removing planet: " + string(Orange_planet));
        } else {
            // Add new planet with its scale to the list
            var planet_data = [Orange_planet, 0.40];
            ds_list_add(planet_list, planet_data);
            show_debug_message("Adding planet: " + string(Orange_planet) + " with scale: 0.40");
        }
        
        // Calculate total height including leg sprite
        var planet_count = ds_list_size(planet_list);
        if (planet_count == 0) {
            planet_display_active = false;
            current_scale = base_scale;
        } else {
            planet_display_active = true;
            
            // Calculate total height of all elements
            var total_height = 0;
            
            // Add character height
            var char_height = sprite_get_height(current_sprite) * base_scale;
            total_height += char_height;
            
            // Add spacing between character and first planet
            total_height += 2;
            
            // Add planet heights
            for (var i = 0; i < ds_list_size(planet_list); i++) {
                var planet_data = planet_list[| i];
                var planet_sprite = planet_data[0];
                var planet_base_scale = planet_data[1];
                var planet_height = get_sprite_visible_bottom(planet_sprite, planet_base_scale * base_scale);
                total_height += planet_height;
                
                // Add spacing between planets (except after last)
                if (i < ds_list_size(planet_list) - 1) {
                    total_height += 120;
                }
            }
            
            // Add leg sprite height if active
            if (active_leg_sprite != noone) {
                var leg_height = sprite_get_height(active_leg_sprite) * leg_sprite_scale;
                total_height += leg_height + 3;
            }
            
           var max_height = room_height - 100;  // Leave 100 pixels margin
var new_scale = base_scale * (max_height / total_height);
            
            // Apply additional shrink from planet count
            new_scale = new_scale * (0.85 - (planet_count * 0.075));
            
            // Set the scale
            current_scale = new_scale;
            
            // Ensure minimum scale
            if (current_scale < 0.4) current_scale = 0.4;
        }
    }
}