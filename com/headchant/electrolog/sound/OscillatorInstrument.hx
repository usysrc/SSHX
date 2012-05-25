package com.headchant.electrolog.sound;

import flash.Vector;
/**
 * @author Tilmann Hars
 * 
 * Baseclass for wavetable generated instruments. At creation the wavetable is filled with sample from callback function.
 * 
 */

class OscillatorInstrument extends Instrument
{

	private var phase:Int;
	private var sampleRate:Float;
	private var mult:Float;
	private var wavetable:Vector<Float>;
	
	inline static var TAU : Float = 2 * Math.PI;
	
	public function new(frequency, amplitude, oscillationFunction) 
	{
		
		super(frequency, amplitude);
			
		phase = 0;
		sampleRate = 44100;
		
		wavetable = new Vector<Float>();
		
		var length = 8192;
		var phase = 2*Math.PI/length;
		for (i in 0...length) 
		{
			wavetable[i] = oscillationFunction(i*phase);
		}
		
		mult = wavetable.length/sampleRate;
	}
	
	
	override public function getSample():Float 
	{
		phase += cast frequency*mult;
		
		if (phase >= cast wavetable.length)
			phase = 0;
		var s:Float = wavetable[phase] * amplitude;
		return applyFilter(s);
	}
}