package com.headchant.electrolog.sound;

interface IFilter
{
    function execute(input:Float):Float;
    function duplicate():IFilter;
}