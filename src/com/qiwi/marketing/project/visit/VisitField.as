/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.visit {
import com.qiwi.marketing.project.ProjectField;

[Bindable]
public dynamic class VisitField {

	public var field:ProjectField;
	public var value:String;

	public function VisitField(field:ProjectField, value:String) {
		this.field = field;
		this.value = value;
	}
}
}
