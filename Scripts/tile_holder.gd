extends Control
class_name TileHolder

@export var x_dim: int = 10;
@export var y_dim: int = 10;
@export var tile_size: int = 32;
const TILE = preload("res://Scenes/tile.tscn");
const NO_SEPARATION_BOX = preload("uid://rkaklmsnkqja")

var tile_instance: Tile = null;

func spawn_tiles() -> void:
	var vboxInstance = VBoxContainer.new();
	vboxInstance.theme = NO_SEPARATION_BOX;
	%CenterHolder.add_child(vboxInstance);
	for y_tile in range(y_dim):
		var hboxInstance = HBoxContainer.new();
		hboxInstance.theme = NO_SEPARATION_BOX;
		vboxInstance.add_child(hboxInstance);
		for x_tile in range(x_dim):
			tile_instance = TILE.instantiate();
			tile_instance.tile_size = tile_size;
			tile_instance.position = tile_size * Vector2(
				x_tile,
				y_tile
			);
			hboxInstance.add_child(tile_instance)

func kill_tiles() -> void:
	for child in %CenterHolder.get_children():
		child.queue_free();

func _ready() -> void:
	spawn_tiles();
