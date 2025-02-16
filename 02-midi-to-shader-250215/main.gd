extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(inp):
	if inp is InputEventMIDI:
		print(inp)
		if inp.message == MIDI_MESSAGE_NOTE_ON:
			if inp.channel == 0: gate_on_1()
			if inp.channel == 1: gate_on_2()
			if inp.channel == 3: gate_on_3()
			
		if inp.message == MIDI_MESSAGE_NOTE_OFF:
			if inp.channel == 0: gate_off_1()
			if inp.channel == 1: gate_off_2()
			
		if inp.message == MIDI_MESSAGE_CONTROL_CHANGE:
			if inp.channel == 4 and inp.controller_number == 3: cv_1(inp.controller_value)
			if inp.controller_number == 1: cv_2(inp.controller_value)


# Gate 1
func gate_on_1():
	print("Gate 1")
	$CanvasLayer/ColorRect.material.set_shader_parameter("invert", 1)

func gate_off_1():
	print("Gate 1")
	$CanvasLayer/ColorRect.material.set_shader_parameter("invert", 0)

# Gate 2
func gate_on_2():
	print("Gate 2")
	$CanvasLayer/ColorRect.material.set_shader_parameter("flip", 1)

func gate_off_2():
	print("Gate 2")
	$CanvasLayer/ColorRect.material.set_shader_parameter("flip", 0)

# Gate 3
func gate_on_3():
	print("Gate 3")

func gate_off_3():
	print("Gate 3")

# Cv 1
func cv_1(val):
	print("Cv 1: ", normalize_cc(val))
	$CanvasLayer/ColorRect.material.set_shader_parameter("size", normalize_cc(val))

# Cv 2
func cv_2(val):
	print("Cv 2: ", normalize_cc(val))
	$CanvasLayer/ColorRect.material.set_shader_parameter("bend", normalize_cc(val))


func normalize_cc(cc_value: int) -> float:
	return cc_value / 127.0
