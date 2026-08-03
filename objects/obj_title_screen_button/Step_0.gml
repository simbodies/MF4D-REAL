// Step Event

if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom))
{
    image_alpha = 0.8; // highlight
}
else
{
    image_alpha = 1;
}