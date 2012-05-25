package com.headchant.electrolog.sound;

/**
 * @author Tilmann Hars
 * 
 * Provides a non-aliased sawtooth oscillator.
 */

class LFSawInstrument 
{
	
	public static function saw(input:Float):Float
	{
		return 1-input;
	}
	
	public function new(frequency:Float, amplitude:Float) 
	{
		super(frequency, amplitude, SawInstrument.saw);
	}
	
}