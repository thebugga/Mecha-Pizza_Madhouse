// movement
x += (hsp * image_xscale);
y += (vsp * image_yscale);
vsp += grav;

// rotate
image_angle += choose(5, 10, 20);

// change the depth of animation
switch (layer_type)
{
	case 1:
	    depth -= 2;
		break;
	case 2:
	    depth = 0;
		break;
	case 3:
	    depth += 2;
		break;
}

