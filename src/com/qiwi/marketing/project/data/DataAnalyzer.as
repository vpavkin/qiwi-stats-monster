/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.data {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.ProjectField;
import com.qiwi.marketing.project.ProjectVersion;
import com.qiwi.marketing.project.entry.DataEntry;
import com.qiwi.marketing.project.scenarios.ScenarioProcessor;
import com.qiwi.marketing.project.visit.DayOfVisits;
import com.qiwi.marketing.project.visit.Visit;
import com.qiwi.marketing.project.visit.VisitField;
import com.qiwi.marketing.project.visit.path.PathStep;

public class DataAnalyzer {

	public static function analyze(project:Project, date:String, entry:DataEntry, version:ProjectVersion):Vector.<DataEntryAnalysisResult> {
		var day:DayOfVisits = ScenarioProcessor.getDay(project, date);
		var result:Vector.<DataEntryAnalysisResult> = new Vector.<DataEntryAnalysisResult>();
		var totalCount:uint = 0,
			visitsCount:uint = day.visits.length;

		var tempResult = {};

		if (entry is ProjectField) {
			for (var i:int = 0; i < visitsCount; i++) {
				if (version != ProjectVersion.ALL_VERSIONS && (day.visits[i].version != version ))
					continue;
				var visit:Visit = day.visits[i];
				for each (var field:VisitField in visit.fields) {
					if (field.field == entry) {
						totalCount++;
						tempResult[field.value] = tempResult[field.value] ? (tempResult[field.value] + 1) : 1;
						break;
					}
				}
			}
		} else {
			for (var i:int = 0; i < visitsCount; i++) {
				if (version != ProjectVersion.ALL_VERSIONS && (day.visits[i].version != version ))
					continue;
				for (var j:int = 0; j < day.visits[i].path.steps.length; j++) {
					var step:PathStep = day.visits[i].path.steps[j];
					if (step.entry == entry.id) {
						totalCount++;
						tempResult[step.data] = tempResult[step.data] ? (tempResult[step.data] + 1) : 1;
					}
				}
			}
		}
		for (var key:String in tempResult) {
			result.push(new DataEntryAnalysisResult(key, tempResult[key], tempResult[key] / totalCount));
		}

		result.unshift(new DataEntryAnalysisResult("Всего", totalCount, 1));
		return result;
	}
}
}
