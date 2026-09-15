// In a script, e.g., scr_visualise_bridge.gml
function VisualiseBridge(): HttpServerWebsocketSessionBase() constructor {
    static on_data_buffer = function(_buffer, _is_string) {
        // Decode incoming data from the React visualiser
        var _text = buffer_read(_buffer, buffer_text);
        var _json = json_parse(_text);
        
        // React to specific actions from the visualiser
        switch (_json.action) {
            case "trigger_effect":
                // Call your in-game function here
                global.trigger_special_effect();
                break;
            case "set_flag":
                global.some_game_flag = _json.value;
                break;
        }
    }
    
    static on_close = function(_close_code, _close_reason) {
        // Cleanup when the visualiser disconnects
        show_debug_message("Visualiser disconnected");
    }
}