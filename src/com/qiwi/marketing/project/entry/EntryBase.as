/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.entry {

[Bindable]
public class EntryBase {

	private var _name:String;
	private var _description:String;
	private var _id:String;

	public function EntryBase(id:String, name:String, description:String) {
		_name = name;
		_description = description;
		_id = id;
	}

	public function get name():String {
		return _name;
	}
	public function get description():String {
		return _description;
	}
	public function get id():String {
		return _id;
	}
	public function set name(value:String):void {
		_name = value;
	}
	public function set description(value:String):void {
		_description = value;
	}
	public function set id(value:String):void {
		_id = value;
	}
}
}
