/// @description Bakes once, then draws the player sprite.
if (player_sprite == -1)
    player_sprite = sc_baking_sprite_create(player.radius, sc_player_visual_draw);

if (player_sprite != -1)
    draw_sprite_ext(player_sprite, 0, x, y, 1, 1, player.draw_angle, c_white, 1);