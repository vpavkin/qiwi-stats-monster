/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios {
public class FlowEntryData {

	public var entry:String;
	public var entryLabel:String;
	public var entryName:String;
	public var data:String;
	public var enters:uint;
	public var payments:int;

	public var averageTime:Number;
	public var longestTime:int;
	public var shortestTime:int;
	public var timeCount:int = 0;

	public function FlowEntryData(entry:String, entryLabel:String, entryName:String, data:String, averageTime:Number = 0, shortestTime:int = int.MAX_VALUE, longestTime:int = 0, enters:uint = 0, payments:uint = 0) {
		this.entry = entry;
		this.entryLabel = entryLabel;
		this.entryName = entryName;
		this.data = data;
		this.enters = enters;
		this.payments = payments;

		this.averageTime = averageTime;
		this.longestTime = longestTime;
		this.shortestTime = shortestTime;
	}

	public function toCSVString(totalEnters:uint = -1):String {
		return [
			entry,
			entryName.replace(/\n/g, " "),
			enters,
			(totalEnters == -1) ? "" : (enters / totalEnters).toString().replace(".", ","),
			payments,
			(totalEnters == -1) ? "" : (payments / totalEnters).toString().replace(".", ",")].join("\t");
	}

	public static function CSVHeader():String {
		return ["Код", "Описание", "Входов", "% дошедших", "Платежей", "% оплативших"].join("\t");
	}

	public function toClipboardText(totalEnters:uint = -1):String {
		return [
			entryName.replace(/\n/g, " "),
				"Вошли:" + enters + " (" + ((totalEnters == -1) ? "" : (((enters / totalEnters) * 100).toPrecision(3) + "%")) + ")" ,
				"Оплатили:" + payments + " (" + ((totalEnters == -1) ? "" : (((payments / totalEnters) * 100).toPrecision(3) + "%")) + ")",
				"Среднее время:" + averageTime.toFixed(1) + " сек."].join("\n");

	}
}
}
