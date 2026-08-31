event_inherited()

pizzaboy_normal = function() {
	hsp = 0
	movespeed = 0
}

state_struct.normal = {state: states.normal, func: pizzaboy_normal} //disable its movement

sprs.move = sprite_index
sprs.stun = sprite_index
sprs.scared = sprite_index
sprs.dead = spr_carl_dead
sprs.turn = sprite_index