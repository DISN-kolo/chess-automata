extends Control
class_name Tile;

signal tile_pressed(pos: Vector2i);

var tile_size: int = 32;
var border_thick: int = 4;
var def_bg: Color = Color(0.0, 0.0, 0.0, 1.0);
var def_fg: Color = Color(0.851, 0.851, 0.851, 1.0);

var pos: Vector2i = Vector2i(0, 0);

func _size_the_tile(ts: float, bt: float) -> void:
	self.size = Vector2(ts, ts);
	%Fill.size -= Vector2(bt, bt);
	%Fill.position += Vector2(
		bt/2,
		bt/2
	);
	custom_minimum_size = self.size;

func _change_colors(bg: Color, fg: Color) -> void:
	%Back.modulate = bg;
	%Fill.modulate = fg;

func _ready() -> void:
	_size_the_tile(tile_size, border_thick);
	_change_colors(def_bg, def_fg);

func _on_clickable_pressed() -> void:
	tile_pressed.emit(pos);
