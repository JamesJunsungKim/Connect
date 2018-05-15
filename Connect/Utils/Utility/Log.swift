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
    case error = "[Error ‼️]"
    case info = "[Info ℹ️]"
    case debug = "[Debug 🔦]"
    case verbose = "[Verbose 🔬]"
    case warning = "[Warning ⚠️]"
    case severe = "[Severe 🔥]"
}

func enterMemoryLog(type: AnyClass) {
    let newEntry = NSStringFromClass(type).components(separatedBy: ".")[1]
    memoryArray.append(newEntry)
    let sum = reduce(array: memoryArray)
    logInfo("New entry in Memery \nnew:\(newEntry)\n"+sum+"\n")
}

func leaveMomeryLog(type:AnyClass) {
    let deletedEntry = NSStringFromClass(type).components(separatedBy: ".")[1]
    guard let index = memoryArray.index(of: deletedEntry) else {return}
    memoryArray.remove(at: index)
    let sum = reduce(array: memoryArray)
    logInfo("Instance removed from memory \ndeleted: \(deletedEntry)\n"+sum+"\n")
}

private func reduce(array: [String])->String {
    let sum = array.reduce("") {$0+"\n\($1)"}
    return sum
}

func logDebug(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.debug, fileName: fileName, line: line, column: column, funcName: funcName)
}

func logInfo(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.info, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logError(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.error, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logVerbose(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.verbose, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logWarning(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.warning, fileName: fileName, line: line, column: column, funcName: funcName)
}
func logSevere(_ message: String, fileName: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
    capturingLog(message, event: LogEvent.severe, fileName: fileName, line: line, column: column, funcName: funcName)
}

fileprivate func capturingLog(_ message: String, event: LogEvent, fileName: String, line: Int, column: Int, funcName: String) {
    let date = Date().format(with: "yyyy-MM-dd hh:mm:ss.SSS")
    let fileName = sourceFileName(fileName)
    
    let mainMessage = "\(event.rawValue)[\(fileName)][\(line):\(column)] \(funcName) \(message)"
    let localMsg = "\(date) \(mainMessage)"
    //#if TARGET_OS_SIMULATOR
    print(localMsg)
    //#else
    // CFShow(localMsg as CFTypeRef)
    //#endif
}

fileprivate func sourceFileName(_ filePath: String) -> String {
    let component = filePath.components(separatedBy: "/")
    return component.isEmpty ? "" : component.last!
}

