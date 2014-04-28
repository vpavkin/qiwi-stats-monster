/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit.path {
import com.qiwi.marketing.data.importing.PathStringParser;
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.visit.Visit;

public class Path {

	public var steps:Vector.<PathStep>;
	public var visit:Visit;
	public var pathString:String;

	public function Path(pathString:String, project:Project, steps:Vector.<PathStep> = null) {
		this.pathString = pathString;
		this.steps = steps ? steps : PathStringParser.parsePathString(pathString, project);
	}

}
}
