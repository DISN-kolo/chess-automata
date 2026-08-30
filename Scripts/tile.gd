extends Control
class_name Tile;

signal tile_pressed(pos: Vector2i);

var tile_size: int = 32;
var border_thick: int = 4;
var def_bg: Color = Globals.default_bg_tile_color;
var def_fg: Color = Globals.colorscheme[Globals.ChessPiece.EMPTY];

var pos: Vector2i = Vector2i(0, 0);

func _size_the_tile(ts: float, bt: float) -> void:
	self.size = Vector2(ts, ts);
	%Fill.size -= Vector2(bt, bt);
	%Fill.position += Vector2(
		bt/2,
		bt/2
	);
	custom_minimum_size = self.size;

func change_colors(fg: Color = def_fg, bg: Color = def_bg) -> void:
	%Back.modulate = bg;
	%Fill.modulate = fg;

func _ready() -> void:
	_size_the_tile(tile_size, border_thick);
	change_colors(def_fg, def_bg);

func _on_clickable_pressed() -> void:
	tile_pressed.emit(pos);
