// Save planet list to global variables
global.planet_list = ds_list_create();

// Copy planet list data
for (var i = 0; i < ds_list_size(planet_list); i++) {
    var planet_data = planet_list[| i];
    var copy_data = [planet_data[0], planet_data[1]];
    ds_list_add(global.planet_list, copy_data);
}

global.planet_display_active = planet_display_active;
global.planet_spacing = planet_spacing;