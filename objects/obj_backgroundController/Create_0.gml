backGroundSurface = noone;

parallaxLayer_new = function(_mult, _index, _scrollSpeed = [0, 0], _moveFunc = -4, _drawFunc = -4) constructor 
{
    parallaxSpeed = is_array(_mult) ? _mult : array_create(2, _mult); // arrays are much more convenient imo
    image_index = _index;
    scrollSpeed = _scrollSpeed;
    static moveFunc = _moveFunc;
    static drawFunc = _drawFunc;
}

layers = 
[
    new parallaxLayer_new(0, 0),
    new parallaxLayer_new(0, 1),
    new parallaxLayer_new([0.001, 0], 3, [-0.04, 0]),
    new parallaxLayer_new(0, 2),
]