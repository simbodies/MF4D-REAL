// Update cooldown
if (click_cooldown > 0) {
    click_cooldown--;
}

// Check for mouse click on button
if (position_meeting(mouse_x, mouse_y, id)) {
    // Mouse is over button
    if (mouse_check_button_pressed(mb_left) && click_cooldown == 0) {
        show_debug_message("=== BUTTON CLICKED ===");
        
        // Check if layers exist
        var layer1_exists = layer_exists("characters_instance");
        var layer2_exists = layer_exists("body_instances");
        
        // Fix: Convert booleans to strings properly
        show_debug_message("characters_instance exists: " + string(layer1_exists));
        show_debug_message("body_instances exists: " + string(layer2_exists));
        
        if (layer1_exists && layer2_exists) {
            // Get current visibility
            var char_visible = layer_get_visible("characters_instance");
            // Fix: Convert visibility to strings properly
            show_debug_message("Current - characters: " + string(char_visible) + ", body: " + string(layer_get_visible("body_instances")));
            
            // Toggle layers
            layer_set_visible("characters_instance", !char_visible);
            layer_set_visible("body_instances", char_visible);
            
            show_debug_message("New - characters: " + string(layer_get_visible("characters_instance")) + ", body: " + string(layer_get_visible("body_instances")));
        } else {
            show_debug_message("ERROR: Layers missing!");
        }
        
        click_cooldown = 30;
    }
}