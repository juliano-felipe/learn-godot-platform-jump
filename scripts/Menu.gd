extends Node

onready var highscore = $Highscore

func _ready():
	var highscore_value = str($"/root/PlayerData".load_highscore())
	highscore.bbcode_text = "[center]"+ highscore_value +"[/center]"

func _on_Button_pressed():
	$"/root/LevelManager".change_scene("Game")
