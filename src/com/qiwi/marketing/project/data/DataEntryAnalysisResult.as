/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.data {
public class DataEntryAnalysisResult {

	public var value:String;
	public var count:int;
	public var percent:Number;

	public function DataEntryAnalysisResult(value:String, count:int, percent:Number) {
		this.value = value;
		this.count = count;
		this.percent = percent;
	}

	public function get percentString():String {
		return (percent * 100).toFixed(2) + "%";
	}
}
}
