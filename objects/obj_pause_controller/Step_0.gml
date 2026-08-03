/// @description Check for pause input

if (can_pause) {
    // Only pause with ESC - remove the unpause functionality from here
    if (keyboard_check_pressed(vk_escape) && !paused) {
        paused = true;
        
        // Pause the game
        instance_deactivate_all(true);
        
        // Make sure this pause controller stays active
        instance_activate_object(id);
    }
}

// Handle pause menu navigation (only when paused)
if (paused) {
    // Get the number of menu options dynamically
    var num_options = array_length(pause_menu_options);
    
    // Navigate menu
    if (keyboard_check_pressed(vk_down)) {
        pause_menu_option = (pause_menu_option + 1) % num_options;
    }
    if (keyboard_check_pressed(vk_up)) {
        pause_menu_option = (pause_menu_option - 1 + num_options) % num_options;
    }
    
    // Select option with SPACE
    if (keyboard_check_pressed(vk_enter)) {
        switch (pause_menu_option) {
            case 0: // Resume
                paused = false;
                instance_activate_all();
                break;
                
            case 1: // Restart
                instance_activate_all();
                room_restart();
                break;
                
            case 2: // Quit
                instance_activate_all();
                room_goto(title_screen);
                break;
        }
    }
    
    // REMOVED: The ESC close functionality - now ESC won't close the menu
    // You can ONLY close by selecting Resume or pressing Space on Resume
}

// Draw the pause menu
if (paused) {
    // Draw a semi-transparent background
    draw_set_alpha(0);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    
    // Draw menu options
    var y_pos = room_height / 2 - 50;
    for (var i = 0; i < array_length(pause_menu_options); i++) {
        if (i == pause_menu_option) {
            draw_set_color(c_yellow); // Highlight selected option
        } else {
            draw_set_color(c_white);
        }
        draw_text(room_width / 2 - 50, y_pos + (i * 30), pause_menu_options[i]);
    }
    
    // Draw instruction text
    draw_set_color(c_gray);
    draw_text(room_width / 2 - 50, y_pos + 100, "ENTER to select");
    draw_text(room_width / 2 - 50, y_pos + 130, "ESC to pause (already paused)");
}