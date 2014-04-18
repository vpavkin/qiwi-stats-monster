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

import mx.collections.ArrayCollection;
import mx.controls.Alert;

public class CSVVisitsImporter {

	public static const COMMON_VARS:Object = {
		PROJECT_NUMBER: "MGT_PROJECT_NUMBER",
		DATE          : "TXN_DATE",
		ID            : "TXN_ID",
		TRM_ID        : "TRM_ID",
		VERSION       : "MGT_VER",
		PATH          : "MGT_PATH"
	};

	public static function importToLocalStorage(file:File):void {
		if (!file.exists) {
			Alert.show("There is no such file: '" + file.url + "'");
			return;
		}

		var fileStream:FileStream = new FileStream();
		fileStream.open(file, FileMode.READ);
		var text:String = fileStream.readMultiByte(fileStream.bytesAvailable, "windows-1251");

		var visits:Array = [];

		var lines:Array = text.split("\n");
		var fieldNames:Array = lines[0].split("\t");
		for (var j:int = 1; j < lines.length; j++) {
			var line:Array = lines[j].split("\t");
			if (!(line.length == fieldNames.length)) {
				if (line.length != 0)
					Alert.show("Not matching length: " + line.join(","));
				continue;
			}
			var obj = {};
			fieldNames.every(function (item:String, index:int, array:Array):* {
				obj[item] = line[index];
				return true
			});
			visits.push(obj);
		}
		var result:Array = visits.map(function (item:Object, index:int, array:Array):Visit {
			var project:Project = LocalStorage.instance.resolveProject(int(item[COMMON_VARS.PROJECT_NUMBER]));
			var visitFields:ArrayCollection = new ArrayCollection();
			for each (var pf:ProjectField in project.fields) {
				visitFields.addItem(new VisitField(pf, item[pf.key]));
			}
			return new Visit(
				item[COMMON_VARS.ID],
				new Date(),//todo: dateFromString(item[COMMON_VARS.DATE])
				item[COMMON_VARS.TRM_ID],
				item[COMMON_VARS.PROJECT_NUMBER],
				item[COMMON_VARS.VERSION],
				new Path(item[COMMON_VARS.PATH], project),
				visitFields
			)
		});
		fileStream.close();
	}

}
}
