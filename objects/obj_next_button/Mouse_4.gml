// Left Pressed event for obj_next_button
if (object_exists(obj_character_preview)) {
    // Toggle through five states
    with (obj_character_preview) {
        // Cycle through states: character -> color -> body -> leg -> planet -> back to character
        if (show_character_layer) {
            show_character_layer = false;
            show_color_layer = true;
            show_body_layer = false;
            show_leg_layer = false;
            show_planet_layer = false;
            active_layer = "color";
        } else if (show_color_layer) {
            show_character_layer = false;
            show_color_layer = false;
            show_body_layer = true;
            show_leg_layer = false;
            show_planet_layer = false;
            active_layer = "body";
        } else if (show_body_layer) {
            show_character_layer = false;
            show_color_layer = false;
            show_body_layer = false;
            show_leg_layer = true;
            show_planet_layer = false;
            active_layer = "leg";
        } else if (show_leg_layer) {
            show_character_layer = false;
            show_color_layer = false;
            show_body_layer = false;
            show_leg_layer = false;
            show_planet_layer = true;
            active_layer = "planet";
        } else if (show_planet_layer) {
            show_character_layer = true;
            show_color_layer = false;
            show_body_layer = false;
            show_leg_layer = false;
            show_planet_layer = false;
            active_layer = "character";
        }
    }
    
    // Show/hide the actual layers
    layer_set_visible("char_buttons", obj_character_preview.show_character_layer);
    layer_set_visible("color_buttons", obj_character_preview.show_color_layer);
    layer_set_visible("body_buttons", obj_character_preview.show_body_layer);
    layer_set_visible("leg_buttons", obj_character_preview.show_leg_layer);
    layer_set_visible("planet_buttons", obj_character_preview.show_planet_layer);
    
    // Update debug message
    var current_display = "";
    if (obj_character_preview.show_character_layer) {
        current_display = "CHARACTER buttons";
    } else if (obj_character_preview.show_color_layer) {
        current_display = "COLOR buttons";
    } else if (obj_character_preview.show_body_layer) {
        current_display = "BODY buttons";
    } else if (obj_character_preview.show_leg_layer) {
        current_display = "LEG buttons";
    } else if (obj_character_preview.show_planet_layer) {
        current_display = "PLANET buttons";
    }
    show_debug_message("Now showing: " + current_display);
}