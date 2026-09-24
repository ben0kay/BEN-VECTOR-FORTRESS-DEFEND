/// @description Initializes player movement, stats, and visual size.
function sc_player_init(_player)
{
    _player.player = {
        radius: 22,
        draw_angle: 0,
        stats: {
            base: { move_speed: 5 },
            modifiers: {
                level: { move_speed: 0 },
                upgrades: { move_speed: 0 },
                temporary: { move_speed: 0 }
            },
            final: {},
            dirty: true
        }
    };

    sc_player_stats_recalculate(_player);
}

/// @description Recalculates final player stats after a modifier changes.
function sc_player_stats_recalculate(_player)
{
    var _stats = _player.player.stats;
    if (!_stats.dirty) return;

    _stats.final.move_speed = max(0,
        _stats.base.move_speed
        + _stats.modifiers.level.move_speed
        + _stats.modifiers.upgrades.move_speed
        + _stats.modifiers.temporary.move_speed
    );

    _stats.dirty = false;
}

/// @description Checks whether the player's circular body overlaps a solid obstacle.
function sc_player_solid_at(_player, _x, _y)
{
    var _radius = _player.player.radius;

    for (var _i = 0; _i < instance_number(o_solid); ++_i)
    {
        var _solid = instance_find(o_solid, _i);
        var _distance = _radius + _solid.solid_radius;
        var _dx = _x - _solid.x;
        var _dy = _y - _solid.y;

        if (_dx * _dx + _dy * _dy < _distance * _distance)
            return true;
    }

    return false;
}

/// @description Moves with arrow keys and slides along circular obstacles.
function sc_player_step(_player)
{
    if (!GAMEPLAY_ACTIVE) return;

    var _data = _player.player;
    if (_data.stats.dirty) sc_player_stats_recalculate(_player);

    var _input_x = keyboard_check(vk_right) - keyboard_check(vk_left);
    var _input_y = keyboard_check(vk_down) - keyboard_check(vk_up);

    if (_input_x == 0 && _input_y == 0) return;

    var _length = point_distance(0, 0, _input_x, _input_y);
    _input_x /= _length;
    _input_y /= _length;

    _data.draw_angle = point_direction(0, 0, _input_x, _input_y);

    var _speed = _data.stats.final.move_speed;
    var _radius = _data.radius;
    var _next_x = clamp(_player.x + _input_x * _speed, _radius, room_width - _radius);

    if (!sc_player_solid_at(_player, _next_x, _player.y))
        _player.x = _next_x;

    var _next_y = clamp(_player.y + _input_y * _speed, _radius, room_height - _radius);

    if (!sc_player_solid_at(_player, _player.x, _next_y))
        _player.y = _next_y;
}

/// @description Draws the player's vector body onto the baking surface.
function sc_player_visual_draw(_x, _y, _radius)
{
    draw_set_colour(make_colour_rgb(20, 45, 55));
    draw_circle(_x, _y, _radius, false);

    draw_set_colour(c_aqua);
    draw_circle(_x, _y, _radius, true);

    draw_set_colour(c_white);
    draw_circle(_x + _radius * 0.4, _y, _radius * 0.22, false);
}