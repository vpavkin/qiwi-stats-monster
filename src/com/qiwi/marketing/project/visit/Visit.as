/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit {
import com.qiwi.marketing.project.ProjectVersion;
import com.qiwi.marketing.project.visit.path.Path;

public class Visit {

	public var txnId:String;
	public var txnDate:Date;
	public var txnDateStr:String;
	public var trmId:int;
	public var cashInserted:int;

	public var version:ProjectVersion;

	public var path:Path;

	public var fields:Vector.<VisitField>;


	public function Visit(txnId:String, txnDate:String, trmId:int, cashInserted:int, version:ProjectVersion, path:Path, fields:Vector.<VisitField>) {
		this.txnId = txnId;
		this.cashInserted = cashInserted;
		this.txnDate = dateFromCSVFormat(txnDate);
		this.txnDateStr = txnDate;
		this.trmId = trmId;
		this.version = version;
		this.path = path;
		this.fields = fields;

		if (path)
			path.visit = this;
	}

	public function visitorPayed():Boolean {
		return cashInserted > 0;
	}

	public function fieldValue(key:String):String {
		var flength:int = fields.length;
		for (var i:int = 0; i < flength; i++) {
			var visitField:VisitField = fields[i];
			if (visitField.field.key == key)
				return visitField.value;
		}
		return null;
	}

	/**
	 *
	 * @param str date in string format like 2014-04-06 00:00:29
	 * @return Date object
	 */
	public static function dateFromCSVFormat(str:String):Date {
		var dt:Array = str.split(" ");
		var ymd:Array = dt[0].split("-");
		var hms:Array = dt[1].split(":");

		return new Date(ymd[0], Number(ymd[1]) - 1, ymd[2], hms[0], hms[1], hms[2]);
	}

}
}
