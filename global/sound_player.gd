extends Node

signal sound_finished

func play (audio : AudioStream, single : bool = false, loop : bool = false) -> void:
	if not audio:
		return
	
	if single:
		stop()
		
	for player in get_children():
		player = player as AudioStreamPlayer
		if player.finished.is_connected(play):
			player.finished.disconnect(play)

		if not player.playing:
			if loop:
				player.finished.connect(self.play.bind(audio, single, loop))
			if not player.finished.is_connected(sound_finished.emit):
				player.finished.connect(sound_finished.emit)
			player.stream = audio
			player.play()
			break
			
func stop() -> void:
	for player in get_children():
		player = player as AudioStreamPlayer
		player.stop()
