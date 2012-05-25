package com.headchant.electrolog.sound;

/**
 * @author Tilmann Hars
 * 
 * Baseclass for all instruments, includes and manages frequency and amplitude.
 */

class Instrument 
{
	private var frequency:Float;
	private var amplitude:Float;
	private var filter:IFilter;
	
	/**
	 * Helper function to check if a Float is in a certain range
	 * @return Float from lower to upper
	 */ 
	public static function checkInBounds(value, lower, upper):Float
	{
		return Math.min(upper, Math.max(lower, value));
	}
	
	/**
	 * Helper function to check if a Float in range from -1 to 1
	 * @return Float from -1 to 1
	 */ 
	public static function checkUniPolar(value):Float
	{
		return checkInBounds(value, -1, 1);
	}
	
	/**
	 * Helper function to check if a Float in range from 0 to 1
	 * @return Float value from 0 to 1
	 */ 
	public static function checkBiPolar(value):Float
	{
		return checkInBounds(value, 0, 1);
	}
	
	/**
	 * @param frequency accepts any Float
	 * @param amplitude accepts any Float, but is cut to range from -1 to 1
	 * 
	 */ 
	public function new(frequency:Float, amplitude:Float) 
	{
		SoundEngine.getInstance().addInstrument(this);
		this.frequency = frequency;
		this.amplitude = checkBiPolar(amplitude);
	}
	
	public function setFrequency(frequency:Float)
	{
		this.frequency = frequency;
	}
	
	public function setAmplitude(amplitude) 
	{
		this.amplitude = Math.max(0, amplitude);
	}
	
	public function getAmplitude():Float
	{
		return amplitude;
	}
	
	public function addFilter(filter:IFilter) 
	{
		this.filter = filter;
	}
	
	private function applyFilter(input:Float):Float
	{
		if (filter == null)
			return input;
		return filter.execute(input);
	}
	
	public function getSample():Float
	{
		return 0.0;
	}
	
	public function getFrequency() 
	{
		return frequency;
	}
}