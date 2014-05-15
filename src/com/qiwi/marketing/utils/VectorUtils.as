/**
 *
 * @author Vladimir
 */
package com.qiwi.marketing.utils {
public class VectorUtils {

	public static function map(v:*, iterator:Function):Array {
		var res:Array = [];
		var vlen:uint = v.length;
		for (var i:int = 0; i < vlen; i++) {
			res.push(iterator(v[i], i, res));
		}
		return res;
	}

}
}
