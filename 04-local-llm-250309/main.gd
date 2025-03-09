extends Node2D

# This code requires ollama and local running model
# First start ollama and the model you want to use 
# Example: ollama run llama3.2
# Adjust the model part in the payload variable to be the same

func _ready() -> void:
	$HTTPRequest.request_completed.connect(_on_request_completed)
	
	var payload = {
		"model": "llama3.2",
		"prompt": "You are an expert in Godot Game Emgine. 
		Your aim is to introduce one interesting feature as short and precise as possible. 
		Only show the feature and no response or reasoning around. 
		Add a little explanation with a maximum of two sentences.",
		"temperature": 0.7,
		"max_tokens": 400
	}
	
	$HTTPRequest.request(
		"http://localhost:11434/v1/completions", 
		["Content-Type: application/json"], 
		HTTPClient.METHOD_POST, 
		JSON.stringify(payload)
	)

func _process(delta: float) -> void:
	pass
	

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		var text_output = json["choices"][0]["text"]
		print(text_output)
		$CanvasLayer/MarginContainer/RichTextLabel.text = text_output
	else:
		print("HTTP request failed with response code: ", response_code)
