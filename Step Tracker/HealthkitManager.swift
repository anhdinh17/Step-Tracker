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
    
    /// This func creates mock data to Health App. We only use this func once.
    /// We send data of steps and weight for the last 28 days to Health App.
    /// weightQuantity is in the form of downtrend
//    func addSimulatorData() async {
//        var mockSamples: [HKQuantitySample] = []
//        
//        for i in 0..<28 {
//            let stepQuantitiy = HKQuantity(unit: .count(), doubleValue: .random(in: 4_000...20_000))
//            let weightQuantity = HKQuantity(unit: .pound(), doubleValue: .random(in: (160 + Double(i/3)...165 + Double(i/3))))
//            
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .second, value: 1, to: startDate)!
//            
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount),
//                                              quantity: stepQuantitiy,
//                                              start: startDate,
//                                              end: endDate)
//            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass),
//                                              quantity: weightQuantity,
//                                              start: startDate,
//                                              end: endDate)
//            
//            mockSamples.append(stepSample)
//            mockSamples.append(weightSample)
//        }
//        
//        try! await store.save(mockSamples)
//        print("✅ Mocking Data sent to Health App")
//    }
}
