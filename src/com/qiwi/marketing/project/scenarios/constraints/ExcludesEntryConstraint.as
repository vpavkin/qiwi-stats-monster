/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
import com.qiwi.marketing.project.visit.Visit;

public class ExcludesEntryConstraint implements IConstraint {

	private var _entryToExclude:String;

	public function ExcludesEntryConstraint(entryToExclude:String) {
		_entryToExclude = entryToExclude;
	}

	public function check(visit:Visit):Boolean {
		return !visit.containsEntry(_entryToExclude)
	}
}
}
