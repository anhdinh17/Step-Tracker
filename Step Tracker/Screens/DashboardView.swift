//
//  DashboardView.swift
//  Step Tracker
//
//  Created by Anh Dinh on 6/24/24.
//

import SwiftUI
import Charts

enum HealthMetricContext: CaseIterable, Identifiable {
    // For usage of ForEach in Picker
    var id: Self {
        return self
    }
    
    case steps, weight
    
    var title: String {
        switch self {
        case .steps:
            return "Steps"
        case .weight:
            return "Weight"
        }
    }
}

struct DashboardView: View {
    // We use @AppStorage for UserDefault for the first time launching this screen.
    @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
    
    @Environment(HealthkitManager.self) private var hkManager
    
    @State private var isShowingPermissionPrimingSheet = false
    @State var selectedStat: HealthMetricContext = .steps
    var isSteps: Bool { selectedStat == .steps }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Segmented Controll
                    // When tapping on 1 segment, "selectedStat" will have new enum value
                    Picker("Selected Stat", selection: $selectedStat) {
                        // Loop through all cases of enum
                        ForEach(HealthMetricContext.allCases) { metric in
                            Text(metric.title)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    StepBarChart(selectedStat: selectedStat,
                                 chartData: hkManager.stepData)
                    
                    StepPieChart(chartData: ChartMath.averageWeekdayCount(for: hkManager.stepData))
                }
            }
            .padding()
            .task {
                await hkManager.fetchStepCount()
                ChartMath.averageWeekdayCount(for: hkManager.stepData)
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: HealthMetricContext.self) { metric in
                // metric is an enum
                HealthDataListView(metric: metric)
            }
            .sheet(isPresented: $isShowingPermissionPrimingSheet,
                   onDismiss: {
                // fetch health data
            },
                   content: {
                HealthkitPermissionPrimingView(hasSeen: $hasSeenPermissionPriming)
            })
        }
        // We will have tint color even we navigate to other view
        .tint(isSteps ? .pink : .indigo)
    }
}

#Preview {
    DashboardView()
        .environment(HealthkitManager())
}
