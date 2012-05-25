package com.headchant.electrolog.sound;

import com.headchant.electrolog.sound.Delay;
import flash.utils.ByteArray;

/**
 * @author Tilmann Hars
 * 
 * Provides a basic sine wave oscillator(http://en.wikipedia.org/wiki/Sine_wave).
 */

class SineInstrument extends OscillatorInstrument
{
	
	
	public function new(frequency, amplitude) 
	{
		super(frequency, amplitude, Math.sin);
	}
	
	
	

}