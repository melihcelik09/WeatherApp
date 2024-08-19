//
//  HomeView.swift
//  WeatherApp
//
//  Created by Melih on 8.08.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    var body: some View {
        ScrollView {
            VStack {
                TextField(
                    "Search City",
                    text: $viewModel.searchTerm
                ).textFieldStyle(
                    RoundedBorderTextFieldStyle()
                ).padding()
                CurrentInfo(
                    name: viewModel.locationName ?? "",
                    image: viewModel.current?.url ?? "",
                    phrase: viewModel.current?.iconPhrase ?? ""
                )
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.hourly) {
                            HourlyCard(
                                time: $0.formattedDateTime,
                                image: $0.url,
                                temperature: $0.temperature?.format ?? ""
                            )
                        }
                    }.padding()
                }.padding()

                ForEach(viewModel.daily) {
                    DailyCard(
                        date: $0.formatteddate,
                        image: $0.day?.url ?? "",
                        phrase: $0.day?.iconPhrase ?? "",
                        temperature: $0.temperature?.daily ?? ""
                    )
                }
            }
        }
        .onChange(of: viewModel.searchTerm, {
            Task {
                await viewModel.getLocationKey(
                    value: viewModel.searchTerm
                )
            }
        })
    }
}

#Preview {
    HomeView()
}
