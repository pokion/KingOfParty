extends CPUParticles2D

func changeParticleColor(colorInput):
	self.color = colorInput;
	$Timer.start()

func timerEnd():
	self.restart();
