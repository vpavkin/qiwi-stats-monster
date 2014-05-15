/**
 * Created by Vladimir on 20.04.2014.
 */
package com.qiwi.marketing.project.visit {
public class DayOfVisits {

	public var date:Date;
	public var visits:Vector.<Visit>;
	public var isLoaded:Boolean = false;

	public var paysCount:int;
	public var conversion:Number;
	public var conversionDisplay:String = "unknown";

	public function DayOfVisits(date:Date, visits:Vector.<Visit> = null) {
		this.date = date;
		this.visits = visits ? visits : new Vector.<Visit>();
	}

	public function addVisit(v:Visit):void {
		this.isLoaded = true;
		this.visits.push(v);
	}

	public function countGeneralStats():void {
		paysCount = 0;
		var vlength:int = visits.length;
		for (var i:int = 0; i < vlength; i++) {
			var v:Visit = visits[i];
			if (v.visitorPayed())
				paysCount++;
		}
		conversion = paysCount / vlength;
		conversionDisplay = (conversion * 100).toFixed(2) + "%";
	}

	public function setVisits(visits:Vector.<Visit>):void {
		this.visits = visits;
		countGeneralStats();
	}
}
}
