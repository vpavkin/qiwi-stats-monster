/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project {
import com.qiwi.marketing.project.entry.CustomEntry;
import com.qiwi.marketing.project.entry.DataEntry;
import com.qiwi.marketing.project.entry.ErrorEntry;
import com.qiwi.marketing.project.entry.ExitEntry;
import com.qiwi.marketing.project.entry.IProjectEntry;
import com.qiwi.marketing.project.entry.PageEntry;
import com.qiwi.marketing.project.entry.ServiceEntry;
import com.qiwi.marketing.project.scenarios.ProjectFlow;
import com.qiwi.marketing.project.scenarios.ProjectScenario;
import com.qiwi.marketing.project.visit.DayOfVisits;
import com.qiwi.marketing.utils.DateKeyUtils;

import mx.collections.ArrayCollection;
import mx.collections.Sort;

public class Project {

	public var number:int;
	public var name:String;
	public var displayName:String;
	public var versionRegExp:String;

	public var versions:Vector.<ProjectVersion>;
	public var pages:Vector.<PageEntry>;
	public var errors:Vector.<ErrorEntry>;
	public var services:Vector.<ServiceEntry>;
	public var exits:Vector.<ExitEntry>;
	public var dataEntries:Vector.<DataEntry>;
	public var otherEntries:Vector.<CustomEntry>;

	public var fields:Vector.<ProjectField>; // of ProjectField
	[Bindable]
	public var visits:Object; // ["DD-MM-YYYY"]=DayOfVisits
	[Bindable]
	public var flows:Vector.<ProjectFlow>;
	[Bindable]
	public var scenarios:Vector.<ProjectScenario>;

	private var _versionRegExpInstance:RegExp;


	public function Project(number:int = 0, name:String = null, displayName:String = null, versionRegExp:String = null) {
		this.number = number;
		this.name = name;
		this.displayName = displayName;
		this.versionRegExp = versionRegExp ? versionRegExp : "(.*)";
		this._versionRegExpInstance = new RegExp(this.versionRegExp);
		versions = new Vector.<ProjectVersion>();
		visits = {};
	}

	//todo:optimize?
	public function resolveVersion(version:String):ProjectVersion {
		var processedVersion:String = version.replace(_versionRegExpInstance, "$1");
		for each (var pv:ProjectVersion in versions) {
			if (pv.value == processedVersion)
				return pv;
		}
		var res:ProjectVersion = new ProjectVersion(processedVersion);
		versions.push(res);
		return res;
	}

	[Bindable]
	public function get visitsOverview():ArrayCollection {
		var res:ArrayCollection = new ArrayCollection();
		for (var key:String in visits) {
			var dv:DayOfVisits = DayOfVisits(visits[key]);
			res.addItem({
				date      : key,
				dateTime  : dv.date.getTime(),
				visits    : dv.visits.length,
				pays      : dv.paysCount,
				conversion: dv.conversionDisplay
			});
		}
		res.sort = new Sort();
		res.sort.compareFunction = DateKeyUtils.compareFunction;
		res.refresh();
		return res;
	}

	public function resolvePage(str:String):IProjectEntry {
		var len:uint = pages.length;
		for (var i:int = 0; i < len; i++) {
			var entry:PageEntry = pages[i];
			if (entry.id == str)
				return entry;
		}
		return new PageEntry(str, "Unknown", "Unknown");
	}

	public function resolveDataEntry(str:String):IProjectEntry {
		var len:uint = dataEntries.length;
		for (var i:int = 0; i < len; i++) {
			var entry:DataEntry = dataEntries[i];
			if (entry.id == str)
				return entry;
		}
		return new DataEntry(str, "Unknown", "Unknown", {});

	}
	public function resolveError(str:String):IProjectEntry {
		var len:uint = errors.length;
		for (var i:int = 0; i < len; i++) {
			var entry:ErrorEntry = errors[i];
			if (entry.id == str)
				return entry;
		}
		return new ErrorEntry(str, "Unknown", "Unknown");
	}
	public function resolveService(str:String):IProjectEntry {
		var len:uint = services.length;
		for (var i:int = 0; i < len; i++) {
			var entry:ServiceEntry = services[i];
			if (entry.id == str)
				return entry;
		}
		return new ServiceEntry(str, "Unknown", "Unknown");
	}
	public function resolveExit(str:String):IProjectEntry {
		var len:uint = exits.length;
		for (var i:int = 0; i < len; i++) {
			var entry:ExitEntry = exits[i];
			if (entry.id == str)
				return entry;
		}
		return new ExitEntry(str, "Unknown", "Unknown");
	}
	public function resolveCustomEntry(str:String):IProjectEntry {
		var len:uint = otherEntries.length;
		for (var i:int = 0; i < len; i++) {
			var entry:CustomEntry = otherEntries[i];
			if (entry.id == str)
				return entry;
		}
		return new CustomEntry(str, "Unknown", "Unknown");
	}

	public function resolveField(key:String):ProjectField {
		for (var i:int = 0; i < fields.length; i++) {
			var field:ProjectField = fields[i];
			if (field.key == key)
				return field;
		}
		trace("***** Exception: Field '" + key + "' was not resolved");
		return null;
	}

	public function resolveEntry(str:String):IProjectEntry {
		var arr:Array = [pages, errors, services, exits, dataEntries, otherEntries];
		for (var i:int = 0; i < arr.length; i++) {
			var item:* = arr[i];
			var len:uint = item.length;
			for (var j:int = 0; j < len; j++) {
				var entry:IProjectEntry = item[j];
				if (entry.id == str)
					return entry;
			}
		}
		return new CustomEntry(str, "Unknown", "Unknown");
	}
}
}
