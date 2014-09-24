/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.entry {
public class DataEntry extends EntryBase implements IProjectEntry {


	public var dataInterpretation:Object;

	public function DataEntry(id:String, name:String, description:String, alias:String, dataInterpretation:Object) {
		super(id, name, description, alias);
		this.dataInterpretation = dataInterpretation;
	}

	public function getInterpretation(val:String):String {
		return dataInterpretation[val] || (dataInterpretation.default || val);
	}
}
}
