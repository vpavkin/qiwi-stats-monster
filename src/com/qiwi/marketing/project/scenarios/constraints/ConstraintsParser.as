/**
 *
 * @author v.pavkin
 */
package com.qiwi.marketing.project.scenarios.constraints {
public class ConstraintsParser {


	public static function parse(xml:XML):IConstraint {
		switch (xml.name().localName) {
			case "contains":
				switch (xml.attributes()[0].name().localName) {
					case "entry":
						return new ContainsEntryConstraint(xml.@entry);
					case "string":
						return new ContainsStringConstraint(xml.@string);
				}
				break;
		}
		return null;
	}

	public static function parseList(scenarioXML:XML):Vector.<IConstraint> {
		var res:Vector.<IConstraint> = new Vector.<IConstraint>();
		for each (var cXML:XML in scenarioXML.children()) {
			res.push(ConstraintsParser.parse(cXML));
		}
		return res;
	}
}
}
