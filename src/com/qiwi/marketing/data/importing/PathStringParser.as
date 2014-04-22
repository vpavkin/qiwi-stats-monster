/**
 *
 * @author Vladimir
 */
package com.qiwi.marketing.data.importing {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.entry.IProjectEntry;
import com.qiwi.marketing.project.visit.path.PathStep;

import mx.collections.ArrayCollection;

public class PathStringParser {

	public static function parsePathString(pathStr:String, project:Project):ArrayCollection {
		var res:ArrayCollection = new ArrayCollection();
		var stepsArr:Array = pathStr.split("|");
		for each (var step:String in stepsArr) {
			var et:Array = step.split(":");
			res.addItem(parseStep(et[0], et[1], project));
		}
		return res;
	}

	public static function parseStep(entryStr:String, timeStr:String, project:Project):PathStep {
		var pureEntryStr:String = entryStr, data:String = null;
		var iOfD:int = entryStr.indexOf("D");
		if (iOfD >= 1) {
			pureEntryStr = entryStr.substr(0, iOfD + 1);
			data = entryStr.substr(iOfD + 1);
		}
		var entry:IProjectEntry = project.resolveEntry(pureEntryStr);
		return new PathStep(entry, parseInt(timeStr, 32), data)
	}
}
}
