active_body_sprite = noone;
active_leg_sprite = noone;

// Get character's actual visible bounds
function get_sprite_visible_bottom(spr, scale) {
    // Return a default value based on sprite height
    // Since we can't easily check pixel transparency in GML, use a percentage
    var spr_height = sprite_get_height(spr);
    
    // Assume visible part is about 80% of the sprite height (adjust as needed)
    // This approximates the actual visible area ignoring transparent edges
    var visible_height = spr_height * 0.3;
    
    return visible_height * scale;
}

base_scale = 0.7; // Original scale
current_scale = base_scale;

// Auto-scale multipliers
auto_scale_multiplier = .5;        // Multiplier for overall scale when shrunk (1 = normal)
auto_position_x_multiplier = 0;   // Multiplier for X position offset when shrunk
auto_position_y_multiplier = 1.0;   // Multiplier for Y position offset when shrunk

active_layer = "character"; // Track which layer is active
var _shader = shd_replace_white;
planet_list = ds_list_create(); 
planet_spacing = 300; // Adjust this value to control spacing between planets

current_sprite = noone;
selected_sprite = noone;
is_locked = false;
replace_color = c_white; // Default color
use_shader = false;

display_x = 300;
display_y = 300;
image_scale = 0.7;

// ↓↓↓ ADD FUNCTIONS HERE ↓↓↓

function show_hover(_spr) {
    if (!is_locked) {
        current_sprite = _spr;
    }
}

function clear_hover(_spr) {
    if (!is_locked && current_sprite == _spr) {
        current_sprite = noone;
    }
}

function set_selected(_spr) {
    selected_sprite = _spr;
    current_sprite = _spr;
    is_locked = true;
}

// Set default preview
set_selected(spr_yvie);

// Button layer visibility
show_character_buttons = true;  // Start with character buttons visible
show_color_buttons = false;      // Start with color buttons hidden

// ADDED: New layer visibility variables
show_character_layer = true;
show_color_layer = false;
show_body_layer = false;    // NEW: Body layer visibility
show_leg_layer = false;     // NEW: Leg layer visibility
show_planet_layer = false;

// UPDATED: Now setting visibility for all five layers
layer_set_visible("char_buttons", show_character_layer);
layer_set_visible("color_buttons", show_color_layer);
layer_set_visible("body_buttons", show_body_layer);   // NEW: Body buttons layer
layer_set_visible("leg_buttons", show_leg_layer);     // NEW: Leg buttons layer
layer_set_visible("planet_buttons", show_planet_layer);

current_planet_sprite = noone;
planet_display_active = false;
current_planet_scale = 0.1; 

// Add this function to obj_character_preview
function toggle_planet_display(_planet_sprite) {
    if (!planet_display_active) {
        // Show the planet sprite
        current_planet_sprite = _planet_sprite;
        planet_display_active = true;
        show_debug_message("Showing planet: " + string(_planet_sprite));
    } else {
        // Hide the planet sprite
        current_planet_sprite = noone;
        planet_display_active = false;
        show_debug_message("Hiding planet");
    }
}

// Load planet list data
if (variable_global_exists("planet_list")) {
    planet_list = global.planet_list;
    planet_display_active = global.planet_display_active;
    planet_spacing = global.planet_spacing;
    current_planet_scale = 0.5; // Default scale
} else {
    planet_list = ds_list_create();
    planet_display_active = false;
    planet_spacing = 3;
}

function set_body_sprite(_spr) {
    active_body_sprite = _spr;
    show_debug_message("Body sprite set: " + string(_spr));
}

function set_leg_sprite(_spr) {
    active_leg_sprite = _spr;
    show_debug_message("Leg sprite set: " + string(_spr));
}

function clear_body_sprite() {
    active_body_sprite = noone;
    show_debug_message("Body sprite cleared");
}

function clear_leg_sprite() {
    active_leg_sprite = noone;
    show_debug_message("Leg sprite cleared");
}

// Body and leg sprite adjustments
body_sprite_x_offset = -200;
body_sprite_y_offset = -130;
body_sprite_scale = 1.35;

// Leg sprite adjustments
leg_sprite_x_offset = 150;           // X offset from character origin
leg_sprite_y_offset = -140;             // Extra Y offset (pixels)
leg_sprite_scale = 1;                // Scale multiplier
leg_sprite_y_multiplier = 0;         // Vertical adjustment (-1 to 1, 0 = bottom edge)

model_y_offset = -150;               // Global Y offset for entire model

// Model position offsets (for when scaled down)
model_x_offset = 0;                  // Base X offset when scaled
model_y_offset = -150;               // Base Y offset when scaled (already defined above, remove duplicate)

// Auto-position multipliers
auto_position_x_multiplier = 0;    // Multiplier for X offset (1 = normal)
auto_position_y_multiplier = 0;    // Multiplier for Y offset (1 = normal)

// Recalculate scale function - call this when planets or leg sprites change
function recalculate_scale() {
    var planet_count = ds_list_size(planet_list);
    
    if (planet_count == 0 && active_leg_sprite == noone) {
        planet_display_active = false;
        current_scale = base_scale;
    } else {
        if (planet_count > 0) {
            planet_display_active = true;
        }
        
        // Calculate total height of all elements
        var total_height = 0;
        
        // Add character height
        var char_height = sprite_get_height(current_sprite) * base_scale;
        total_height += char_height;
        
        // Add spacing between character and first planet (if planets exist)
        if (planet_count > 0) {
            total_height += 2;
        }
        
        // Add planet heights
        for (var i = 0; i < ds_list_size(planet_list); i++) {
            var planet_data = planet_list[| i];
            var planet_sprite = planet_data[0];
            var planet_base_scale = planet_data[1];
            var planet_height = get_sprite_visible_bottom(planet_sprite, planet_base_scale * base_scale);
            total_height += planet_height;
            
            // Add spacing between planets (except after last)
            if (i < ds_list_size(planet_list) - 1) {
                total_height += 120;
            }
        }
        
        // Add leg sprite height if active
        if (active_leg_sprite != noone) {
            var leg_height = sprite_get_height(active_leg_sprite) * leg_sprite_scale;
            total_height += leg_height + 0.5;
        }
        
        // Calculate scale to fit within available space
        var max_height = room_height - 100;  // Leave 100 pixels margin
        var new_scale = base_scale * (max_height / total_height);
        
        // Apply additional shrink from planet count
        if (planet_count > 0) {
            new_scale = new_scale * (0.85 - (planet_count * 0.075));
        }
        
        // Apply auto-scale multiplier (adjusts overall size)
        new_scale = new_scale * auto_scale_multiplier;
        
        // Set the scale
        current_scale = new_scale;
        
        // Ensure minimum scale
        if (current_scale < 0.4) current_scale = 0.4;
    }
}