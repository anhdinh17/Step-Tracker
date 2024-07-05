//
//  HealthMetric.swift
//  Step Tracker
//
//  Created by Anh Dinh on 7/2/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
    
    /** ---NOTE---
     - Mock data to use for DashboardView so we can see charts in preview instead of running simulator every time
     */
    static var mockData: [HealthMetric] {
        var array: [HealthMetric] = []
        for i in 0..<28 {
            let metric = HealthMetric(date: Calendar.current.date(byAdding: .day, value: -i, to: .now)!,
                                      value: .random(in: 4_000...10_000))
            array.append(metric)
        }
        return array
    }
}
