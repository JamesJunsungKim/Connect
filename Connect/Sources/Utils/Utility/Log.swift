//
//  Log.swift
//  Connect
//
//  Created by James Kim on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//

import UIKit
import DateToolsSwift

enum LogEvent: String {
    case error = "Error:"
    case info = "Info:"
    case debug = "Debug:"
    case verbose = "Verbose:"
    case warning = "Warning:"
    case severe = "Severe:"
}

func enterViewControllerMemoryLog(type: AnyClass) {
    let newEntry = nameFor(type: type)
    viewControllerMemoryArray.append(newEntry)
    _ = reduce(array: viewControllerMemoryArray)
    logInfo("New entry in Memery: \(newEntry)")
}

func leaveViewControllerMomeryLogSaveData(type:AnyClass) {
    let deletedEntry = nameFor(type: type)
    guard let index = viewControllerMemoryArray.index(of: deletedEntry) else {return}
    viewControllerMemoryArray.remove(at: index)
    _ = reduce(array: viewControllerMemoryArray)
    logInfo("Instance removed from memory: \(deletedEntry)")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.saveData_Temporaryfunc()
}

func enterReferenceDictionary(forType type: AnyClass, withUID uid: String?) {
    let newEntry = nameFor(type: type)
    let identifier = ObjectIdentifier.init(type).debugDescription
    var dict: [String:String?]!
    
    if referenceMemeoryDictionary.checkIfValueExists(forKey: newEntry) {
        dict = referenceMemeoryDictionary[newEntry]!
        dict[identifier] = uid
    } else {
        dict = [identifier:uid]
    }
    referenceMemeoryDictionary[newEntry] = dict
}

func leaveReferenceDictionary(forType type: AnyClass) {
    let deletedEntry = nameFor(type: type)
    let identifier = ObjectIdentifier.init(type).debugDescription
    if referenceMemeoryDictionary[deletedEntry] != nil {
        referenceMemeoryDictionary[deletedEntry]!.removeValue(forKey: identifier)
        if referenceMemeoryDictionary[deletedEntry]!.count == 0 {
            referenceMemeoryDictionary.removeValue(forKey: deletedEntry)
        }
    }
}

private func nameFor(type: AnyClass)-> String {
    return NSStringFromClass(type).components(separatedBy: ".")[1]
}


private func reduce(array: [String])->String {
    let sum = array.reduce("") {$0+"\n\($1)"}
    return sum
}

func logDebug(_ message: String?, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.debug, fileName: fileName, line: line, column: column, funcName: funcName)
}

func logInfo(_ message: String? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.info, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logError(_ message: String?, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.error, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logVerbose(_ message: String?, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.verbose, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logWarning(_ message: String? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.warning, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logSevere(_ message: String?, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.severe, fileName: fileName, line: line, column: column, funcName: funcName)
}

fileprivate func capturingLog(_ message: String?, event: LogEvent, fileName: String, line: Int, column: Int, funcName: String) {
    _ = Date().format(with: "yyyy-MM-dd hh:mm:ss.SSS")
    let fileName = sourceFileName(fileName)
    
    
    if message != nil {
        print("\n\(event.rawValue) on line \(line) in \(fileName) \n\(funcName) \ncontent: \(message!)")
    } else {
        print("\n\(event.rawValue) on line \(line) in \(fileName) \n\(funcName)")
    }
//    let localMsg = "\(date)\n\(mainMessage)"
//    #if TARGET_OS_SIMULATOR
//    #else
//    #endif
}

fileprivate func sourceFileName(_ filePath: String) -> String {
    let components = filePath.components(separatedBy: "/")
    let lastComponent = components.last.unwrapOrBlank()
    return lastComponent.components(separatedBy: ".").first.unwrapOrBlank()
}

