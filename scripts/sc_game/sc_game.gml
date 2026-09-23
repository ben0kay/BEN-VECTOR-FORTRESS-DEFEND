/// @description Initializes the game before a level starts.
function sc_game_init()
{
    global.GameState = GameState.BOOT;
    global.LevelState = LevelState.NONE;

    global.game = {
        initialized: false,
        tick: 0
    };

    global.profile = undefined;
    global.level = undefined;

    if (!sc_config_init())
    {
        show_debug_message("GAME INIT FAILED - CONFIG");
        return false;
    }

    global.game.initialized = true;
    global.GameState = GameState.PLAYING;
    return true;
}

function sc_controller_main_create(){
	if (instance_number(o_controller_main) > 1)
{
    instance_destroy();
    exit;
}

persistent = true;
display_set_gui_size(1920, 1080);

if (!sc_game_init())
{
    show_debug_message("GAME INITIALIZATION FAILED");
    game_end();
}
}

function sc_controller_main_step(){
	if (global.game.initialized && global.LevelState == LevelState.PLAYING)
    global.game.tick++;
}

function sc_controller_main_cleanup(){}

function sc_controller_level_create(){
	/// @description Owns the current level and creates its camera.
if (!global.game.initialized)
{
    show_debug_message("LEVEL INIT FAILED - MAIN CONTROLLER MISSING");
    instance_destroy();
    exit;
}

global.level = {
    controller: id,
    camera: noone
};

var _camera = instance_create_layer(room_width * 0.5, room_height * 0.5, "Instances", o_camera);
global.level.camera = _camera;
global.LevelState = LevelState.PLAYING;
}

function sc_controller_level_cleanup(){
	/// @description Clears state owned by this level.
if (is_struct(global.level) && global.level.controller == id)
{
    global.LevelState = LevelState.NONE;
    global.level = undefined;
}
}

