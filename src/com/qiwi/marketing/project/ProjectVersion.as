/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project {


public class ProjectVersion {

	public static const ALL_VERSIONS:ProjectVersion = new ProjectVersion("Все версии");

	public var value:String;

	public function ProjectVersion(value:String) {
		this.value = value;
	}
}
}
