extends Control
class_name TileHolder

var dim: Vector2i = Vector2i(5, 5);
@export var tile_size: int = 32;
const TILE = preload("res://Scenes/tile.tscn");
const NO_SEPARATION_BOX = preload("uid://rkaklmsnkqja");

var tile_instance: Tile = null;

var tile_refs: Array[Tile] = [];

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

func _on_tile_pressed(pos: Vector2i) -> void:
	print("got a press on ", pos);

func kill_tiles() -> void:
	for child in %CenterHolder.get_children():
		child.queue_free();
	tile_refs = [];

func _ready() -> void:
	dim = Presaved.dim;
	spawn_tiles();
