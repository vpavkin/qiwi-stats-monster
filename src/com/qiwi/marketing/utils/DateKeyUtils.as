/**
 *
 * @author Vladimir
 */
package com.qiwi.marketing.utils {
import spark.components.gridClasses.GridColumn;

public class DateKeyUtils {

	public static function compareFunctionForGrid(p1:Object, p2:Object, column:GridColumn):int {
		return compareFunction(p1, p2)
	}

	public static function compareFunction(p1:Object, p2:Object, c:* = null):int {
		if (p1 == null && p2 == null)
			return 0;
		if (p1 == null)
			return 1;
		if (p2 == null)
			return -1;
		if (p1.dateTime < p2.dateTime)
			return -1;
		else if (p1.dateTime > p2.dateTime)
			return 1;
		return 0
	}
}
}
