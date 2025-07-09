extends Node2D
signal end_game
signal round_start
signal setup_end
var timer
var ready_time := 60
var game_time := 200
var pb
var running_game
@export var syncvalue := 0
func _ready():
	running_game = false
	timer = $GameTimer
	pb = $bar
	pb.set_max(ready_time)
	pb.value = ready_time
	#print(pb.value)
	timer.wait_time = pb.value
	timer.start()
func _process(delta):
	#print(timer.time_left)
	syncvalue = timer.time_left
	pb.value = syncvalue
	if(syncvalue <= .01):
		if(running_game == false):
			round_start.emit()
			timer.wait_time = ready_time
			pb.set_max(game_time)
			pb.value = game_time
			timer.wait_time = game_time
			setup_end.emit()
			timer.start()
			running_game = true
		else:
			end_game.emit()
func reset():
	running_game = false
	timer = $GameTimer
	pb = $bar
	pb.set_max(ready_time)
	pb.value = ready_time
	#print(pb.value)
	timer.wait_time = pb.value
	timer.start()
