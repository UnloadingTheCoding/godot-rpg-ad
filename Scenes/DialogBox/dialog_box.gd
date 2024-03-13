extends CanvasLayer


@onready var name_box = $NameBox
@onready var dialog_box = $MarginContainer/Panel/MarginContainer/dialog_box
@onready var name_label = $NameBox/MarginContainer/name_label


var dialog_lines: PackedStringArray
var dbox_is_active: bool = false
var dbox_is_visible: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	name_box.hide()
	visible = !dbox_is_visible
	SignalManager.dialog_lines.connect(on_lines_received)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	next_line()


func next_line() -> void:
	if dbox_is_active and Input.is_action_just_pressed("action_button"):
		if dialog_lines.size() <= 0:
			visible = !dbox_is_visible
			dbox_is_active = false
			get_tree().paused = false
			name_box.hide()
			SignalManager.is_dialog_complete.emit()
			dialog_lines.clear()
		else:
			check_name()
			dialog_box.text = dialog_lines[0]
			dialog_lines.remove_at(0)

	
func on_lines_received(lines) -> void:
	dialog_lines = lines.duplicate()
	visible = dbox_is_visible
	dbox_is_active = true

	get_tree().paused = true
	check_name()
	dialog_box.text = dialog_lines[0]
	dialog_lines.remove_at(0)

func check_name() -> void:
	if dialog_lines[0].contains("name_"):
		name_label.text = dialog_lines[0].erase(0,5)
		name_box.show()		
		dialog_lines.remove_at(0)
