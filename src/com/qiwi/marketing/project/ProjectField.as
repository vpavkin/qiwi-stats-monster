/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project {


public class ProjectField {

	public function ProjectField(key:String, displayName:String) {
		this.displayName = displayName ? displayName : key;
		this.key = key;
	}
	public var displayName:String;
	public var key:String;

}
}
