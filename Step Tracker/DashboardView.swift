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
    @State var rawSelectedDate: Date? // if nothing selected, it's nil
    var isSteps: Bool { selectedStat == .steps }
    var avgStepCount: Double {
        guard !hkManager.stepData.isEmpty else {return 0}
        let totalSteps = hkManager.stepData.reduce(0) {$0 + $1.value}
        return totalSteps/Double(hkManager.stepData.count)
    }
    
    var selectedHealthMetric: HealthMetric? {
        // Check if rawSelectedDate is not Nil
        guard let rawSelectedDate else {return nil}
        let selectedMetric = hkManager.stepData.first {
            // Check if the date of element of stepData array match the day we select on chart
            Calendar.current.isDate(rawSelectedDate, inSameDayAs: $0.date)
        }
        return selectedMetric
    }
    
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
                    
                    VStack(alignment: .leading) {
                        // NavigationLink takes in a value of enum
                        NavigationLink(value: selectedStat) {
                            // Whole HStack is Navigation Link
                            HStack {
                                VStack {
                                    Label("Steps", systemImage: "figure.walk")
                                        .font(.title3.bold())
                                        .foregroundStyle(.pink)
                                    
                                    Text("Avg: \(avgStepCount) steps")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            .padding(.bottom, 10)
                        }
                        .foregroundStyle(.secondary)
                        
                        Chart {
                            // Theo thứ tự thì thằng nào trước thì ở dưới
                            
                            // Check if selectedHealthMetric is not Nil
                            // Then show a rule mark
                            if let selectedHealthMetric {
                                // Show a rulemark over the bar when we select a bar
                                RuleMark(x: .value("Selected Metric", selectedHealthMetric.date, unit: .day))
                                    .foregroundStyle(Color.secondary.opacity(0.3))
                                    .offset(y: -10)
                                    
                                    // show annotation above the rule mark
                                    .annotation(position: .top,
                                                spacing: 0,
                                                overflowResolution: .init(x: .fit(to: .chart), y: .disabled)){
                                        annotationView
                                    }
                            }
                            
                            // Average line
                            RuleMark(y: .value("Average", avgStepCount))
                                .foregroundStyle(Color.secondary)
                                .lineStyle(.init(lineWidth: 1, dash: [5]))
                            
                            ForEach (hkManager.stepData) { step in
                                // step is each element of data array
                                BarMark(
                                    x: .value("Date", step.date, unit: .day),
                                    y: .value("Steps", step.value)
                                )
                                .foregroundStyle(Color.pink.gradient)
                                // Nếu ko select thằng bar nào hết thì opacity = 1
                                // Hoặc element có date = date của selectedHealthMetric.date thì opacity = 1
                                // còn lại là 0.3
                                //.opacity(rawSelectedDate == nil || step.date == selectedHealthMetric.date ? 1.0 : 0.3)
                            }
                        }
                        .frame(height: 150)
                        
                        // Select a bar
                        // -> rawSelectedDate sẽ có date = date trên trục X
                        // đồng thời rule mark trên bar mà mình select sẽ trigger cái đống code của nó
                        // -> selectedHealthMetric sẽ đươc calculate dựa trên rawSelectedDate
                        .chartXSelection(value: $rawSelectedDate)
                        
                        // Customize X axis
                        .chartXAxis {
                            // Custom format of date
                            AxisMarks {
                                AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
                            }
                        }
                        .chartYAxis{
                            AxisMarks { value in
                                // Add grid line to chart
                                AxisGridLine()
                                    .foregroundStyle(Color.secondary.opacity(0.3))
                                
                                // Custsom format of number of steps on Y-axis
                                AxisValueLabel((value.as(Double.self) ?? 0).formatted(.number.notation(.compactName)))
                            }
                        }
                    }
                    .padding()
                    .background (RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Label("Averages", systemImage: "calendar")
                                .font(.title3.bold())
                                .foregroundStyle(.pink)
                            
                            Text("Last 28 days")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.bottom, 10)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.secondary)
                            .frame(height: 240)
                    }
                    .padding()
                    .background (RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
                }
            }
            .padding()
            .task {
                isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
                await hkManager.fetchWeights()
                await hkManager.fetchStepCount()
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
    
    // Annotation View that shows value of step when we select a bar
    var annotationView: some View {
        VStack(alignment: .leading) {
            Text(selectedHealthMetric?.date ?? .now, format: .dateTime.weekday(.abbreviated).month(.abbreviated).day())
                .font(.footnote.bold())
                .foregroundStyle(.secondary)
            
            Text(selectedHealthMetric?.value ?? 0, format: .number.precision(.fractionLength(0)))
                .fontWeight(.heavy)
                .foregroundStyle(.pink)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .secondary.opacity(0.3), radius: 2, x: 2, y: 2)
        )
    }
}

#Preview {
    DashboardView()
        .environment(HealthkitManager())
}
