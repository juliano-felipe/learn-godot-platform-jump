extends Node2D

export(Array) var platforms
export(Array) var special_platforms

onready var player = $Player
onready var score = $UI/Score

const MIN_INTERVAL = 100
const MAX_INTERVAL = 250
const INITIAL_PLATFORM_COUNT = 50
const SPECIAL_PLATFORM_CHANCE = 20

var current_min_interval
var current_max_interval
var last_spawn_height
var screen_size
var heighest_reached_position


func _ready():
	last_spawn_height = get_viewport().get_viewport().size.y
	current_min_interval = MIN_INTERVAL
	current_max_interval = MIN_INTERVAL
	screen_size = get_viewport().get_visible_rect().size.x
	_spawn_first_platforms()


func _process(delta):
	score.text = str(player.score)

func _spawn_first_platforms():
	for i in range(INITIAL_PLATFORM_COUNT):
		_spawn_platform()


func _spawn_platform():
	randomize()
	var index = rand_range(0, platforms.size())
	var new_platform
	if rand_range(0, 100) < SPECIAL_PLATFORM_CHANCE:
		index = rand_range(0, special_platforms.size())
		new_platform = special_platforms[index].instance()
	else:
		index = rand_range(0, platforms.size())
		new_platform = platforms[index].instance()
	add_child(new_platform)
	var spawn_x = rand_range(0 + new_platform.sprite_half_width,
			screen_size - new_platform.sprite_half_width)
	var spawn_position = Vector2(spawn_x, last_spawn_height)
	new_platform.position = spawn_position
	last_spawn_height -= rand_range(current_min_interval, current_max_interval)
	current_min_interval += 5
	current_max_interval += 7.5
	current_min_interval = clamp(current_min_interval, MIN_INTERVAL, MAX_INTERVAL * 0.75)
	current_max_interval = clamp(current_max_interval, MIN_INTERVAL, MAX_INTERVAL)

func _on_Player_just_jumped():
	for i in range(3):
		_spawn_platform()
