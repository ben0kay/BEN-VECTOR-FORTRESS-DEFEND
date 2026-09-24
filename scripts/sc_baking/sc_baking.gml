/// @description Creates a sprite from a primitive drawing callback.
function sc_baking_sprite_create(_radius, _draw_script)
{
    var _size = ceil(_radius * 2 + 8);
    var _centre = _size * 0.5;
    var _surface = surface_create(_size, _size);

    if (!surface_exists(_surface)) return -1;

    surface_set_target(_surface);
    draw_clear_alpha(c_black, 0);
    draw_set_alpha(1);
    draw_set_colour(c_white);

    _draw_script(_centre, _centre, _radius);

    draw_set_colour(c_white);
    draw_set_alpha(1);
    surface_reset_target();

    var _sprite = sprite_create_from_surface(
        _surface, 0, 0, _size, _size,
        false, false, _centre, _centre
    );

    surface_free(_surface);
    return _sprite;
}