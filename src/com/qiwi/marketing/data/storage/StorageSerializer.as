/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.data.storage {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.entry.CustomEntry;
import com.qiwi.marketing.project.entry.DataEntry;
import com.qiwi.marketing.project.entry.ErrorEntry;
import com.qiwi.marketing.project.entry.ExitEntry;
import com.qiwi.marketing.project.entry.PageEntry;
import com.qiwi.marketing.project.entry.ServiceEntry;

import mx.collections.ArrayCollection;

public class StorageSerializer {

	public static function serializeProjects(ac:ArrayCollection):ArrayCollection {
		return new ArrayCollection(ac.source.map(function (projectItem:Object, index:int, array:Array):Project {
			var p:Project = new Project(projectItem.number, projectItem.name, projectItem.displayName, projectItem.versionRegExp);
			serializeEntries(p, projectItem);
			return p;
		}));
	}

	public static function serializeEntries(project:Project, source:Object):void {
		project.pages = serializeEntryCollection(ArrayCollection(source.pages), PageEntry);
		project.errors = serializeEntryCollection(ArrayCollection(source.errors), ErrorEntry);
		project.exits = serializeEntryCollection(ArrayCollection(source.exits), ExitEntry);
		project.services = serializeEntryCollection(ArrayCollection(source.services), ServiceEntry);
		project.dataEntries = serializeEntryCollection(ArrayCollection(source.dataEntries), DataEntry);
		project.otherEntries = serializeEntryCollection(ArrayCollection(source.otherEntries), CustomEntry);
	}

	public static function serializeEntryCollection(collection:ArrayCollection, claz:Class):ArrayCollection {
		return new ArrayCollection(collection.source.map(function (item:Object, index:int, array:Array):* {
			return (claz == DataEntry)
				? new claz(item.id, item.name, item.description, item.dataInterpretation)
				: new claz(item.id, item.name, item.description);
		}))
	}

}
}
