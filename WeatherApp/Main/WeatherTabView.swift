//
//  WeatherTabView.swift
//  WeatherApp
//
//  Created by Melih on 8.08.2024.
//

import SwiftUI

struct WeatherTabView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .navigationTitle("Weather app")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    WeatherTabView()
}
