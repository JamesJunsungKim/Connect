//
//  ClassyCache.swift
//  Connect
//
//  Created by James Kim on 6/30/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import Foundation


class ClassyCache {
    
    init() {
        initialSetup()
    }
    
    // MARK: - Public
    public func cacheStyleNodes(_ styleNodes: [AnyObject], fromPath path: String, variables:[AnyHashable:Any]) {
        guard !ProcessInfo.processInfo.isRunningTests, let bcasPath = bcasPath(path, variable: variables) else {return}
        
        delay(5) {
            let data = NSKeyedArchiver.archivedData(withRootObject: styleNodes)
            let bcasFolderPath = (bcasPath as NSString).deletingLastPathComponent
            
            guard ((try? FileManager.default.createDirectory(atPath: bcasFolderPath, withIntermediateDirectories: true, attributes: .none)) != nil) else {
                logError("Cannot create directory for bcas: " + bcasPath)
                return
            }
            
            guard ((try? data.write(to: URL(fileURLWithPath: bcasPath), options: .atomicWrite)) != nil) else {
                logError("bcas cannot be saved to: " + bcasPath)
                return
            }
            logInfo("Saved bcas to : \(bcasPath) \(data.count)")
        }
    }
    
    public func cachedStyleNodess(fromCASPath path: String, withVariables variables: [AnyHashable:Any])->[Any]? {
        guard let bcasPath = bcasPath(path, variable: variables) else {return .none}
        
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: bcasPath), let fileSize = attributes[FileAttributeKey.size] as? Int, fileSize != 0 else {
            logError("bcas file not found")
            return .none
        }
        
        logInfo("loading bcas file")
        
        if let array = NSKeyedUnarchiver.unarchiveObject(withFile: bcasPath) as? [Any] {
            return array
        } else {
            logError("bcas cannot be decoded")
            // we need to clean up the archive since we cannot decode it
            _ = try? FileManager.default.removeItem(atPath: bcasPath)
            return .none
        }
    }
    
    // MARK: - Static
    static let currentAppBuild: String = {
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return version
        } else {
            return "999998"
        }
    }()
    
    static var lastAppBuild: String {
        get {
            return UserDefaults.retrieveValue(forKey: .lastAppBuildKey, defaultValue: "")
        }
        set {
            UserDefaults.store(object: newValue, forKey: .lastAppBuildKey)
        }
    }
    
    static let casDirectory: NSString = {
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString
        return cachePath.appendingPathComponent("cas") as NSString
    }()
    
    
    // MARK: - Fileprivate
    fileprivate func initialSetup() {
        let currentAppBuild = type(of: self).currentAppBuild
        let lastAppBuild = type(of: self).lastAppBuild
        let directory = type(of: self).casDirectory as String
        
        if currentAppBuild != lastAppBuild {
            do {
                try FileManager.default.removeItem(atPath: directory)
            } catch let error {
                logError("Cannot clear CAS cache: \(error)")
                
            }
            type(of: self).lastAppBuild = currentAppBuild
        }
        
        if !FileManager.default.fileExists(atPath: directory) {
            do {
                try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true, attributes: .none)
            } catch let error {
                logError("Cannot create CAS cache: \(error)")
            }
        }
    }
    
    fileprivate func bcasPath(_ casPath: String, variable: [AnyHashable:Any]) -> String? {
        let data = variable.cn_sortedKeyValues()
        guard let fileData = NSMutableData(contentsOfFile: casPath), let variableJSON = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) else {return .none}
        
        fileData.append(variableJSON)
        let casHash = fileData.cn_MD5Hash()
        
        let casName = ((casPath as NSString).lastPathComponent as NSString).deletingPathExtension
        let bcasPath = type(of: self).casDirectory.appendingPathComponent("\(casName)-\(casHash).bcas")
        return bcasPath
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
   
}
