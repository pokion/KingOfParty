extends CPUParticles2D

func changeParticleColor(color):
	self.color = color;
	$Timer.start()

func timerEnd():
	self.restart();
