extends Node

signal timerEmpty;

func _on_seconds_timer_timeout():
	self.value -= 1;
	if self.value == 0:
		timerEmpty.emit();
	else:
		$Timer.start();
