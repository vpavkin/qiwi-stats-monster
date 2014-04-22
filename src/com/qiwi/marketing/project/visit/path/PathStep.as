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
	public var time:int;

	public function PathStep(projectEntry:IProjectEntry, time:int, data:String = null) {
		this.projectEntry = projectEntry;
		this.time = time;
		this.data = data;
	}
}
}
