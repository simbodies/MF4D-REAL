// Find or create preview
var _preview = instance_find(obj_character_preview, 0);
if (_preview == noone) {
    _preview = instance_create_layer(0, 0, "Controllers", obj_character_preview);
}
_preview.preview_sprite = character_sprite;
show_debug_message("Showing Yvie preview");