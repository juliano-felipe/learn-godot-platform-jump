extends Node

const SCENE_PATH = "res://scenes/"


func change_scene(scene):
	call_deferred("_deffered_change_scene", scene)


func _deffered_change_scene(scene):
	var path = SCENE_PATH + scene + ".tscn"
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() -1)
	current_scene.free()
	var scene_resource = ResourceLoader.load(path)
	var new_scene = scene_resource.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	
