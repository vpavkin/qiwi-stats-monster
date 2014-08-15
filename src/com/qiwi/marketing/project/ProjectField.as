/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project {
import com.qiwi.marketing.project.entry.DataEntry;

public class ProjectField extends DataEntry {

	public function ProjectField(key:String, displayName:String) {
		super(key, displayName, displayName, {});
		this.displayName = displayName ? displayName : key;
		this.key = key;
	}
	public var displayName:String;
	public var key:String;

}
}
