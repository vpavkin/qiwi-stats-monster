/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios {
import com.qiwi.marketing.data.storage.VisitsStorageManager;
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.ProjectVersion;
import com.qiwi.marketing.project.entry.DataEntry;
import com.qiwi.marketing.project.entry.IProjectEntry;
import com.qiwi.marketing.project.visit.DayOfVisits;
import com.qiwi.marketing.project.visit.path.Path;

public class ScenarioProcessor {

	public static function getFlowData(project:Project, date:String, flow:ProjectFlow, version:ProjectVersion):Vector.<FlowEntryData> {

		var day:DayOfVisits = project.visits[date];
		if (!day.isLoaded) {
			day.setVisits(VisitsStorageManager.instance.loadVisits(project, date));
			day.isLoaded = true;
		}

		var result:Vector.<FlowEntryData> = prepareFlowData(flow, project);
		var totalEnters:uint = 0,
			totalPayments:uint = 0,
			payed:Boolean,
			visitsCount:uint = day.visits.length;

		for (var i:int = 0; i < visitsCount; i++) {
			if (version != ProjectVersion.ALL_VERSIONS && (day.visits[i].version != version ))
				continue;
			totalEnters++;
			if (payed = day.visits[i].visitorPayed())
				totalPayments++;
			flowCollector(result, day.visits[i].path, payed);
		}
		result.unshift(
			new FlowEntryData("", "Всего", "Всего входов", "", totalEnters, totalPayments)
		);
		return result;
	}

	private static function flowCollector(flowData:Vector.<FlowEntryData>, path:Path, payed:Boolean):void {
		var stepsCount:uint = path.steps.length;
		for (var flowIndex:int = 0; flowIndex < flowData.length; flowIndex++) {
			var entry:FlowEntryData = flowData[flowIndex];
			for (var stepIndex:int = 0; stepIndex < stepsCount; stepIndex++) {
				if (path.steps[stepIndex].entry == entry.entry && (!entry.data || entry.data == path.steps[stepIndex].data)) {
					entry.enters++;
					if (payed)
						entry.payments++;
					break;
				}
			}
		}
	}
	private static function prepareFlowData(flow:ProjectFlow, project:Project):Vector.<FlowEntryData> {
		var result:Vector.<FlowEntryData> = new Vector.<FlowEntryData>();
		flow.entries.forEach(function (item:String, index:int, array:*):* {
				var entry:String = item,
					data:String = null,
					entryName:String;
				if (item.indexOf("D:")) {//data item
					var arr:Array = item.split(":");
					entry = arr[0];
					data = arr[1];
				}
				var e:IProjectEntry = project.resolveEntry(entry);
				entryName = e.name + (((entry is DataEntry) && data) ? ":\n" + DataEntry(entry).getInterpretation(data) : "");
				result.push(new FlowEntryData(entry, item, entryName, data));
			}
		);
		return result;
	}

}
}
