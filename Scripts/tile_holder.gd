extends Node2D
class_name TileHolder

@export var x_dim: int = 10;
@export var y_dim: int = 10;
@export var tile_size: int = 32;
const TILE = preload("res://Scenes/tile.tscn");
var tile_instance: Tile = null;

func _spawn_tiles() -> void:
	for x_tile in range(x_dim):
		for y_tile in range(y_dim):
			tile_instance = TILE.instantiate();
			tile_instance.tile_size = tile_size;
			tile_instance.position = tile_size * Vector2(
				x_tile,
				y_tile
			);
			self.add_child(tile_instance)

func _ready() -> void:
	_spawn_tiles();
