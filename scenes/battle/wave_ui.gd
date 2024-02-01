class_name WaveUi
extends Node

@onready var wave_label : Label = $WaveProgressBar/WaveLabel
@onready var wave_progress_bar : ProgressBar = $WaveProgressBar

func increment_wave_progress(wave_number : int) -> void:
	wave_progress_bar.value = wave_number

func _on_wave_progress_bar_value_changed(_value: float) -> void:
	wave_label.text = "Wave %s/%s" % [wave_progress_bar.value, wave_progress_bar.max_value]
