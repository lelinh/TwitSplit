//
//  NSDateExtension.swift
//  TwitSplit
//
//  Created by LinhLe on 4/11/18.
//  Copyright © 2018 LinhLe. All rights reserved.
//

import Foundation

extension Date {
    func timeAgo(date: Date = Date(timeIntervalSinceNow: 0)) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: self, to: date);
        
        let min = difference.minute ?? 0
        let hour = difference.hour ?? 0
        let day = difference.day ?? 0
        
        if day > 0 {
            return "\(day) day ago"
        }
        
        if hour > 0 {
            return "\(hour)h"
        }
        
        if min > 1 {
            return "\(min)m"
        }else {
            return "1m"
        }
        
    }
}
