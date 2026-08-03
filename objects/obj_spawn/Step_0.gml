// Step event for obj_spawn

// Reset movement each frame
hspeed = 0;
vspeed = 0;

// Left
if (keyboard_check(vk_left))
{
    hspeed = -movespeed;
}

// Right
if (keyboard_check(vk_right))
{
    hspeed = movespeed;
}

// Up
if (keyboard_check(vk_up))
{
    vspeed = -movespeed;
}

// Down
if (keyboard_check(vk_down))
{
    vspeed = movespeed;
}


move_wrap(true, true, sprite_width/.35);