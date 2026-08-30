event_inherited()

johncar_normal = function() {
	hsp = 0
	movespeed = 0
}

state_struct.normal = {state: states.normal, func: johncar_normal} //disable its movement

sprs.move = spr_johncar
sprs.stun = spr_johncar
sprs.scared = spr_johncar
sprs.dead = spr_johncar_dead
sprs.turn = spr_johncar

do_turn = false

if !escape
	create_hurtbox()
