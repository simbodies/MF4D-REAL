// Initialize planet variables
planet_list = ds_list_create();
planet_display_active = false;
planet_spacing = 3;
character_bottom_offset = 20;
current_planet_scale = 0.5;

// Movement and appearance
movespeed = 30;
replace_color = c_white;
use_shader = false;

// Initialize body and leg sprite variables
active_body_sprite = noone;
active_leg_sprite = noone;
body_sprite_x_offset = 0;
body_sprite_y_offset = 0;
body_sprite_scale = 1;
leg_sprite_x_offset = 0;
leg_sprite_scale = 1;

// Load scale from saved data (MUST come before planet calculations)
if (variable_global_exists("character_scale")) {
    image_scale = global.character_scale;
} else {
    image_scale = 0.7;
}

// Load position from saved data
if (variable_global_exists("display_x")) {
    x = global.display_x;
} else {
    x = 250;
}

if (variable_global_exists("display_y")) {
    y = global.display_y;
} else {
    y = 300;
}

// Apply saved character data
if (variable_global_exists("selected_sprite")) {
    sprite_index = global.selected_sprite;
} else {
    sprite_index = spr_yvie;
}

// Apply saved color data
if (variable_global_exists("selected_color")) {
    replace_color = global.selected_color;
}

if (variable_global_exists("use_shader")) {
    use_shader = global.use_shader;
}

// Load body and leg sprite data
if (variable_global_exists("active_body_sprite")) {
    active_body_sprite = global.active_body_sprite;
}

if (variable_global_exists("active_leg_sprite")) {
    active_leg_sprite = global.active_leg_sprite;
}

// Load body adjustments
if (variable_global_exists("body_sprite_x_offset")) {
    body_sprite_x_offset = global.body_sprite_x_offset;
}

if (variable_global_exists("body_sprite_y_offset")) {
    body_sprite_y_offset = global.body_sprite_y_offset;
}

if (variable_global_exists("body_sprite_scale")) {
    body_sprite_scale = global.body_sprite_scale;
}

// Load leg adjustments (only x offset and scale)
if (variable_global_exists("leg_sprite_x_offset")) {
    leg_sprite_x_offset = global.leg_sprite_x_offset;
}

if (variable_global_exists("leg_sprite_scale")) {
    leg_sprite_scale = global.leg_sprite_scale;
}

// Load planet list data if it exists
if (variable_global_exists("planet_list") && ds_exists(global.planet_list, ds_type_list)) {
    // Clear existing list
    ds_list_clear(planet_list);
    
    // Copy planet list data
    for (var i = 0; i < ds_list_size(global.planet_list); i++) {
        var planet_data = global.planet_list[| i];
        var copy_data = [planet_data[0], planet_data[1]];
        ds_list_add(planet_list, copy_data);
    }
    planet_display_active = global.planet_display_active;
    planet_spacing = global.planet_spacing;
    
    // Debug
    show_debug_message("PLANETS LOADED: Count=" + string(ds_list_size(planet_list)) + 
                      ", Active=" + string(planet_display_active) +
                      ", Spacing=" + string(planet_spacing));
}

show_debug_message("SPAWN: Sprite=" + string(sprite_index) + 
                  ", Color=" + string(replace_color) + 
                  ", Shader=" + string(use_shader) +
                  ", Scale=" + string(image_scale) +
                  ", X=" + string(x) +
                  ", Y=" + string(y) +
                  ", Body=" + string(active_body_sprite) +
                  ", Leg=" + string(active_leg_sprite));
				  
				  // Body and leg sprite multipliers (adjust these to fine-tune size)
body_sprite_multiplier = 0.15;
leg_sprite_multiplier = 0.15;

body_sprite_x_offset = 0;
body_sprite_y_offset = 105;
leg_sprite_x_offset = -100;