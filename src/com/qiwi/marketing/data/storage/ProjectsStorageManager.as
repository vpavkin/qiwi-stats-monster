/**
 * Created by Vladimir on 20.04.2014.
 */
package com.qiwi.marketing.data.storage {
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import mx.collections.ArrayCollection;

public class ProjectsStorageManager {

    private static var _instance:ProjectsStorageManager;

    public static function get instance():ProjectsStorageManager {
        if (!_instance)
            _instance = new ProjectsStorageManager();
        return _instance;
    }

    private var _dataDirectory:File;
    private var _projectsListFile:File;


    public function ProjectsStorageManager() {
        _dataDirectory = File.documentsDirectory.resolvePath("Marketing" + "/data");
        if (!_dataDirectory.exists)
            _dataDirectory.createDirectory();

        _projectsListFile = _dataDirectory.resolvePath("list.mgd");
    }

    public function loadProjectsList():ArrayCollection {
        if (!_projectsListFile.exists)
            return initProjectsList();

        var fileStream:FileStream = new FileStream();
        fileStream.open(_projectsListFile, FileMode.READ);
        var res:ArrayCollection = StorageSerializer.serializeProjects(fileStream.readObject());
        fileStream.close();
        return res;
    }

    private function initProjectsList():ArrayCollection {
        var projectsList:ArrayCollection = new ArrayCollection([]);
        saveProjectsList(projectsList);
        return projectsList;
    }

    private function saveProjectsList(projectsList:ArrayCollection):void {
        var fileStream:FileStream = new FileStream();
        fileStream.open(_projectsListFile, FileMode.WRITE);
        fileStream.writeObject(projectsList);
        fileStream.close();
    }

    public function updateProjectsList(projectsList:ArrayCollection):void {
        saveProjectsList(projectsList);
    }
}
}
