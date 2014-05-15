/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.data.storage {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.ProjectField;
import com.qiwi.marketing.project.ProjectFlow;
import com.qiwi.marketing.project.entry.CustomEntry;
import com.qiwi.marketing.project.entry.DataEntry;
import com.qiwi.marketing.project.entry.ErrorEntry;
import com.qiwi.marketing.project.entry.ExitEntry;
import com.qiwi.marketing.project.entry.PageEntry;
import com.qiwi.marketing.project.entry.ServiceEntry;
import com.qiwi.marketing.project.visit.Visit;
import com.qiwi.marketing.project.visit.VisitField;
import com.qiwi.marketing.project.visit.path.Path;
import com.qiwi.marketing.project.visit.path.PathStep;

import mx.collections.ArrayCollection;

public class StorageSerializer {

	public static function serializeProjects(ac:ArrayCollection):ArrayCollection {
		return new ArrayCollection(ac.source.map(function (projectItem:Object, index:int, array:Array):Project {
			var p:Project = new Project(projectItem.number, projectItem.name, projectItem.displayName, projectItem.versionRegExp);
			serializeEntries(p, projectItem);
			serializeFields(p, projectItem);
			serializeFlows(p, projectItem);
			return p;
		}));
	}

	public static function serializeFields(project:Project, source:Object):void {
		project.fields = Vector.<ProjectField>(source.fields.map(function (item:*, index:int, array:*):ProjectField {
			return new ProjectField(item.key, item.displayName);
		}))
	}

	public static function serializeFlows(project:Project, source:Object):void {
		project.flows = Vector.<ProjectFlow>(source.flows.map(function (item:*, index:int, array:*):ProjectFlow {
			return new ProjectFlow(item.name, item.entries.join("|"));
		}))
	}

	public static function serializeEntries(project:Project, source:Object):void {
		project.pages = Vector.<PageEntry>(serializeEntryCollection(source.pages, PageEntry));
		project.errors = Vector.<ErrorEntry>(serializeEntryCollection(source.errors, ErrorEntry));
		project.exits = Vector.<ExitEntry>(serializeEntryCollection(source.exits, ExitEntry));
		project.services = Vector.<ServiceEntry>(serializeEntryCollection(source.services, ServiceEntry));
		project.dataEntries = Vector.<DataEntry>(serializeEntryCollection(source.dataEntries, DataEntry));
		project.otherEntries = Vector.<CustomEntry>(serializeEntryCollection(source.otherEntries, CustomEntry));
	}

	public static function serializeEntryCollection(collection:Object, claz:Class):* {
		return collection.map(function (item:Object, index:int, array:*):* {
			return (claz == DataEntry)
				? new claz(item.id, item.name, item.description, item.dataInterpretation)
				: new claz(item.id, item.name, item.description);
		})
	}

	public static function serializeVisits(visits:Vector.<Object>, project:Project):Vector.<Visit> {
		return Vector.<Visit>(visits.map(function (item:Object, index:int, array:*):* {
			return new Visit(item.txnId, item.txnDate, item.trmId, item.cashInserted, project.resolveVersion(item.version.value), serializePath(item.path, project), serializeVisitFields(item.fields, project));
		}))
	}

	public static function serializeVisitFields(fields:Vector.<Object>, project:Project):Vector.<VisitField> {
		return Vector.<VisitField>(fields.map(function (item:*, index:int, array:*):* {
			return new VisitField(project.resolveField(item.field.key), item.value);
		}))
	}

	public static function serializePath(path:Object, project:Project):Path {
		return new Path(path.pathString, project, serializePathSteps(path.steps, project));
	}

	private static function serializePathSteps(steps:Vector.<Object>, project:Project):Vector.<PathStep> {
		return Vector.<PathStep>(steps.map(function (item:*, index:int, array:*):* {
			return new PathStep(item.entry, item.time, item.data);
		}))
	}
}
}
