extends RichTextLabel
var timer
signal payUp
var previous = 0
@export var pay_ammount = 10

func _ready():
	timer = Timer.new()
	timer.timeout.connect(_on_timer_timeout) 
	timer.set_wait_time(1)
	add_child(timer) 
	timer.start()
	self.text = str(timer.get_time_left());
func _process(delta: float) -> void:
	if(self.is_ready()):
		var currentTime = floor(timer.get_time_left())
		if(currentTime != previous):
			self.text = str(int(currentTime));
			previous = currentTime
func _on_timer_timeout():
	timer.set_wait_time(1)
	payUp.emit();
	pay_ammount = int(floor(pay_ammount*1.25))
	pass
