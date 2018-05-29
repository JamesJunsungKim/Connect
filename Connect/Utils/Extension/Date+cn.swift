//
//  Date.swift
//  Connect
//
//  Created by montapinunt Pimonta on 5/7/18.
//  Copyright © 2018 James Kim. All rights reserved.
//
import Foundation
import DateToolsSwift

extension Date {
    public var dayUTC: Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.component(.day, from: self)
    }
    
    public var monthUTC: Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.component(.month, from: self)
    }
    
    public var yearUTC: Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.component(.year, from: self)
    }
    
    public var hourUTC: Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.component(.hour, from: self)
    }
    
    public var minuteUTC: Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.component(.minute, from: self)
    }
    
    public var secondUTC: Int {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return calendar.component(.second, from: self)
    }
    
    // MARK: - Static
    public static func initWith(_ hour: Int, minute: Int) -> Date {
        return Date(year: 0, month: 0, day: 0, hour: hour, minute: minute, second: 0)
    }
    
    public static func dateWithHour(_ hour: Int, minute: Int) -> Date {
        return dateWithHourHelper(hour, minute: minute)
    }
    
    fileprivate static func dateWithHourHelper<Template>(_ hour: Int, minute: Int) -> Template {
        let date = Date(year: 0, month: 0, day: 0, hour: hour, minute: minute, second: 0)
        return date as! Template
    }
    
    static func ConvertToString(_ target: String) -> Date {
        let formatter = DateFormatter()
    
        if target.contains("T") {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        } else {
            formatter.dateFormat = "yyyy-MM-dd"
        }
        
        formatter.locale = Date.getUTCLocale()
        formatter.timeZone = Date.getUTCTimeZone()
        return formatter.date(from: target)!
    }
    
    static func getUTCLocale() -> Locale {
        return Locale(identifier: "en_US_POSIX")
    }
    
    static func getUTCTimeZone() -> TimeZone {
        return TimeZone(abbreviation: "UTC")!
    }
    
    // MARK:- Format Date to UTC
    public func toYearToDateStringUTC() -> String {
        return self.format(with: "yyyy-MM-dd", timeZone: Date.getUTCTimeZone(), locale: Date.getUTCLocale())
    }
    
    public func toYearToMillisecondStringUTC() -> String {
        return self.format(with: "yyyy-MM-dd'T'HH:mm:ss", timeZone: Date.getUTCTimeZone(), locale: Date.getUTCLocale())
    }
    
    public func toHourToMinStringUTC() -> String {
        return self.format(with: "HH:mm", timeZone: Date.getUTCTimeZone(), locale: Date.getUTCLocale())
    }
    
    
    public func addYear(value: Int)->Date{
        return cal.date(byAdding: .year, value: value, to: self)!
    }
    public func addMonth(value: Int)->Date{
        return cal.date(byAdding: .month, value: value, to: self)!
    }
    public func addDay(value: Int)->Date{
        return cal.date(byAdding: .day, value: value, to: self)!
    }
    
    // MARK: -Filepriavte
    fileprivate var cal: Calendar {
        return Calendar.current
    }
}










