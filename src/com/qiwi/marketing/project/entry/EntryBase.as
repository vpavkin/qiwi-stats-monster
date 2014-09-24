/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.entry {

public class EntryBase {

	private var _name:String;
	private var _description:String;
	private var _id:String;
	private var _alias:String;

	public function EntryBase(id:String, name:String, description:String, alias:String) {
		_name = name;
		_description = description;
		_id = id;
		_alias = alias;
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
	public function get alias():String {
		return _alias;
	}
	public function set alias(value:String):void {
		_alias = value;
	}
}
}
