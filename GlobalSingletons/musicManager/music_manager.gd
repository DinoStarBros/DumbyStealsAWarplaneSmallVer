extends Node

@onready var audio_players : Dictionary = {
	"title": %Title,
	"level1": %Level1,
	
}

func play_song(song: String, starting_point: float = 0.0) -> void: ## Stops the current song playing and plays the selected song
	if not is_song_playing(song):
		stop_all_songs()
		audio_players[song].play(starting_point)

func stop_all_songs() -> void: ## Stops all songs
	for song in audio_players.values():
		if song is AudioStreamPlayer:
			
			if song.playing:
				song.stop()

func is_song_playing(song: String) -> bool:
	return audio_players[song].playing
