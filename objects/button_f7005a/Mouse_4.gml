// Left Pressed event for button_1f1f1f
if (object_exists(obj_character_preview) && obj_character_preview.active_layer == "color") {
    show_debug_message("COLOR BUTTON CLICKED: " + object_get_name(object_index));
    with (obj_character_preview) {
        replace_color = other.button_color;
        use_shader = true;
    }
    mouse_clear(mb_left);
}