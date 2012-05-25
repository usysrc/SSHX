package com.headchant.electrolog.sound;

/**
 * @author Tilmann Hars
 * 
 * Bandlimited sawtooth oscillator. It is calculated via additive mixing of sine waves, a fourier series. 
 * The number of harmonics are at default constant of 15, which sounded pretty ok.
 */

class SawInstrument extends OscillatorInstrument
{
	public static inline var HARMONICS:Int = 15;
	public static function saw(input:Float):Float
	{
		var out:Float = 0.0;
		for (h in 1...HARMONICS)
		{
			out += (1/h)*Math.sin(input * h);
		}
		
		return out;
	}
	
	public function new(frequency:Float, amplitude:Float) 
	{
		super(frequency, amplitude, SawInstrument.saw);
	}
	
}