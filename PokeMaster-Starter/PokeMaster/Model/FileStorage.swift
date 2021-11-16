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
    var value: T?
    var key: String
    
    init(key: String) {
        self.key = key
        if T.self == String.self {
            value = UserDefaults.standard.string(forKey: key) as! T?
        } else if T.self == Int.self {
            value = UserDefaults.standard.integer(forKey: key) as! T?
        } else if T.self == Bool.self {
            value = UserDefaults.standard.bool(forKey: key) as! T?
        } else {
            value = UserDefaults.standard.object(forKey: key) as! T?
        }
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
        }
        get {
            value
        }
    }
}
