//
//  FileStorage.swift
//  PokeMaster
//
//  Created by 郝振壹 on 2021/11/16.
//  Copyright © 2021 OneV's Den. All rights reserved.
//

import Foundation

@propertyWrapper
struct FileStorage<T: Codable> {
    var value: T?
    let directory: FileManager.SearchPathDirectory
    
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory, fileName: String) {
        self.directory = directory
        self.fileName = fileName
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            if let value = newValue {
                try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
            } else {
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
        get {
            value
        }
    }
}

@propertyWrapper
struct UserDefault<T> {
    var value: T
    var key: String
    
    init(key: String, defalutValue: T) {
        self.key = key
        if let v = UserDefaults.standard.object(forKey: key) as? T {
            value = v
        } else {
            value = defalutValue
        }
    }
    
    var wrappedValue: T {
        set {
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
        }
        get {
            value
        }
    }
}
