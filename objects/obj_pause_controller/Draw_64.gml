/// @description Draw pause menu
// Only draw the pause overlay if the game is paused
if (paused) {
    // Center text alignment
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // Dark transparent rectangle covering the screen
    draw_set_alpha(pause_overlay_alpha);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    // Reset alpha so text is fully visible
    draw_set_alpha(1);
    
    // Calculate center position
    var center_x = display_get_gui_width() / 2;
    var start_y = display_get_gui_height() / 2 - 50;
    
    // Draw menu options
    for (var i = 0; i < array_length(pause_menu_options); i++) {
        // Set color based on selection
        if (i == pause_menu_option) {
            draw_set_color(pause_selected_color); // Highlight selected option
        } else {
            draw_set_color(pause_text_color); // Normal option
        }
        
        // Draw the option text
        draw_text(center_x, start_y + (i * 40), pause_menu_options[i]);
    }
    
    // Draw instruction text
    draw_set_color(c_gray);
    draw_set_alpha(0.7);
    draw_text(center_x, start_y + 140, "SPACE to select");
    draw_text(center_x, start_y + 170, "ESC to pause");
    draw_set_alpha(1);
    
    // Reset alignment to default
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

