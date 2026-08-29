extends Node2D
class_name Tile;

var tile_size: int = 32;
var border_thick: int = 4;
var def_bg: Color = Color(0, 0, 0, 1);
var def_fg: Color = Color(0.9, 0.9, 0.9, 1);

func _size_the_tile(ts: float, bt: float) -> void:
	%Back.texture.width = ts;
	%Back.texture.height = ts;
	%Fill.texture.width = ts - bt;
	%Fill.texture.height = ts - bt;

func _change_colors(bg: Color, fg: Color) -> void:
	%Back.modulate = bg;
	%Fill.modulate = fg;

func _ready() -> void:
	_size_the_tile(tile_size, border_thick);
	_change_colors(def_bg, def_fg);
