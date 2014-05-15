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

	public function FlowEntryData(entry:String, entryLabel:String, entryName:String, data:String, enters:uint = 0, payments:uint = 0) {
		this.entry = entry;
		this.entryLabel = entryLabel;
		this.entryName = entryName;
		this.data = data;
		this.enters = enters;
		this.payments = payments;
	}
}
}
