/// @description Bakes once, then draws this obstacle.
if (solid_sprite == -1)
{
    solid_sprite = sc_baking_sprite_create(solid_radius, function(_x, _y, _radius)
    {
        draw_set_colour(make_colour_rgb(45, 55, 65));
        draw_circle(_x, _y, _radius, false);
        draw_set_colour(c_aqua);
        draw_circle(_x, _y, _radius, true);
    });
}

if (solid_sprite != -1)
    draw_sprite(solid_sprite, 0, x, y);