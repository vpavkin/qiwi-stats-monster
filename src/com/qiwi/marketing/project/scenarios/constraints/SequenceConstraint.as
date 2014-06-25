/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
import com.qiwi.marketing.project.entry.EntryHelper;
import com.qiwi.marketing.project.visit.Visit;
import com.qiwi.marketing.project.visit.path.PathStep;

public class SequenceConstraint implements IConstraint {

	private var _start:String;
	private var _thenOnly:Array;
	private var _allowsNonPageEntries:Boolean;

	public function SequenceConstraint(start:String, thenOnly:String, allowsNonPageEntries:Boolean) {
		_start = start;
		_allowsNonPageEntries = allowsNonPageEntries;
		_thenOnly = thenOnly.split("|");
	}

	public function check(visit:Visit):Boolean {
		for (var i:int = 0; i < visit.path.steps.length; i++) {
			var step:PathStep = visit.path.steps[i];
			if (step.entry == _start) {
				if (checkSequence(visit, i))
					return true;
			}
		}
		return false;
	}

	private function checkSequence(visit:Visit, fromIndex:int):Boolean {
		for (var i:int = fromIndex + 1; i < visit.path.steps.length; i++) {
			var step:PathStep = visit.path.steps[i];
			if (_allowsNonPageEntries && !EntryHelper.isPage(step.entry))
				continue;
			if (_thenOnly.indexOf(step.entry) == -1) {
				return false;
			}
		}
		return true;
	}
}
}
