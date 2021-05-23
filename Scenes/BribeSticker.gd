extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var held = false
var offset

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	if held:
		rect_position = get_viewport().get_mouse_position() + offset

func _on_Button_button_down():
	offset = rect_position - get_viewport().get_mouse_position()
	held = true
	pass # Replace with function body.


func _on_Button_button_up():
	held = false
	pass # Replace with function body.
