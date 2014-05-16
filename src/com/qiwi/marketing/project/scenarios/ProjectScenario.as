/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios {
import com.qiwi.marketing.project.scenarios.constraints.IConstraint;
import com.qiwi.marketing.project.visit.Visit;

public class ProjectScenario extends ProjectFlow {

	private var _constraints:Vector.<IConstraint>;
	public var source:XML;

	public function ProjectScenario(name:String, entries:String, constraints:Vector.<IConstraint>) {
		super(name, entries);
		_constraints = constraints
	}

	public function check(visit:Visit):Boolean {
		return _constraints.every(function (item:IConstraint, index:int, array:Vector.<IConstraint>):Boolean {
			return item.check(visit);
		})
	}
}
}
