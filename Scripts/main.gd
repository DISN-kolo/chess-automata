extends Control
class_name MainScene

const SELECTOR_MENU = preload("uid://ctbl75g3ldp34");
const TILE_HOLDER = preload("uid://v56s8xgx8iui")

var tholder_instance: TileHolder = null;

func _on_asked_to_resize(x: int, y: int) -> void:
	if (tholder_instance != null):
		tholder_instance.kill_tiles();
		tholder_instance.x_dim = x;
		tholder_instance.y_dim = y;
		tholder_instance.spawn_tiles();

func spawn_menu() -> void:
	var smi = SELECTOR_MENU.instantiate();
	smi.field_resizing.connect(_on_asked_to_resize);
	add_child(smi);

func _ready() -> void:
	tholder_instance = TILE_HOLDER.instantiate();
	add_child(tholder_instance);
	spawn_menu();
