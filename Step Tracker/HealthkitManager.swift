//
//  HealthkitManager.swift
//  Step Tracker
//
//  Created by Anh Dinh on 6/27/24.
//

import Foundation
import HealthKit
import SwiftUI
import Observation // For new @ObservableObject as of the time of this app

@Observable class HealthkitManager {
    // We'll see what this one does throughout the app.
    let store = HKHealthStore()
    
    // Type of data we're gonna read from and write to Health App.
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
