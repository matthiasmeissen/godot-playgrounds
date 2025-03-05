extends Node2D

@onready var _animated_sprite = $CanvasLayer/Control/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Advance"):
		advanceSprite()


# Alternative approach without using the input map
# func _input(event: InputEvent) -> void:
# 	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
# 		advanceSprite()


func advanceSprite():
	print("Gate 3")
	
	var frameCount = _animated_sprite.sprite_frames.get_frame_count("default") - 1
	var currentFrame = _animated_sprite.get_frame()
	
	if currentFrame < frameCount:
		currentFrame += 1
	else:
		currentFrame = 0
		
	_animated_sprite.frame = currentFrame  # Then assign it once
