/// @description Pans the camera with WASD and keeps it inside the room.
if (!GAMEPLAY_ACTIVE) exit;

var _camera = camera_data;
var _camera_id = _camera.camera_id;
var _move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var _view_x = camera_get_view_x(_camera_id) + _move_x * _camera.pan_speed;
var _view_y = camera_get_view_y(_camera_id) + _move_y * _camera.pan_speed;

_view_x = clamp(_view_x, 0, max(0, room_width - _camera.width));
_view_y = clamp(_view_y, 0, max(0, room_height - _camera.height));

camera_set_view_pos(_camera_id, round(_view_x), round(_view_y));