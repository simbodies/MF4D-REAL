// Step event of obj_input_handler
if (mouse_check_button_pressed(mb_left)) {
    // First check if we're in character mode or color mode
    var show_chars = obj_character_preview.show_character_layer;
    
    // Get ALL instances under the mouse
    var list = ds_list_create();
    if (show_chars) {
        // Only check character buttons
        collision_point_list(mouse_x, mouse_y, obj_character_button_parent, false, true, list, false);
    } else {
        // Only check color buttons
        collision_point_list(mouse_x, mouse_y, obj_color_button_parent, false, true, list, false);
    }
    
    // Sort by depth (lowest depth = highest/ topmost)
    ds_list_sort(list, true);
    
    // If we found any buttons, click the top one
    if (ds_list_size(list) > 0) {
        var top_button = list[| 0]; // First in list = topmost
        
        // Manually trigger that button's click action
        with (top_button) {
            // Character buttons
            if (object_is_ancestor(object_index, obj_character_button_parent)) {
                with (obj_character_preview) {
                    set_selected(other.sprite_index); // Adjust based on your setup
                }
            }
            // Color buttons
            else if (object_is_ancestor(object_index, obj_color_button_parent)) {
                with (obj_character_preview) {
                    replace_color = other.button_color; // You'll need to store color in each button
                    use_shader = true;
                }
            }
        }
    }
    
    ds_list_destroy(list);
    mouse_clear(mb_left); // Prevent any other mouse events
}