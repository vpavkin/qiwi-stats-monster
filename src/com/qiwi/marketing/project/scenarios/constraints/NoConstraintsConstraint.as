/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
import com.qiwi.marketing.project.visit.Visit;

public class NoConstraintsConstraint implements IConstraint {

	public function NoConstraintsConstraint() {
	}

	public function check(visit:Visit):Boolean {
		return true;
	}
}
}
