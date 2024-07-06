//
//  StepPieChart.swift
//  Step Tracker
//
//  Created by Anh Dinh on 7/6/24.
//

import SwiftUI
import Charts

struct StepPieChart: View {
    var chartData: [WeekDayChartData]
    
    var body: some View {
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
            
            Chart {
                ForEach(chartData) { weekDay in
                    // weekDay is each element of array
                    SectorMark(angle: .value("Average Steps", weekDay.value),
                               innerRadius: .ratio(0.6),
                               angularInset: 1)
                    .foregroundStyle(.pink)
                    .cornerRadius(6)
                }
            }
            .frame(height: 240)
        }
        .padding()
        .background (RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
    }
}

#Preview {
    StepPieChart(chartData: ChartMath.averageWeekdayCount(for: HealthMetric.mockData))
}
