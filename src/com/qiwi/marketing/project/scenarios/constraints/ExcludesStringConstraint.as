/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
import com.qiwi.marketing.project.visit.Visit;

public class ExcludesStringConstraint implements IConstraint {

	private var _valueToExclude:String;

	public function ExcludesStringConstraint(valueToExclude:String) {
		_valueToExclude = valueToExclude;
	}

	public function check(visit:Visit):Boolean {
		return visit.path.pathString.indexOf(_valueToExclude) == -1;
	}
}
}
