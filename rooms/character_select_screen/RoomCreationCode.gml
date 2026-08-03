layer_set_visible("char_buttons", true);
layer_set_visible("color_buttons", false);

if (object_exists(obj_character_preview)) {
    obj_character_preview.show_character_layer = true;
    obj_character_preview.show_color_layer = false;
}
