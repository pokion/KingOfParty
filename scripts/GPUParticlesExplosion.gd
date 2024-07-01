extends CPUParticles2D

func _ready():
	self.restart();

func changeParticleColor(color):
	self.color = color;
	self.restart();
