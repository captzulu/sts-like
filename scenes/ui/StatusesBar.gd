class_name StatusesBar
extends HFlowContainer

@onready var status_template : StatusUi = %Status

func add_status(status : Status) -> void:
	var new_status : StatusUi = status_template.duplicate()
	add_child(new_status)
	new_status.init(status)
	status.ui_element = new_status
	
func refresh_bar(statuses_dict : Dictionary) -> void:
	for child in get_children():
		if not child == status_template:
			remove_child(child)
			child.queue_free()

	for status_name in statuses_dict:
		self.add_status(statuses_dict[status_name])
