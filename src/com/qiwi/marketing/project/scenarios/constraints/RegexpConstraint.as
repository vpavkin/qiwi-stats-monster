/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
import com.qiwi.marketing.project.visit.Visit;

public class RegexpConstraint implements IConstraint {

	private var _regexpToMatch:RegExp;

	public function RegexpConstraint(regexp:RegExp) {
		_regexpToMatch = regexp;
	}

	public function check(visit:Visit):Boolean {
		return _regexpToMatch.test(visit.path.pathString)
	}
}
}
