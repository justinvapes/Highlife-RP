// testing to see if valid audio

// var request = new XMLHttpRequest();
// request.open("GET", "/path/to/audio/file/", true);
// request.responseType = "blob";    
// request.onload = function() {
//   if (this.status == 200) {
//     var audio = new Audio(URL.createObjectURL(this.response));
//     audio.load();
//     audio.play();
//   }
// }
// request.send();

class AudioEngine {
	constructor() {
		this.AudioContext = new AudioContext();
		
		this.listener = this.AudioContext.listener;

		this.audioSources = [];

		this.debugState = false;

		this.cameraPosition = {
			pos: { x: 0.0, y: 0.0, z: 0.0 },
			rot: { x: 0.0, y: 0.0, z: 0.0 },
			instance_reference: null
		};
	};

	debug = (message) => {
		if (this.debugState) console.log(message);
	};

	updateActiveSounds = (data) => {
		// Check if any sounds have ended and remove them
		for (var thisSoundID in this.audioSources) {
			if (this.audioSources[thisSoundID].initData.max_dist) {
				if (this.audioSources[thisSoundID].initData.entity != null) {
					for (var thisSoundPosition in data.soundPositions) {
						if (data.soundPositions[thisSoundPosition] !== null && data.soundPositions[thisSoundPosition].id == thisSoundID) {
							this.audioSources[thisSoundID].initData.pos = data.soundPositions[thisSoundPosition].pos;

							this.audioSources[thisSoundID].panner.setPosition(this.audioSources[thisSoundID].initData.pos.x, this.audioSources[thisSoundID].initData.pos.y, this.audioSources[thisSoundID].initData.pos.z);

							break
						}
					}
				}

				this.debug('Sound ' + thisSoundID + ' with reference: ' + this.audioSources[thisSoundID].initData.instance_reference + ', cam ref is: ' + this.cameraPosition.instance_reference);

				if (this.audioSources[thisSoundID].initData.instance_reference == this.cameraPosition.instance_reference) {
					this.audioSources[thisSoundID].audio.volume = this.audioSources[thisSoundID].initData.volume;

					this.debug('Setting sound ' + thisSoundID + ' volume = ' + this.audioSources[thisSoundID].initData.volume);
				}
				else {
					this.debug('Setting sound ' + thisSoundID + ' volume = 0.0');

					this.audioSources[thisSoundID].audio.volume = 0.0;
				}
			}

			// remove the sound if it's dead
			if (this.audioSources[thisSoundID].loaded && this.audioSources[thisSoundID].audio.ended && !this.audioSources[thisSoundID].initData.loop) {
				this.debug('Sound ' + thisSoundID + ' ended, deleting');

				this.stopAudioSource({id: thisSoundID});
			}
		}
	};

	setListenerData = (data) => {
		this.cameraPosition = {
			pos: data.pos,
			rot: data.rot,
			instance_reference: data.instance_reference
		};

		this.debugState = data.debug;

		this.listener.setPosition(this.cameraPosition.pos.x, this.cameraPosition.pos.y, this.cameraPosition.pos.z);
		this.listener.setOrientation(this.cameraPosition.rot.x, this.cameraPosition.rot.y, this.cameraPosition.rot.z, 0, 0, 1);

		this.updateActiveSounds(data);
	};

	startAudioSource = (data) => {
		const thisAudioSource = new Audio();

		const thisAudioPanner = this.AudioContext.createPanner()
		const thisAudioNode = this.AudioContext.createMediaElementSource(thisAudioSource);

		thisAudioSource.crossorigin = "anonymous";

		thisAudioSource.src = data.url;
		thisAudioSource.volume = data.volume;
		thisAudioSource.loop = data.loop || false;
		thisAudioSource.currentTime = data.start_time || 0;

		thisAudioPanner.distanceModel = "linear";
		thisAudioPanner.maxDistance = data.max_dist;
		thisAudioPanner.refDistance = 1.0;
		thisAudioPanner.rolloffFactor = 1.0;
		thisAudioPanner.coneInnerAngle = 360;
		thisAudioPanner.coneOuterAngle = 0;
		thisAudioPanner.coneOuterGain = 0;
		thisAudioPanner.setPosition(data.pos.x, data.pos.y, data.pos.z);

		// sound to panner
		thisAudioNode.connect(thisAudioPanner);
		// panner to output
		thisAudioPanner.connect(this.AudioContext.destination);

		this.audioSources[data.id] = {
			loaded: false,
			initData: data,
			audio: thisAudioSource,
			panner: thisAudioPanner
		};

		this.audioSources[data.id].audio.play().catch(e => {});

		this.audioSources[data.id].loaded = true;
	};

	tweakFactors = (refDistance, rollOff) => {
		for (var thisSource in this.audioSources) {
			this.audioSources[thisSource].panner.refDistance = refDistance;

			this.audioSources[thisSource].panner.rolloffFactor = rollOff;
		}
	};

	stopAudioSource = (data) => {
		var thisAudioSource = this.audioSources[data.id];

		if (thisAudioSource) {
			thisAudioSource.audio.pause();

			thisAudioSource.panner.disconnect(this.AudioContext.destination);

			$.post('http://highlife/SpatialSoundStop', data.id);

			delete this.audioSources[data.id];
		}
	};
}