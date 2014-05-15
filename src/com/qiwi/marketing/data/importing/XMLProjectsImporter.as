/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.data.importing {
import com.qiwi.marketing.data.storage.LocalStorage;
import com.qiwi.marketing.data.storage.VisitsStorageManager;
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.ProjectField;
import com.qiwi.marketing.project.ProjectFlow;
import com.qiwi.marketing.project.entry.CustomEntry;
import com.qiwi.marketing.project.entry.DataEntry;
import com.qiwi.marketing.project.entry.ErrorEntry;
import com.qiwi.marketing.project.entry.ExitEntry;
import com.qiwi.marketing.project.entry.IProjectEntry;
import com.qiwi.marketing.project.entry.PageEntry;
import com.qiwi.marketing.project.entry.ServiceEntry;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import mx.controls.Alert;
import mx.events.CloseEvent;

public class XMLProjectsImporter {

	public static const TAGS:Object = {
		PAGE   : "page",
		ERROR  : "error",
		SERVICE: "service",
		DATA   : "data",
		EXIT   : "exit",
		OTHER  : "other"
	};

	private static var _pendingUpdate:Project;

	public static function importToLocalStorage(file:File):void {
		if (!file.exists) {
			Alert.show("There is no such file: '" + file.url + "'");
			return;
		}


		var fileStream:FileStream = new FileStream();
		fileStream.open(file, FileMode.READ);
		var text:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
		var xml:XML = new XML(text);
		var project:Project = parseXMLProject(xml);
		fileStream.close();
		if (LocalStorage.instance.hasProject(project)) {
			_pendingUpdate = project;
			var a:Alert = Alert.show("You already have project with ID=" + project.number + ".\nDo you want to update it?", "Project is already in database.", Alert.YES | Alert.NO)
			a.addEventListener(CloseEvent.CLOSE, onAlertClosed);
			return;
		}
		LocalStorage.instance.addProject(project);
		VisitsStorageManager.instance.loadProjectVisitsHeaders(project)
	}

	private static function onAlertClosed(event:CloseEvent):void {
		if (event.detail == Alert.YES && _pendingUpdate) {
			var old:Project = LocalStorage.instance.resolveProject(_pendingUpdate.number);
			var v:Object = old.visits;
			LocalStorage.instance.removeProject(old);
			LocalStorage.instance.addProject(_pendingUpdate);
			_pendingUpdate.visits = v;
		}
		_pendingUpdate = null
	}

	public static function parseXMLProject(xml:XML):Project {
		var res:Project = new Project(int(xml.@id), xml.@project, xml.@name, xml.@versionRegExp);
		res.pages = Vector.<PageEntry>(parseEntry(xml, TAGS.PAGE));
		res.errors = Vector.<ErrorEntry>(parseEntry(xml, TAGS.ERROR));
		res.services = Vector.<ServiceEntry>(parseEntry(xml, TAGS.SERVICE));
		res.exits = Vector.<ExitEntry>(parseEntry(xml, TAGS.EXIT));
		res.dataEntries = Vector.<DataEntry>(parseEntry(xml, TAGS.DATA));
		res.otherEntries = Vector.<CustomEntry>(parseEntry(xml, TAGS.OTHER));
		res.fields = Vector.<ProjectField>(parseFields(xml));
		res.flows = Vector.<ProjectFlow>(parseFlows(xml));
		return res;
	}

	private static function parseFlows(xml:XML):Array {
		var result:Array = [];
		var list:XMLList = xml.flows.flow;
		for each (var item:XML in list) {
			result.push(new ProjectFlow(item.@name, item.@entries));
		}
		return result;
	}

	private static function parseFields(xml:XML):Array {
		var result:Array = [];
		var list:XMLList = xml.fields.field;
		for each (var item:XML in list) {
			result.push(new ProjectField(item.@id, item.@name));
		}
		return result;
	}

	private static function parseEntry(xml:XML, tagName:String):Array {
		var result:Array = [];

		var tags:XMLList = xml[tagName];
		if (!tags && !tags.length())
			return result;

		for each (var item:XML in tags) {
			result.push(createEntry(item, tagName))
		}
		return result;
	}

	private static function createEntry(item:XML, tagName:String):IProjectEntry {
		var entry:IProjectEntry;
		switch (tagName) {
			case TAGS.PAGE:
				entry = new PageEntry(item.@id, item.@name, item.toString());
				break;
			case TAGS.ERROR:
				entry = new ErrorEntry(item.@id, item.@name, item.toString());
				break;
			case TAGS.EXIT:
				entry = new ExitEntry(item.@id, item.@name, item.toString());
				break;
			case TAGS.SERVICE:
				entry = new ServiceEntry(item.@id, item.@name, item.toString());
				break;
			case TAGS.DATA:
				var interpretation:Object = {};
				var intStr:String = item.@interpretation;
				intStr.split("|").forEach(function (item:String, index:int, array:Array):* {
					var kv:Array = item.split(":");
					if (kv[0] && kv[1])
						interpretation[kv[0]] = kv[1];
				});
				interpretation.default = item.@defaultInterpretation;
				entry = new DataEntry(item.@id, item.@name, item.toString(), interpretation);
				break;
			case TAGS.OTHER:
				entry = new CustomEntry(item.@id, item.@name, item.toString());
				break;
		}
		return entry;
	}

}
}
