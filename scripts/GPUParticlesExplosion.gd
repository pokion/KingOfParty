extends GPUParticles2D


func _ready():
	self.emitting = true;

func changeParticleColor(color):
	self.process_material.color = color;
	self.restart();
