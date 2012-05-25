package com.headchant.electrolog.sound;
import com.headchant.electrolog.sound.SineInstrument;
import flash.Lib;

/**
 * ...
 * @author Tilmann Hars
 */

class Player 
{
	private var instruments:Array<Instrument>;
	//private var beep:Instrument;
	private var play:Bool;
	private var playing:Array<Bool>;
	
	public static inline var MAXINSTRUMENTS:Int = 8;
	
	public function new() 
	{
		instruments = new Array<Instrument>();
		var delay:Delay = new Delay(0.4, SoundEngine.SAMPLERATE*2, 0.8);
		playing = new Array<Bool>();
		for (i in 0...MAXINSTRUMENTS)
		{
			var beep:SineInstrument = new SineInstrument(440.0, 0.0);
			beep.addFilter(delay);
			play = false;
			addInstrument(beep);
			playing[i] = false;
		}
		
		SoundEngine.getInstance().addCallback(update);
	}
	
	private function update() 
	{
		
		for (i in 0...MAXINSTRUMENTS) 
		{
			play = playing[i]; 
			
			var beep:Instrument = instruments[i];
			if (play) {
				var amp:Float = beep.getAmplitude();
				if (amp < 0.2)
					beep.setAmplitude(amp + (0.001));
				else
					playing[i] = !play;
			}
			else 
			{
				var amp:Float = beep.getAmplitude();
				if (amp > 0)
					beep.setAmplitude(amp - (0.000008));
				else
					beep.setAmplitude(0);
			}
		}
		
		

	}
	
	public function playTone(tone:Tone):Void
	{
		for (i in 0...MAXINSTRUMENTS) 
		{
			if (!playing[i] && instruments[i].getAmplitude()==0)
			{
				instruments[i].setFrequency(tone.getFrequency());
				playing[i] = true;
				break;
			}
		}
		
		
	}
	
	public static function randomPentatonicTone():Tone
	{
		var pentatonicScale = [
			Tone.C,
			Tone.DS,
			Tone.F,
			Tone.G,
			Tone.AS]; 
		return new Tone(pentatonicScale[Math.floor(Math.random()*pentatonicScale.length)],rndFromTo(3, 6));
	}
	
	public static function rndFromTo(from, to):Int
	{
		return Math.floor(from + Math.random() * (to - from));
	}
	
	private function addInstrument(instrument:Instrument) 
	{
		instruments.push(instrument);
	}
	
}