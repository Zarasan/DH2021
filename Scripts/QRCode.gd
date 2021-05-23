extends Panel


signal clicked_qrcode()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var qr_code = []


var ButType
var Type
var Name
var StartDate
var DateOffset = 0
var EndDate = {}

var held = false
var offset
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rect_position = Vector2(-600, -600)
	EndDate.day = StartDate.day + Type.Delay
	EndDate.year = StartDate.year + DateOffset
	rect_size = Vector2(300, 450)
	pass

func _physics_process(delta):
	if held:
		timer+=delta
		rect_position = get_viewport().get_mouse_position() + offset

func _on_Button_button_down():
	offset = rect_position - get_viewport().get_mouse_position()
	held = true
	pass # Replace with function body.


func _on_Button_button_up():
	if timer < 0.1:
		emit_signal('clicked_qrcode', self)
	held = false
	timer = 0
	pass # Replace with function body.

func _on_Button_mouse_entered():
	$"Background/Rows/Panel".visible = true
	pass # Replace with function body.


func _on_Button_mouse_exited():
	$"Background/Rows/Panel".visible = false
	pass # Replace with function body.
