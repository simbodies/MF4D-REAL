 function push_visualiser_state(_event_name, _data_struct) {
    if (!is_undefined(global.visualise_session)) {
        var _payload = json_stringify({
            event: _event_name,
            data: _data_struct
        });
        global.visualise_session.websocket.send_data_string(_payload);
    }
}