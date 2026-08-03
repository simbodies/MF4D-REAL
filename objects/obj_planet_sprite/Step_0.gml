// Step event - follow the character preview
if (instance_exists(obj_character_preview)) {
    x = obj_character_preview.x;
    y = obj_character_preview.y;
} else {
    // If character preview doesn't exist, destroy this sprite
    show_debug_message("Character preview missing, destroying planet sprite");
    instance_destroy();
}