/// @description Initialize pause controller
can_pause = true;
paused = false;
pause_menu_option = 0; // 0 = Resume, 1 = Restart, 2 = Quit
pause_menu_options = ["Resume", "Restart", "Quit"];

// Visual settings
pause_overlay_alpha = 0.7;
pause_text_color = c_white;
pause_selected_color = c_yellow;