//
//  ContentView.swift
//  Step Tracker
//
//  Created by Anh Dinh on 6/24/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack {
                                Label("Steps", systemImage: "figure.walk")
                                    .font(.title3.bold())
                                    .foregroundStyle(.pink)
                                
                                Text("Avg: 10k steps")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        .padding(.bottom, 10)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.secondary)
                            .frame(height: 150)
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
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    ContentView()
}
