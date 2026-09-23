/// @description Creates the level's 1920 × 1080 camera.
camera_data = {
    camera_id: -1,
    width: GCFG.camera.width,
    height: GCFG.camera.height,
    pan_speed: GCFG.camera.pan_speed
};

var _camera = camera_data;
var _view_x = clamp(x - _camera.width * 0.5, 0, max(0, room_width - _camera.width));
var _view_y = clamp(y - _camera.height * 0.5, 0, max(0, room_height - _camera.height));

_camera.camera_id = camera_create_view(
    _view_x, _view_y, _camera.width, _camera.height,
    0, noone, -1, -1, -1, -1
);

view_enabled = true;
view_set_visible(0, true);
view_set_camera(0, _camera.camera_id);
view_set_wport(0, _camera.width);
view_set_hport(0, _camera.height);