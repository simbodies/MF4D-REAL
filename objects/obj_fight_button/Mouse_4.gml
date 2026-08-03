// Left Pressed event for obj_fight_button
if (object_exists(obj_character_preview)) {
    // Store the selected character sprite
    global.selected_sprite = obj_character_preview.selected_sprite;
    
    // Store the selected color and shader state
    global.selected_color = obj_character_preview.replace_color;
    global.use_shader = obj_character_preview.use_shader;
    
    // Store body and leg sprite data
    global.active_body_sprite = obj_character_preview.active_body_sprite;
    global.active_leg_sprite = obj_character_preview.active_leg_sprite;
    
    // Store body adjustments
    global.body_sprite_x_offset = obj_character_preview.body_sprite_x_offset;
    global.body_sprite_y_offset = obj_character_preview.body_sprite_y_offset;
    global.body_sprite_scale = obj_character_preview.body_sprite_scale;
    
    // Store leg adjustments (only x offset and scale, y is automatic)
    global.leg_sprite_x_offset = obj_character_preview.leg_sprite_x_offset;
    global.leg_sprite_scale = obj_character_preview.leg_sprite_scale;
    
    // Debug to confirm
    show_debug_message("FIGHT: Sprite=" + string(global.selected_sprite) + 
                      ", Color=" + string(global.selected_color) + 
                      ", Shader=" + string(global.use_shader) +
                      ", Body=" + string(global.active_body_sprite) +
                      ", Leg=" + string(global.active_leg_sprite));
}

// Go to fighting screen
room_goto(fighting_screen_test);