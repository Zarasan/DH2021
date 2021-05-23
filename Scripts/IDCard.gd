extends Panel


var texture = [
	"res://avataaars (1).png",
	"res://avataaars (2).png",
	"res://avataaars (3).png",
	"res://avataaars (5).png"
]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Name
var BirthDate

var held = false
var offset
# Called when the node enters the scene tree for the first time.
func _ready():
	var image = ImageTexture
	rect_position = Vector2(-600, -600)
	rect_size = Vector2(450, 300)
	$"Label".text = Name
	$TextureRect.texture = load(texture[randi()%texture.size()])
	pass # Replace with function body.


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
