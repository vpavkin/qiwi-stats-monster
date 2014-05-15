/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.data.storage {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.visit.DayOfVisits;
import com.qiwi.marketing.project.visit.Visit;

import mx.collections.ArrayCollection;

public class LocalStorage {

	private static var _instance:LocalStorage;

	public static function get instance():LocalStorage {
		if (!_instance)
			_instance = new LocalStorage();
		return _instance
	}


	private var _projectsList:ArrayCollection;

	private var _visits:Object;

	public function LocalStorage() {
		//var id:String;
		//var appDescriptor
		//var ns:Namespace = appDescriptor.namespace();
		//var appCopyright:String = appDescriptor.ns::copyright;
		//Alert(id = .id);
		projectsList = ProjectsStorageManager.instance.loadProjectsList();

		for each (var p:Project in projectsList) {
			VisitsStorageManager.instance.loadProjectVisitsHeaders(p);
		}
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
		ProjectsStorageManager.instance.updateProjectsList(projectsList);
	}

	public function removeProject(project:Project):void {
		if (projectsList.contains(project)) {
			projectsList.removeItem(project);
			ProjectsStorageManager.instance.updateProjectsList(projectsList);
		}
	}

	public function resolveProject(num:Number):Project {
		for each (var project:Project in _projectsList) {
			if (project.number == num)
				return project;
		}
		return null;
	}

	private static function dateToStringKey(s:String):String {
		return s.substr(8, 2) + s.substr(4, 3) + "-" + s.substr(0, 4);
	}

	public static function sameDate(dateKey:String, txnDate:String):Boolean {
		return dateKey.charAt(0) == txnDate.charAt(8) &&
			dateKey.charAt(1) == txnDate.charAt(9) &&
			dateKey.charAt(3) == txnDate.charAt(5) &&
			dateKey.charAt(4) == txnDate.charAt(6)
	}

	public function addVisits(visits:Vector.<Visit>, project:Project):void {
		var ds:String = "";
		var dv:DayOfVisits;
		var vlen:uint = visits.length;
		for (var i:int = 0; i < vlen; i++) {
			var v:Visit = visits[i];
			if (!sameDate(ds, v.txnDateStr)) {
				ds = dateToStringKey(v.txnDateStr);
				dv && dv.countGeneralStats();
				dv = project.visits[ds] || (project.visits[ds] = new DayOfVisits(v.txnDate));
			}
			dv.addVisit(v);
		}
		VisitsStorageManager.instance.saveVisits(project);
	}

	public function hasProject(project:Project):Boolean {
		for each (var p:Project in _projectsList) {
			if (p.number == project.number)
				return true;
		}
		return false;
	}
}
}
