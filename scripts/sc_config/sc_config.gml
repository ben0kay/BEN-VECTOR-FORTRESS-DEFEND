/// @description Creates game-wide tuning values.
function sc_config_init()
{
    global.config = {
        camera: {
            width: 1920,
            height: 1080,
            pan_speed: 18
        }
    };

    return true;
}