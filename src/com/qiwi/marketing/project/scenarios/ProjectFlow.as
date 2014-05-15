/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios {
public class ProjectFlow {

	public var name:String;
	public var entries:Vector.<String>;

	public function ProjectFlow(name:String, entries:String) {
		this.name = name;
		this.entries = Vector.<String>(entries.split("|"));
	}
}
}
