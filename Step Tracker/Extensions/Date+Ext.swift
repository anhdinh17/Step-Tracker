//
//  Date+Ext.swift
//  Step Tracker
//
//  Created by Anh Dinh on 7/5/24.
//

import Foundation

extension Date {
    // This returns a number for weekday.
    // if the date is Sun, it returns 1 and so on.
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    // If a date is Monday, this var will return "Monday"
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
}
