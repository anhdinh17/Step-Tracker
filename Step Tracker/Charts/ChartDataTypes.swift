//
//  ChartDataTypes.swift
//  Step Tracker
//
//  Created by Anh Dinh on 7/5/24.
//

import Foundation

struct WeekDayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
