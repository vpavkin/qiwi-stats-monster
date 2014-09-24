/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.entry {
public class EntryHelper {

	public static function isPage(entry:String):Boolean {
		return /^\d\d*$/.test(entry);
	}

	public static function isData(entry:String):Boolean {
		return /^\d+D.*$/.test(entry);
	}

	public static function isExit(entry:String):Boolean {
		return /^X\d*$/.test(entry);
	}
}
}
