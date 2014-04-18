/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit.path {
import com.qiwi.marketing.project.entry.IProjectEntry;

[Bindable]
public class PathStep {

	public var projectEntry:IProjectEntry;
	public var data:String;
	public var time:Date;

	public function PathStep(projectEntry:IProjectEntry, time:Date, data:String = null) {
		this.projectEntry = projectEntry;
		this.time = time;
		this.data = data;
	}
}
}
