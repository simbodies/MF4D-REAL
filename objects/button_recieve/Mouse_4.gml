// Check if body layer is visible
with(obj_character_preview) {
    if (show_body_layer) {
        // If this body sprite is already active, remove it
        if (active_body_sprite == spr_recieve) { // Replace with actual sprite
            clear_body_sprite();
        } else {
            // Otherwise set it (this will replace any existing body sprite)
            set_body_sprite(spr_recieve); // Replace with actual sprite
        }
    }
}