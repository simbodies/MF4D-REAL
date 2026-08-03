// scr_switch_layers.gml
function switch_character_layers() {
    // Get the current room
    var _current_room = room;
    
    // Check which room we're in (in case you use this button elsewhere)
    if (_current_room == character_select_screen) {
        
        // Check if characters_instance layer is visible
        if (layer_get_visible("characters_instance")) {
            // Hide characters, show body
            layer_set_visible("characters_instance", false);
            layer_set_visible("body_instances", true);
            show_debug_message("Switched to BODY selection");
        } else {
            // Hide body, show characters
            layer_set_visible("characters_instance", true);
            layer_set_visible("body_instances", false);
            show_debug_message("Switched to CHARACTER selection");
        }
    }
}