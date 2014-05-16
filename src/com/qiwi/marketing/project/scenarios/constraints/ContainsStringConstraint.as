/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
import com.qiwi.marketing.project.visit.Visit;

public class ContainsStringConstraint implements IConstraint {

	private var _valueToContain:String;

	public function ContainsStringConstraint(valueToContain:String) {
		_valueToContain = valueToContain;
	}

	public function check(visit:Visit):Boolean {
		return visit.path.pathString.indexOf(_valueToContain) != -1;
	}
}
}
