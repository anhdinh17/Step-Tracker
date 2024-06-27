//
//  HealthkitPermissionPrimingView.swift
//  Step Tracker
//
//  Created by Anh Dinh on 6/27/24.
//

import SwiftUI

struct HealthkitPermissionPrimingView: View {
    var description: String = """
    This app displays your steps and weight data in interactive charts.
    
    You can also add new step or weight data to Apple Health from this app. Your data is private and secured.
    """
    
    var body: some View {
        VStack(spacing: 100) {
            VStack(alignment: .leading, spacing: 10) {
                Image(.appleHealthkitIcon)
                    .resizable()
                    .frame(width: 90, height: 90)
                    .shadow(color: .gray.opacity(0.3),radius: 16)
                
                Text("Apple Health Integration")
                    .font(.title2)
                    .bold()
                
                Text(description)
                    .foregroundStyle(.secondary)
            }
            
            Button {
                
            } label: {
                Text("Connect Apple Health")
                    .foregroundStyle(.white)
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            .tint(.pink)
        }
        .padding(20)
    }
}

#Preview {
    HealthkitPermissionPrimingView()
}