/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
import com.qiwi.marketing.project.visit.Visit;

public class ContainsEntryConstraint implements IConstraint {

	private var _entryToContain:String;

	public function ContainsEntryConstraint(entryToContain:String) {
		_entryToContain = entryToContain;
	}

	public function check(visit:Visit):Boolean {
		return visit.containsEntry(_entryToContain)
	}
}
}
