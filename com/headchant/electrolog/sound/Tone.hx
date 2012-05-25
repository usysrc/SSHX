package com.headchant.electrolog.sound;

/**
 * ...
 * @author Tilmann Hars
 */

class Tone 
{
	static public inline var C:Float = calculateFrequency(1);
	static public inline var CS:Float = calculateFrequency(2);
	static public inline var D:Float = calculateFrequency(3);
	static public inline var DS:Float = calculateFrequency(4);
	static public inline var E:Float = calculateFrequency(5);
	static public inline var F:Float = calculateFrequency(6);
	static public inline var FS:Float = calculateFrequency(7);
	static public inline var G:Float = calculateFrequency(8);
	static public inline var GS:Float =calculateFrequency(9);
	static public inline var A:Float = calculateFrequency(10);
	static public inline var AS:Float = calculateFrequency(11);
	static public inline var H:Float = calculateFrequency(12);
	
	static public inline var ONELINEOCTAVE:Int = 4;
	static public inline var CHAMBERTONE:Int = 440;
	static public inline var DEGREEOFCHAMBERTONE:Int = 10;
	
	private var frequency:Float;
	
	public function getFrequency():Float { return frequency;  }
	
	public function new(frequency:Float, octave) 
	{
		//this.frequency = calculateFrequency(degree);
		
		this.frequency = frequency * Math.pow(2, octave-ONELINEOCTAVE);

	}
	
	public static function calculateFrequency(degree):Float
	{
		degree -= DEGREEOFCHAMBERTONE;
		return CHAMBERTONE*Math.pow(2, degree * 1/12);
		
	}
	
}