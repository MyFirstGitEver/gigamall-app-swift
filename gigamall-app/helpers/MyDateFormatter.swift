//
//  DateFormatter.swift
//  messenger-lite
//
//  Created by FVFH4069Q6L7 on 09/08/2023.
//

import Foundation

class MyDateFormatter {
    static fileprivate var aDay = 24 * 3600.0
    static fileprivate var aWeek = aDay * 7
    static fileprivate var aMonth = aWeek * 4
    
    static func diffFromNow(date : Date) -> String {
        let nowInSeconds = Date.now.timeIntervalSince1970
        let timePoint = date.timeIntervalSince1970
        let diff = nowInSeconds - timePoint
        
        if diff <= aWeek {
            return "\(Int(diff / aDay))d"
        }
        else if diff <= aMonth {
            return "\(Int(diff / aWeek))w"
        }
        else {
            return "\(Int(diff / aMonth)) month"
        }
    }
}
