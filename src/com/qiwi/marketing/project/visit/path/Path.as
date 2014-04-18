/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit.path {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.visit.Visit;

import mx.collections.ArrayCollection;

[Bindable]
public class Path {

	public var steps:ArrayCollection; //of PathStep
	public var visit:Visit;

	public function Path(pathString:String, project:Project) {

	}
}
}
