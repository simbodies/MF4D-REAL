var _spawn = instance_create_layer(400, 300, "Instances", obj_spawn);

// Apply last selected character
if (variable_global_exists("selected_character_sprite")) {
    _spawn.sprite_index = global.selected_character_sprite;
}