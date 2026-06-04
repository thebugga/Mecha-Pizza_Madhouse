make_clothes_inst = function(_name, _desc, _pal_ix, _pattern = noone) constructor
{
	name = _name
	description = _desc
	pal_ix = _pal_ix
	pattern = _pattern
}

clothes_arr = [	
	new make_clothes_inst("Classic Cook",		"The one and only.",											0),
	new make_clothes_inst("Unfunny Cook",		"Ha.",															1),	
	new make_clothes_inst("Money Green",		"Green, like money!",											2),	
	new make_clothes_inst("Money Green",		"Green, like money!",											3),	
]

clothes_selected = 1

switch obj_player.pal_select
{
	case 0:
	case 1:
	case 2: 
	case 13:
	case 14: 
			 clothes_selected = 0  break;
	case 3:	 clothes_selected = 1 break;
	case 4:	 clothes_selected = 2 break;
	case 5:	 clothes_selected = 3 break;
	case 6:	 clothes_selected = 4 break;
	case 7:	 clothes_selected = 5 break;
	case 8:	 clothes_selected = 6 break;
	case 9:	 clothes_selected = 7 break;
	case 10: clothes_selected = 8 break;
	case 11: clothes_selected = 9 break;
	case 15: clothes_selected = 10 break;
	case 12: 
		switch obj_player.pattern_spr
		{
			case pat_funny: clothes_selected = 11 break;
			case pat_itchy: clothes_selected = 12 break;
			case pat_pizza: clothes_selected = 13 break;
			case pat_stripes: clothes_selected = 14 break;
			case pat_goldemanne: clothes_selected = 15 break;
			case pat_bones: clothes_selected = 16 break;
			case pat_pp: clothes_selected = 17 break;
			case pat_war: clothes_selected = 18 break;
			case pat_john: clothes_selected = 19 break;
			case pat_candy: clothes_selected = 20 break;
			case pat_bloodstained: clothes_selected = 21 break;
			case pat_autumn: clothes_selected = 22 break;
			case pat_pumpkin: clothes_selected = 23 break;
			case pat_fur: clothes_selected = 24 break;
			case pat_eyes: clothes_selected = 25 break;
		}
		break;
}
//hopefully theres a better way to map these

alph = 0


