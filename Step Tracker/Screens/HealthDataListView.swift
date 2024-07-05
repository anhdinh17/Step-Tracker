//
//  HealthDataListView.swift
//  Step Tracker
//
//  Created by Anh Dinh on 6/25/24.
//

import SwiftUI

struct HealthDataListView: View {
    @State var isShowingAddData = false
    @State private var addDataDate: Date = .now // = Date() is same
    @State private var valueToAdd: String = ""
    var metric: HealthMetricContext
    
    var body: some View {
        List(0..<28) { i in
            HStack {
                // Make Date to be Jun 25, 2024 form
                Text(Date(), format: .dateTime.month().day().year())
               
                Spacer()
                
                Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0 : 2)))
            }
        }
        .navigationTitle(metric.title)
        .toolbar{
            Button {
                isShowingAddData = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isShowingAddData, content: {
            addDataView
        })
    }
    
    /** ---NOTE---
     - Create a View
     - Normally we have to create a separate struct, but this pop-up view is simple and is used only for this screen so we don't have to do a separate file.
     - Besides, with this way, we don't have to pass data, we can use data from above.
     */
    var addDataView: some View {
        NavigationStack {
            Form {
                DatePicker("Date",
                           selection: $addDataDate,
                           displayedComponents: .date)
                HStack {
                    Text(metric.title)
                    Spacer()
                    TextField("Value", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 140)
                        .keyboardType(metric == .steps ? .numberPad : .decimalPad)
                }
            }
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Dismiss"){
                        isShowingAddData = false
                        print("Selected Date = \(self.addDataDate)")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Data"){
                        // Code later
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HealthDataListView(metric: .steps)
    }
}
