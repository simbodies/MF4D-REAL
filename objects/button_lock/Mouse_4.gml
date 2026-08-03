// Check if body layer is visible
with(obj_character_preview) {
    if (show_body_layer) {
        // If this body sprite is already active, remove it
        if (active_body_sprite == spr_lock) { // Make sure spr_touch exists in your assets
            clear_body_sprite();
        } else {
            // Otherwise set it
            set_body_sprite(spr_lock); // Make sure spr_touch exists in your assets
        }
    }
}