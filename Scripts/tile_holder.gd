extends Control
class_name TileHolder

var dim: Vector2i = Vector2i(5, 5);
@export var tile_size: int = 32;
const TILE = preload("res://Scenes/tile.tscn");
const NO_SEPARATION_BOX = preload("uid://rkaklmsnkqja");

signal tileholder_interacted_at(pos: Vector2i);

var tile_instance: Tile = null;
var tile_refs: Array[Tile] = [];
var current_map: Array[Globals.ChessPiece] = [];
var desire_map: Array[Dictionary] = [];

var calculating: bool = true;

var time_passed: float = 0;
var tick_len: float = 0.01*100;

func spawn_tiles() -> void:
	var vboxInstance = VBoxContainer.new();
	vboxInstance.theme = NO_SEPARATION_BOX;
	%CenterHolder.add_child(vboxInstance);
	for y_tile in range(dim.y):
		var hboxInstance = HBoxContainer.new();
		hboxInstance.theme = NO_SEPARATION_BOX;
		vboxInstance.add_child(hboxInstance);
		for x_tile in range(dim.x):
			tile_instance = TILE.instantiate();
			tile_instance.tile_size = tile_size;
			tile_instance.position = tile_size * Vector2(
				x_tile,
				y_tile
			);
			tile_refs.append(tile_instance);
			tile_instance.pos = Vector2i(
				x_tile,
				y_tile
			);
			tile_instance.tile_pressed.connect(_on_tile_pressed);
			hboxInstance.add_child(tile_instance);
			desire_map.append({});
			if (x_tile == 7 and y_tile == 7):
				current_map.append(Globals.ChessPiece.KING);
			elif (x_tile == 0 and y_tile == 7):
				current_map.append(Globals.ChessPiece.KNIGHT);
			else:
				current_map.append(Globals.ChessPiece.EMPTY);
			tile_refs[x_tile + y_tile*dim.x].change_colors(
				Globals.colorscheme[current_map[x_tile + y_tile*dim.x]],
			);

func _on_tile_pressed(pos: Vector2i) -> void:
	tileholder_interacted_at.emit(pos);

func kill_tiles() -> void:
	for child in %CenterHolder.get_children():
		child.queue_free();
	tile_refs = [];
	desire_map = [];
	current_map = [];

func _ready() -> void:
	dim = Presaved.dim;
	spawn_tiles();

func _process(delta: float) -> void:
	if (!calculating):
		time_passed = 0;
		return ;
	else:
		time_passed += delta;
		while (time_passed >= tick_len):
			time_passed -= tick_len;
			calculate_step();

func _add_xy_to_i(i: int, addxy: Vector2i) -> int:
	var ourxy: Vector2i = Vector2i(i % dim.x, i / dim.x);
	var resxy: Vector2i = ourxy + addxy;
	if (resxy.x < 0 or resxy.x >= dim.x
			or resxy.y < 0 or resxy.y >= dim.y):
		return -1;
	var res: int = resxy.x + resxy.y * dim.x;
	return (res);

func calculate_step() -> void:
	# oh boy, behavior calculation!
	for i: int in range(len(current_map)):
		var piece = current_map[i];
		if (piece == Globals.ChessPiece.EMPTY):
			continue ;
		for movdir in Globals.movesets[piece]:
			var next_i: int = _add_xy_to_i(i, movdir);
			if (next_i == -1):
				continue ;
			desire_map[next_i][piece] = true;
	# based on per-tile-desires, now actually 'apply em'
	for i: int in range(len(desire_map)):
		if (len(desire_map[i]) == 1):
			current_map[i] = desire_map[i].keys()[0];
			tile_refs[i].change_colors(
				Globals.colorscheme[current_map[i]],
			);
		desire_map[i] = {};
