/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.data.importing {
import com.qiwi.marketing.data.storage.LocalStorage;
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.ProjectField;
import com.qiwi.marketing.project.visit.Visit;
import com.qiwi.marketing.project.visit.VisitField;
import com.qiwi.marketing.project.visit.path.Path;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import mx.controls.Alert;

public class CSVVisitsImporter {

	public static const PROJECT_NUMBER:String = "MGT_PROJECT_NUMBER";
	public static const DATE:String = "TXN_DATE";
	public static const ID:String = "TXN_ID";
	public static const TRM_ID:String = "TRM_ID";
	public static const VERSION:String = "MGT_VER";
	public static const PATH:String = "MGT_PATH";
	public static const SUM:String = "MGT_SUM";

	public static function importToLocalStorage(file:File):void {
		if (!file.exists) {
			Alert.show("There is no such file: '" + file.url + "'", "Error");
			return;
		}

		var fileStream:FileStream = new FileStream();
		fileStream.open(file, FileMode.READ);
		var text:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
		fileStream.close();

		var lines:Vector.<String> = Vector.<String>(text.split("\n"));

		var visits:Vector.<Object> = new Vector.<Object>();
		var fieldNames:Vector.<String> = Vector.<String>(lines[0].split("\t"));
		var linesLength:uint = lines.length;
		for (var j:int = 1; j < linesLength; j++) {
			var line:Vector.<String> = Vector.<String>(lines[j].split("\t"));

			//todo: optimize?
			if (!(line.length == fieldNames.length)) {
				if (line.length != 0 && (line.join("")))
					Alert.show("Not matching length: " + line.join(","), "Error");
				continue;
			}

			var obj:Object = {};
			for (var k:int = 0; k < fieldNames.length; k++) {
				obj[fieldNames[k]] = line[k]
			}
			visits.push(obj);
		}
		var project:Project = LocalStorage.instance.resolveProject(int(visits[0][PROJECT_NUMBER]));
		var result:Vector.<Visit> = Vector.<Visit>(visits.map(function (item:Object, index:int, array:Vector.<Object>):Visit {

			var visitFields:Vector.<VisitField> = new Vector.<VisitField>();
			for each (var pf:ProjectField in project.fields) {
				visitFields.push(new VisitField(pf, item[pf.key]));
			}

			var v:Visit = new Visit(
				item[ID],
				item[DATE],
				item[TRM_ID],
				int(item[SUM]),
				project.resolveVersion(item[VERSION]),
				new Path(item[PATH], project),
				visitFields
			);
			if (index % 10000 == 0) {
				trace(index + " -> " + item[PATH]);
			}
			return v;

		}));
		LocalStorage.instance.addVisits(result, project);
	}

}
}
