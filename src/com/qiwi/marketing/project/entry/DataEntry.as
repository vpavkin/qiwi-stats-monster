/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.entry {
public class DataEntry extends EntryBase implements IProjectEntry {

	[Bindable]
	public var dataInterpretation:Object;

	public function DataEntry(id:String, name:String, description:String, dataInterpretation:Object) {
		super(id, name, description);
		this.dataInterpretation = dataInterpretation;
	}


}
}
