/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.data.storage {
import com.qiwi.marketing.project.Project;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import mx.collections.ArrayCollection;

public class LocalStorage {

	private static var _instance:LocalStorage;

	public static function get instance():LocalStorage {
		if (!_instance)
			_instance = new LocalStorage();
		return _instance
	}

	private var _projectsListFile:File;
	private var _projectsList:ArrayCollection;
	private var _cache:Object;

	public function LocalStorage() {
		//var id:String;
		//var appDescriptor
		//var ns:Namespace = appDescriptor.namespace();
		//var appCopyright:String = appDescriptor.ns::copyright;
		//Alert(id = .id);

		_projectsListFile = File.documentsDirectory.resolvePath("Marketing" + "/data/list.mgd");
		trace(_projectsListFile.url);
		_projectsListFile.exists ? loadProjectsList() : initProjectsList();
	}

	private function initProjectsList():void {
		projectsList = new ArrayCollection([]);
		saveProjectsList();
	}

	private function loadProjectsList():void {
		var fileStream:FileStream = new FileStream();
		fileStream.open(_projectsListFile, FileMode.READ);
		this.projectsList = StorageSerializer.serializeProjects(fileStream.readObject());
		fileStream.close();
		trace(projectsList);
	}

	private function saveProjectsList():void {
		var fileStream:FileStream = new FileStream();
		fileStream.open(_projectsListFile, FileMode.WRITE);
		fileStream.writeObject(this.projectsList);
		fileStream.close();
	}


	public function loadProjectVisits():ArrayCollection /*of Visit*/ {
		return new ArrayCollection();
	}

	[Bindable]
	public function get projectsList():ArrayCollection {
		return _projectsList;
	}

	public function set projectsList(value:ArrayCollection):void {
		_projectsList = value;
	}

	public function addProject(project:Project):void {
		projectsList.addItem(project);
		saveProjectsList();
	}
	public function removeProject(project:Project):void {
		if (projectsList.contains(project)) {
			projectsList.removeItem(project);
			saveProjectsList();
		}
	}
	public function resolveProject(num:Number):Project {
		for each (var project:Project in _projectsList) {
			if (project.number == num)
				return project;
		}
		return null;
	}
}
}
