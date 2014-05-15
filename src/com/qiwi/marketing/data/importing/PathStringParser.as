/**
 *
 * @author Vladimir
 */
package com.qiwi.marketing.data.importing {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.visit.path.PathStep;

public class PathStringParser {

	public static function parsePathString(pathStr:String, project:Project):Vector.<PathStep> {
		var res:Vector.<PathStep> = new Vector.<PathStep>();
		var stepsArr:Vector.<String> = Vector.<String>(pathStr.split("|"));
		var stepsCount:uint = stepsArr.length;

		for (var i:int = 0; i < stepsCount; i++) {
			var step:String = stepsArr[i];
			var et:Vector.<String> = Vector.<String>(step.split(":"));
			if (!step || !(et.length >= 2))
				res[i] = new PathStep("ERR", 0);
			else
				res[i] = parseStep(et[0], et[1], project);
		}
		return res;
	}

	public static function parseStep(entryStr:String, timeStr:String, project:Project):PathStep {
		var o:Object = parseEntry(entryStr);
		return new PathStep(o.entry, parseInt(timeStr, 32), o.data)
	}

	public static function parseEntry(entryStr:String):Object {
		var pureEntryStr:String = entryStr, data:String = "";
		var f:String = entryStr.charAt(0);
		switch (f) {
			case "0":
			case "1":
			case "2":
			case "3":
			case "4":
			case "5":
			case "6":
			case "7":
			case "8":
			case "9":
				var i:uint = 0;
				do {
					i++;
					f = entryStr.charAt(i)
				}
				while (f && f != "D");
				switch (f) {
					case "":
						break;
					case "D":
						pureEntryStr = entryStr.substr(0, i + 1);
						data = entryStr.substr(i + 1);
						break;
				}
				break;
		}
		return {entry: pureEntryStr, data: data};
	}
}
}
