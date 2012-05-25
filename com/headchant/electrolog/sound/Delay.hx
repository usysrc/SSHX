package com.headchant.electrolog.sound;

import flash.Vector;

class Delay implements IFilter
{ 
    public var feedback:Float;

    public var mix:Float;
    public var length:Int;

    private var readPointer:Int;
    private var writePointer:Int;
    private var delayValue:Float;
    private var buffer:Vector<Float>;
    private var copy:Delay;

    public function new(_feedback:Float, _length:Int, _mix:Float) {
        feedback = _feedback;
        length = _length;
        mix = _mix;
        readPointer = 0;
        writePointer = 0;
		buffer = new Vector<Float>();
		clear();
    }
	
	private function clear() 
	{
		for (i in 0...length)
		{
			buffer[i] = 0;
		}
	}
    public function execute(input:Float):Float {
        readPointer = writePointer - length + 1;
        if (readPointer < 0) readPointer += length;
        delayValue = buffer[readPointer]; 
        buffer[writePointer] = input * (1 - feedback) + delayValue * feedback;
        if (++writePointer == length) writePointer = 0;
        return input* (1 - mix) + delayValue * mix;
    }
    public function duplicate():IFilter {
        var l:Int = length;
        
        copy = new Delay(feedback, l, mix);
        return copy;
    }
    public function setFeedback(_feedback:Float):Void {
        feedback = _feedback; 
        //if (copy != null) copy.feedback = _feedback;
    }
    
    public function setMix(_mix:Float):Void {
        mix = _mix;
        
    }
    public function setLength(_length:Int):Void {
        var newBuffer:Vector<Float> = new Vector<Float>(length, true);
        if (buffer != null) newBuffer.concat(buffer);
        buffer = newBuffer;
        writePointer = 0;
        length = _length;
    }
}