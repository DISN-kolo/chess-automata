extends Control
class_name CloseConfirmMenu

signal apply_and_close_menu;
signal just_close_menu;


func _on_no_button_pressed() -> void:
	self.queue_free();

func _on_yes_apply_button_pressed() -> void:
	apply_and_close_menu.emit();

func _on_yep_button_pressed() -> void:
	just_close_menu.emit();
