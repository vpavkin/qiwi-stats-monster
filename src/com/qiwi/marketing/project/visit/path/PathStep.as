/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit.path {
import com.qiwi.marketing.project.entry.IProjectEntry;

public class PathStep {

	public var projectEntry:IProjectEntry;
	public var entry:String;
	public var data:String;
	public var time:int;

	public function PathStep(entry:String, time:int, data:String = null) {
		this.entry = entry;
		this.time = time;
		this.data = data;
	}
}
}
