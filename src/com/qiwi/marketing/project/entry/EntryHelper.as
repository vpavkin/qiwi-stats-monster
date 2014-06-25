/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.entry {
public class EntryHelper {

	public static function isPage(entry:String):Boolean {
		return /^\d\d*$/.test(entry);
	}

}
}
