/**
 *
 * @author Vladimir
 */
package com.qiwi.marketing.resources {
import mx.resources.ResourceManager;

public class R {
	public static function s(key:String):String {
		return ResourceManager.getInstance().getString("resources", key)
	}
}
}
