//
//  ChartMath.swift
//  Step Tracker
//
//  Created by Anh Dinh on 7/5/24.
//

import Foundation
import Algorithms
struct ChartMath {
    
    /// This func takes in an array of data and returns an array of elements
    /// that each element is a weekday and has an average value associated with it.
    static func averageWeekdayCount(for metric: [HealthMetric]) -> [WeekDayChartData] {
        // Sort array based on .weekdayInt
        // Array được sắp xếp dựa trên .weekdayInt
        // [Mon, Mon, Mon, Tue, Tue, Tue, Wed, Wed, Wed]...
        let sortedByWeekday = metric.sorted { $0.date.weekdayInt < $1.date.weekdayInt }
//        print("📅sortedByWeekday: \n\(sortedByWeekday)")
        
        // Use .chunked to group same element.
        // This array will look like this [[Mon,Mon, Mon], [Tue, Tue, Tue], [Wed, Wed, Wed]]
        let weekdayArray = sortedByWeekday.chunked {$0.date.weekdayInt == $1.date.weekdayInt}
//        print("📅weekdayArray: \n\(weekdayArray)")
        
        var weekdayChartData: [WeekDayChartData] = []
        for array in weekdayArray {
            guard let firstValue = array.first else {continue}
            let total = array.reduce(0){$0 + $1.value}
            let average = total / Double(array.count)
            weekdayChartData.append(.init(date: firstValue.date, value: average))
        }

        for dayOfWeek in weekdayChartData {
            print("📝dayOfWeek: \(dayOfWeek.date.weekdayInt) Avg Value: \(dayOfWeek.value)")
        }
        
        return weekdayChartData
    }
}
