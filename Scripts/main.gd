extends Control
class_name MainScene

const SELECTOR_MENU = preload("uid://ctbl75g3ldp34");
const TILE_HOLDER = preload("uid://v56s8xgx8iui")

var tholder_instance: TileHolder = null;

var placement_on: bool = false;
var currently_selected_placer: Globals.ChessPiece = Globals.ChessPiece.EMPTY;

func _on_asked_to_resize(x: int, y: int) -> void:
	if (tholder_instance != null):
		tholder_instance.kill_tiles();
		tholder_instance.dim = Vector2i(x, y);
		tholder_instance.spawn_tiles();

func spawn_gen_menu() -> void:
	var smi = SELECTOR_MENU.instantiate();
	smi.field_resizing.connect(_on_asked_to_resize);
	smi.tree_exiting.connect(_on_smi_exiting);
	add_child(smi);

func _ready() -> void:
	tholder_instance = TILE_HOLDER.instantiate();
	tholder_instance.tileholder_interacted_at.connect(_on_pressed_tile);
	add_child(tholder_instance);
	#spawn_gen_menu();


func _on_gen_menu_button_pressed() -> void:
	%GenMenuButton.visible = false;
	spawn_gen_menu();

func _on_smi_exiting() -> void:
	%GenMenuButton.visible = true;

func _on_pressed_tile(pos: Vector2i) -> void:
	pass
