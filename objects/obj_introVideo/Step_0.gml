if (!showText && keyboard_check_pressed(vk_anykey))
{
    showText = true;
    alarm[0] = 120;
}
else if (showText && input_check_pressed(INPUTS.ui_accept))
{
    event_user(0);
    video_close();
    alarm[0] = -1;
}
