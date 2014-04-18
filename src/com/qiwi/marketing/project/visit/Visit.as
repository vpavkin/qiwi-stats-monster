/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.ProjectVersion;
import com.qiwi.marketing.project.visit.path.Path;

import mx.collections.ArrayCollection;

public class Visit {

	public var txnId:int;
	public var txnDate:Date;
	public var trmId:int;
	public var project:Project;
	[Bindable]
	public var version:ProjectVersion;
	[Bindable]
	public var path:Path;
	[Bindable]
	public var fields:ArrayCollection; //of VisitField


	public function Visit(txnId:int, txnDate:Date, trmId:int, project:Project, version:ProjectVersion, path:Path, fields:ArrayCollection) {
		this.txnId = txnId;
		this.txnDate = txnDate;
		this.trmId = trmId;
		this.project = project;
		this.version = version;
		this.path = path;
		this.fields = fields;

		if (path)
			path.visit = this;
	}
}
}
