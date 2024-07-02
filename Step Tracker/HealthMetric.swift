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
}
