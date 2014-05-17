/**
 * Created by Vladimir on 20.04.2014.
 */
package com.qiwi.marketing.data.storage {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.visit.DayOfVisits;
import com.qiwi.marketing.project.visit.Visit;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

public class VisitsStorageManager {

	private static var _instance:VisitsStorageManager;

	public static function get instance():VisitsStorageManager {
		if (!_instance)
			_instance = new VisitsStorageManager();
		return _instance;
	}

	private var _dataDirectory:File;

	public function VisitsStorageManager() {
		_dataDirectory = File.documentsDirectory.resolvePath("Marketing" + "/data");
		if (!_dataDirectory.exists)
			_dataDirectory.createDirectory();
	}

	public function loadProjectVisitsHeaders(project:Project):void {
		var pd:File = _dataDirectory.resolvePath(project.number.toString());
		if (!pd.exists)
			pd.createDirectory();
		var pFiles:Array = pd.getDirectoryListing();
		for each (var pf:File in pFiles) {
			if (pf.isDirectory || !/^\d\d-\d\d\-\d\d\d\d\.st$/.test(pf.name))
				continue;
			project.visits[pf.name.split(".")[0]] = VisitsStorageManager.loadHeader(pf);
		}
	}

	public function loadVisits(project:Project, date:String):Vector.<Visit> {
		var v:File = _dataDirectory.resolvePath(project.number.toString() + "/" + date + ".st");
		if (!v.exists)
			return new Vector.<Visit>();
		var ba:ByteArray = new ByteArray();
		var fileStream:FileStream = new FileStream();
		fileStream.open(v, FileMode.READ);
		fileStream.readBytes(ba);
		fileStream.close();
		ba.uncompress();
		var dov:Vector.<Object> = ba.readObject();
		return StorageSerializer.serializeVisits(dov, project);
	}

	public static function loadHeader(file:File):DayOfVisits {
		return new DayOfVisits(fileNameToDate(file.name))
	}

	public static function fileNameToDate(name:String):Date {
		var dmy:Array = name.split(".")[0].split("-");
		return new Date(dmy[2], Number(dmy[1]) - 1, dmy[0]);
	}

	public function saveVisits(project:Project):void {
		var pd:File = _dataDirectory.resolvePath(project.number.toString());
		if (!pd.exists)
			pd.createDirectory();
		for (var d:String in project.visits) {
			var stFile:File;
			if ((stFile = pd.resolvePath(d + ".st")).exists)
				continue;
			saveVisitsFile(stFile, project.visits[d])
		}
	}

	private function saveVisitsFile(file:File, dov:DayOfVisits):void {
		var ba:ByteArray = new ByteArray();
		ba.writeObject(dov.visits);
		ba.compress();
		var fileStream:FileStream = new FileStream();
		fileStream.open(file, FileMode.WRITE);
		fileStream.writeBytes(ba);
		fileStream.close();
	}
}
}
