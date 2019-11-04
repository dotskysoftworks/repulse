extends Area

func on_body_entered(body):
	if body.is_in_group("Player") and self.visible:
		body.gun_enabled = true
		self.queue_free()