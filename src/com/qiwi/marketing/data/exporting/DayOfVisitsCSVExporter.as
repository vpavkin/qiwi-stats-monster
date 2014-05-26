/**
 *
 * @author Vladimir
 */
package com.qiwi.marketing.data.exporting {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.ProjectVersion;
import com.qiwi.marketing.project.scenarios.FlowEntryData;
import com.qiwi.marketing.project.scenarios.ProjectFlow;
import com.qiwi.marketing.project.scenarios.ScenarioProcessor;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

public class DayOfVisitsCSVExporter {

	public static function export(file:File, project:Project, dateKey:String):void {

		var result:Array = [];

		if (project.flows)
			result = result.concat(getCSV(project, dateKey, project.flows));
		if (project.scenarios)
			result = result.concat(getCSV(project, dateKey, project.scenarios));

		var fileStream:FileStream = new FileStream();
		fileStream.open(file, FileMode.WRITE);
		fileStream.writeMultiByte(result.join("\n"), "windows-1251");
		fileStream.close();
	}

	private static function getCSV(project:Project, dateKey:String, flows:*):Array {
		var result:Array = [];
		for (var i:int = 0; i < flows.length; i++) {
			var data:Vector.<FlowEntryData> = ScenarioProcessor.getFlowData(project, dateKey, flows[i], ProjectVersion.ALL_VERSIONS);
			if (!result.length) {
				result.push(FlowEntryData.CSVHeader(), data[0].toCSVString(data[0].enters));
			}
			result.push(flows[i].name);
			for (var j:int = 1; j < data.length; j++) {
				result.push(data[j].toCSVString(data[0].enters));
			}
		}
		return result;
	}

}
}
