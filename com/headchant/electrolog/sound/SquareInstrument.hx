package com.headchant.electrolog.sound;

/**
 * @author Tilmann Hars
 * 
 * Provides calculation for square oscillation(http://en.wikipedia.org/wiki/Square_Wave). It calculates the square through a fourier series to minimize aliasing. 
 * (ugly while ... but faster than for in haXe?)
 */

class SquareInstrument extends OscillatorInstrument
{
	public static inline var HARMONICS:Int = 15;
	
	public static inline function square(input:Float):Float 
	{
		var out:Float = 0.0;
		
		var i:Int = 0;
		var h:Int = 0;
		while(i<HARMONICS)
		{
			i++;
			h = 2 * i - 1;
			out += (1/h)*Math.sin(input * h);
		}
		
		return out;
	}
	
	public function new(frequency, amplitude) 
	{
		super(frequency, amplitude, SquareInstrument.square);
	}
	

	
}