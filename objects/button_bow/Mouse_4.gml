// Left Pressed event for button_bow
if (object_exists(obj_character_preview) && obj_character_preview.active_layer == "leg") {
    with (obj_character_preview) {
        if (active_leg_sprite == spr_bow) {
            clear_leg_sprite();
        } else {
            set_leg_sprite(spr_bow);
        }
        recalculate_scale();
    }
}