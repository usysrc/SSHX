package com.headchant.electrolog.sound;

import flash.events.SampleDataEvent;
import flash.media.Sound;
import flash.utils.ByteArray;


/**
 * @author Tilmann Hars
 * 
 * 
 * Provides the core of the audio processing. It keeps track of all instruments and mixes them together.
 * It also initializes and adds the SampleDataEvent listener.
 * Singleton - access the instance via SoundEngine.instance
 */

class SoundEngine 
{
	// AS3 is _ALWAYS_ 44100 Hz Samplingrate
	static public inline var SAMPLERATE:UInt = 44100;
	
	// Should be from 2048 to 8192
	static public inline var BUFFERLENGTH:Int = 2048;
	
	// Singleton instance
	private static var instance : SoundEngine;
	
	// Sound provides the audiobuffer access
	private var sound : Sound;
	
	// Registry of instruments
	private var instruments :  Array<Instrument>;
	
	// Callback for other functions
	private var updateEnvelopes : Dynamic;
	
	
	public function new() 
	{
		instance = this;
		instruments = new Array<Instrument>();
		sound = new Sound();
		sound.addEventListener(SampleDataEvent.SAMPLE_DATA, process);
		updateEnvelopes = function() {}
		sound.play();
	}
	
	/**
	 * SoundEngine Singleton Factory method.
	 */
	public static function getInstance():SoundEngine
	{
		if ( instance == null ) instance = new SoundEngine();
		return instance;
	}
	
	public function addInstrument(instrument:Instrument) 
	{
		instruments.push(instrument);
	}
	
	public function addCallback(callbackFunction) 
	{
		updateEnvelopes = callbackFunction;
	}
	
	private function process(event:SampleDataEvent):Void
	{
		
		var sample:Float = 0.0;
		for (i in 0...BUFFERLENGTH) 
		{
			sample = 0.0;
			var add: Float = 1 / instruments.length;
			for (instrument in instruments) 
			{
				sample += add*instrument.getSample();
			}
			try 
			{
				event.data.writeFloat(sample);
				event.data.writeFloat(sample);
			}
			catch ( e:Dynamic )
			{
				trace(e);
			}
			updateEnvelopes();
			
		}
	
		
	}
	

}