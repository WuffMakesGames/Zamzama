function ZamAudio(zam) constructor {
	self.parent = zam
	
	enum ZAM_SAMPLE {
		rain, bongo, clarinet, noise,
		organ, tuba, doo, bell,
		flute, snare, piano, strings,
		timpani, trumpet, voice, bottle,
	}
	
	// Samples ===================================
	function new_sample(index, soundid, looping=false, play_full=false) {
		samples[index] = [soundid, looping, play_full]
	}
	
	samples = []
	new_sample(ZAM_SAMPLE.rain, _SFX__Rain___zzzRain, true)
	new_sample(ZAM_SAMPLE.bottle, BlownBottle___bottleblow, true)
	new_sample(ZAM_SAMPLE.bongo, Bongo___bongo, true)
	new_sample(ZAM_SAMPLE.clarinet, Clarinet___clarinet, true)
	new_sample(ZAM_SAMPLE.noise, Noise___noise, true)
	new_sample(ZAM_SAMPLE.organ, Organ___Organ, true)
	new_sample(ZAM_SAMPLE.tuba, Tuba___tuba, true)
	new_sample(ZAM_SAMPLE.doo, VoiceDooo___voice, true)
	new_sample(ZAM_SAMPLE.bell, Z3_Bell___bell, true)
	new_sample(ZAM_SAMPLE.flute, Z3_Flute___flute, true)
	new_sample(ZAM_SAMPLE.snare, Z3_Percussion___snare, true)
	new_sample(ZAM_SAMPLE.piano, Z3_Piano___piano, true)
	new_sample(ZAM_SAMPLE.strings, Z3_Strings___strings, true)
	new_sample(ZAM_SAMPLE.timpani, Z3_Timpani___timpani, true)
	new_sample(ZAM_SAMPLE.trumpet, Z3_Trumpet___trumpet, true)
	new_sample(ZAM_SAMPLE.voice, Z3_Voice___voice, true)
	
	
	// Variables =================================
	channel_sounds = [-1, -1, -1, -1]
	channels = [
		time_source_create(time_source_global, 0, time_source_units_seconds, audio_stop_sound),
		time_source_create(time_source_global, 0, time_source_units_seconds, audio_stop_sound),
		time_source_create(time_source_global, 0, time_source_units_seconds, audio_stop_sound),
		time_source_create(time_source_global, 0, time_source_units_seconds, audio_stop_sound),
	]
	
	// Methods ===================================
	
	/// @desc Starts playing a note
	function start_note(soundid, pitch, volume=1.0, duration_ms=100) {
		var sound_index = audio_play_sound(soundid, 400, true, volume, 0, pitch)
		var channel = 3
		
		// Find empty channel
		for (var i = 0; i < 4; i++) {
			if (!audio_is_playing(channel_sounds[i])) {
				channel = i
				break
			}
		}
		
		// Override channel state
		if (audio_is_playing(channel_sounds[channel])) {
			show_debug_message($"Forced channel {channel} to stop")
			stop_channel(channel)
		}
		
		// Setup timesource
		channel_sounds[channel] = sound_index
		time_source_reconfigure(channels[channel], duration_ms/1000, time_source_units_seconds, stop_channel, [channel], 1, time_source_expire_after)
		time_source_start(channels[channel])
			show_debug_message($"Playing sfx in channel {channel}")
	}
	
	function stop_channel(channel) {
		audio_stop_sound(channel_sounds[channel])
		if (time_source_get_state(channels[channel]) != time_source_state_stopped) time_source_stop(channels[channel])
		show_debug_message($"Stopped sfx in channel {channel}")
	}

	/// @desc Plays a note based on some values
	function note(instrument, semitones, volume=1.0, duration_ms=100, base_freq=440) {
		var freq = base_freq * power(2, semitones / 12)
		var pitch = freq/440
		
		var soundid = samples[instrument][0]
		var sound_length = audio_sound_length(soundid)*1000
		
		// Looping/Full play
		if (samples[instrument][2]) duration_ms = sound_length-100
		else if (!samples[instrument][1]) duration_ms = min(duration_ms, sound_length)
		
		// Play sound
		start_note(soundid, pitch, volume, duration_ms)
	}
	
}