extends Control
class_name ApplyConfirmMenu

signal apply_parameters;


func _on_no_button_pressed() -> void:
	self.queue_free();

func _on_yep_button_pressed() -> void:
	apply_parameters.emit();
	self.queue_free();
