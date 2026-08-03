// Left Pressed event for button_bully
if (object_exists(obj_character_preview) && obj_character_preview.active_layer == "character") {
    show_debug_message("CHARACTER BUTTON CLICKED: " + object_get_name(object_index));
    with (obj_character_preview) {
        set_selected(spr_bully);
    }
    mouse_clear(mb_left);
}