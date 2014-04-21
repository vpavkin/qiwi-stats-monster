/**
 * Created by Vladimir on 20.04.2014.
 */
package com.qiwi.marketing.data.storage {
import com.qiwi.marketing.project.Project;
import com.qiwi.marketing.project.visit.DayOfVisits;

import flash.filesystem.File;

public class VisitsStorageManager {

    private static var _instance:VisitsStorageManager;

    public static function get instance():VisitsStorageManager {
        if (!_instance)
            _instance = new VisitsStorageManager();
        return _instance;
    }

    private var _dataDirectory:File;

    public function VisitsStorageManager() {
        _dataDirectory = File.documentsDirectory.resolvePath("Marketing" + "/data");
        if (!_dataDirectory.exists)
            _dataDirectory.createDirectory();
    }

    public function loadProjectVisitsHeaders(project:Project):void {
        var pd:File = _dataDirectory.resolvePath(project.number.toString());
        if (!pd.exists)
            pd.createDirectory();
        var pFiles:Array = pd.getDirectoryListing();
        for each (var pf:File in pFiles) {
            if (pf.isDirectory || !/^\d\d.\d\d\.\d\d\d\d\.st$/.test(pf.name))
                continue;
            project.visits.addItem(VisitsStorageManager.loadHeader(project, pf));
        }
    }

    public static function loadHeader(project:Project, file:File):DayOfVisits {
        return new DayOfVisits(project, fileNameToDate(file.name))
    }

    private static function fileNameToDate(name:String):Date {
        var dmy:Array = name.split(".");
        return new Date(dmy[2], Number(dmy[1]) - 1, dmy[0]);
    }

}
}
