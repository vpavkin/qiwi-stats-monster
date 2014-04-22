/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit.path {
import com.qiwi.marketing.data.importing.PathStringParser;
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.visit.Visit;

import mx.collections.ArrayCollection;

[Bindable]
public class Path {

	public var steps:ArrayCollection; //of PathStep
	public var visit:Visit;
	public var project:Project;

	public function Path(pathString:String, project:Project) {
		this.project = project;
		this.steps = PathStringParser.parsePathString(pathString, project);
	}

}
}
