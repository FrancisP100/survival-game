extends Label

func _process(delta):
	self.text = "Wave: "+ str(Global.wave)
