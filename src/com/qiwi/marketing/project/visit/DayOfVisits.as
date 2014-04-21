/**
 * Created by Vladimir on 20.04.2014.
 */
package com.qiwi.marketing.project.visit {
import com.qiwi.marketing.project.Project;

import mx.collections.ArrayCollection;

public class DayOfVisits {

    public var date:Date;
    public var project:Project;
    public var visits:ArrayCollection;
    public var isLoaded:Boolean = false;


    public function DayOfVisits(project:Project, date:Date, visits:ArrayCollection = null) {
        this.project = project;
        this.date = date;
        this.visits = visits ? visits : new ArrayCollection();
    }
}
}
