/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios {
public class ProjectFlow {

	public var name:String;
	public var entries:Vector.<String>;
	public var aggregate:Boolean;

	public function ProjectFlow(name:String, entries:String, aggregate:Boolean) {
		this.name = name;
		this.entries = Vector.<String>(entries.split("|"));
		this.aggregate = aggregate;
	}
}
}
