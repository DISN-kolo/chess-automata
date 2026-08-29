extends Control

func _process(delta: float) -> void:
	%XVal.text = "%2d" % [%XSlider.value];
	%YVal.text = "%2d" % [%YSlider.value];
