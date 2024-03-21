extends Sprite2D
class_name NPCBase

@export var dialogue : String

@onready var interact_icon : Object = $InteractIcon
@onready var can_interact : bool = false

func _ready():
	interact_icon.visible = false

func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	if(area.name == "InteractionArea"):
		print("I can interact!")
		interact_icon.visible = true
		can_interact = true

func _on_area_2d_area_exited(area):
	if(area.name == "InteractionArea"):
		print("I cannot interact :()")
		interact_icon.visible = false
		can_interact = false
