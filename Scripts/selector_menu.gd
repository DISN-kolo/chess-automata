extends Control
class_name SelectorMenu

signal field_resizing(x: int, y: int);

var dim: Vector2i = Presaved.dim;
const CLOSE_CONFIRM_MENU = preload("uid://dr3fphjl6dhio");
const APPLY_CONFIRM_MENU = preload("uid://ckjoals5qg47f");


func _ready() -> void:
	%XSlider.value = Presaved.dim.x;
	%YSlider.value = Presaved.dim.y;

func _process(delta: float) -> void:
	dim.x = int(%XSlider.value);
	dim.y = int(%YSlider.value);
	%XVal.text = "%2d" % [dim.x];
	%YVal.text = "%2d" % [dim.y];
	Presaved.dim = dim;

func apply_field_parameters() -> void:
	field_resizing.emit(dim.x, dim.y);
	self.queue_free();

func _on_x_prompt_button_pressed() -> void:
	var ccm_instance: CloseConfirmMenu = CLOSE_CONFIRM_MENU.instantiate();
	ccm_instance.apply_and_close_menu.connect(_on_apply_and_close);
	ccm_instance.just_close_menu.connect(_on_just_close);
	self.add_child(ccm_instance);

func _on_just_close() -> void:
	self.queue_free();

func _on_apply_and_close() -> void:
	apply_field_parameters()
	self.queue_free()


func _on_gen_prompt_button_pressed() -> void:
	var acm_instance: ApplyConfirmMenu = APPLY_CONFIRM_MENU.instantiate();
	acm_instance.apply_parameters.connect(apply_field_parameters);
	self.add_child(acm_instance);
