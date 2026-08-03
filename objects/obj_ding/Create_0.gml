
if (!variable_global_exists("movespeed")) {
    movespeed = 45;
if (!variable_global_exists("character_scale")) {
    character_scale = .05;
}
image_xscale = character_scale;
image_yscale = character_scale;
}
/// @description Initialize character
image_blend = c_white; // Start with white