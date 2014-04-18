/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project {
import com.qiwi.marketing.project.visit.Visit;

import mx.collections.ArrayCollection;

[Bindable]
public class Project {

	public var number:int;
	public var name:String;
	public var displayName:String;

	public var versions:ArrayCollection; //of Version
	public var pages:ArrayCollection; //of Page
	public var errors:ArrayCollection; //of Error
	public var services:ArrayCollection; //of Service
	public var exits:ArrayCollection; //of Exit
	public var dataEntries:ArrayCollection; //of DataEntry
	public var otherEntries:ArrayCollection; //of CustomEntry

	public var fields:ArrayCollection;
	public var visits:ArrayCollection;


	public function Project(number:int = 0, name:String = null, displayName:String = null) {
		this.number = number;
		this.name = name;
		this.displayName = displayName;

		versions = new ArrayCollection();
		visits = new ArrayCollection([
			new Visit(123123, new Date(2014, 3, 17), 11111, this, null, null, null),
			new Visit(123123, new Date(2014, 3, 16), 11111, this, null, null, null),
			new Visit(123123, new Date(2014, 3, 16), 11111, this, null, null, null),
			new Visit(123123, new Date(2014, 3, 15), 11111, this, null, null, null)
		]);
	}


	public function get periodsAvailable():ArrayCollection {
		var result:ArrayCollection = new ArrayCollection();
		for each (var v:Visit in visits) {
			var s:String = v.txnDate.toDateString();
			if (!result.contains(s))
				result.addItem(s);
		}
		return result;
	}

}
}
