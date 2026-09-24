/// @description Follows the player while keeping the view inside the room.
if (!GAMEPLAY_ACTIVE) exit;

if (player == noone)
{
    player = instance_find(o_player, 0);
    if (player == noone) exit;
}

var _camera = camera_data;
var _view_x = clamp(
    player.x - _camera.width * 0.5,
    0,
    max(0, room_width - _camera.width)
);

var _view_y = clamp(
    player.y - _camera.height * 0.5,
    0,
    max(0, room_height - _camera.height)
);

camera_set_view_pos(_camera.camera_id, round(_view_x), round(_view_y));