//
//  Step_TrackerApp.swift
//  Step Tracker
//
//  Created by Anh Dinh on 6/24/24.
//

import SwiftUI

@main
struct Step_TrackerApp: App {
    let hkManager = HealthkitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(hkManager) // enject to root view on launch
        }
    }
}
