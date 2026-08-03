function Script2(){/// @function hex_to_rgb(hex_string)
/// @param hex_string Color in format "#RRGGBB"
/// @returns GML color value
var hex = argument0;
// Remove # if present
if (string_char_at(hex, 1) == "#") {
    hex = string_delete(hex, 1, 1);
}
// Convert to RGB values
var r = hex_to_dec(string_copy(hex, 1, 2));
var g = hex_to_dec(string_copy(hex, 3, 2));
var b = hex_to_dec(string_copy(hex, 5, 2));
return make_color_rgb(r, g, b);

}