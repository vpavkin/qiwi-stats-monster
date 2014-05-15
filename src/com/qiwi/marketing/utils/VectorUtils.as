/**
 *
 * @author Vladimir
 */
package com.qiwi.marketing.utils {
import mx.collections.ArrayCollection;

public class VectorUtils {

	public static function map(v:*, iterator:Function):Array {
		var res:Array = [];
		var vlen:uint = v.length;
		for (var i:int = 0; i < vlen; i++) {
			res.push(iterator(v[i], i, res));
		}
		return res;
	}

	public static function toArrayCollection(v:*):ArrayCollection {
		var res:Array = [];
		var vlen:uint = v.length;
		for (var i:int = 0; i < vlen; i++) {
			res.push(v[i]);
		}
		return new ArrayCollection(res);
	}

}
}
