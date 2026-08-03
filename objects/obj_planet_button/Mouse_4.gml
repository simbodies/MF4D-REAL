// Left Pressed event for obj_planet_button
show_debug_message("Planet button clicked - checking for obj_character_preview");

// Check if obj_character_preview exists
if (!object_exists(obj_character_preview)) {
    show_debug_message("ERROR: obj_character_preview object doesn't exist!");
    exit;
}

// Check if there's an instance of obj_character_preview
var inst = instance_find(obj_character_preview, 0);
if (inst != noone) {
    show_debug_message("Found obj_character_preview instance");
    
    // Get reference to the character preview instance
    var char_preview = inst;
    
    // Check if this planet sprite is already showing
    if (char_preview.current_planet_sprite == planet_sprite && char_preview.planet_sprite_visible) {
        // Hide the planet sprite
        show_debug_message("Hiding planet sprite");
        char_preview.planet_sprite_visible = false;
        
        // Find and destroy existing planet sprite
        var planet_inst = instance_find(obj_planet_sprite, 0);
        if (planet_inst != noone) {
            with (planet_inst) {
                instance_destroy();
            }
        }
        char_preview.current_planet_sprite = noone;
    } else {
        // Hide any existing planet sprite
        show_debug_message("Showing new planet sprite");
        if (char_preview.planet_sprite_visible) {
            var planet_inst = instance_find(obj_planet_sprite, 0);
            if (planet_inst != noone) {
                with (planet_inst) {
                    instance_destroy();
                }
            }
        }
        
        // Check if obj_planet_sprite object exists
        if (!object_exists(obj_planet_sprite)) {
            show_debug_message("ERROR: obj_planet_sprite object doesn't exist!");
            exit;
        }
        
        // Create the planet sprite
        var new_planet = instance_create_layer(char_preview.x, char_preview.y, "Instances", obj_planet_sprite);
        if (new_planet != noone) {
            new_planet.sprite_index = planet_sprite;
            new_planet.image_xscale = 0.5;  // Adjust as needed
            new_planet.image_yscale = 0.5;  // Adjust as needed
            new_planet.depth = char_preview.depth + 1;
            
            char_preview.current_planet_sprite = planet_sprite;
            char_preview.planet_sprite_visible = true;
            show_debug_message("Planet sprite created successfully");
        }
    }
} else {
    show_debug_message("ERROR: No instance of obj_character_preview found!");
}