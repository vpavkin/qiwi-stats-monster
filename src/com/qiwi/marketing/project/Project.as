/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project {
import com.qiwi.marketing.project.entry.CustomEntry;
import com.qiwi.marketing.project.entry.IProjectEntry;

import mx.collections.ArrayCollection;

[Bindable]
public class Project {

	public var number:int;
	public var name:String;
	public var displayName:String;
	public var versionRegExp:String;

	public var versions:ArrayCollection; //of Version
	public var pages:ArrayCollection; //of Page
	public var errors:ArrayCollection; //of Error
	public var services:ArrayCollection; //of Service
	public var exits:ArrayCollection; //of Exit
	public var dataEntries:ArrayCollection; //of DataEntry
	public var otherEntries:ArrayCollection; //of CustomEntry

	public var fields:ArrayCollection; // of ProjectField
	public var visits:Object;// ["DD-MM-YYYY"]=DayOfVisits

	private var _versionRegExpInstance:RegExp;


	public function Project(number:int = 0, name:String = null, displayName:String = null, versionRegExp:String = null) {
		this.number = number;
		this.name = name;
		this.displayName = displayName;
		this.versionRegExp = versionRegExp ? versionRegExp : "(.*)";
		this._versionRegExpInstance = new RegExp(this.versionRegExp);
		versions = new ArrayCollection();
		visits = {};
	}

	public function resolveEntry(entryStr:String):IProjectEntry {
		var entries:Array = [pages, errors, services, dataEntries, exits, otherEntries];
		for each (var ac:ArrayCollection in entries) {
			for each (var entry:IProjectEntry in ac) {
				if (entry.id == entryStr)
					return entry;
			}
		}
		return new CustomEntry(entryStr, "Unknown", "Unknown");
	}
	public function resolveVersion(version:String):ProjectVersion {
		var processedVersion:String = version.replace(_versionRegExpInstance, "$1");
		for each (var pv:ProjectVersion in versions) {
			if (pv.value == processedVersion)
				return pv;
		}
		var res:ProjectVersion = new ProjectVersion(processedVersion);
		versions.addItem(res);
		return res;
	}
}
}
