//
//  HourlyCard.swift
//  WeatherApp
//
//  Created by Melih on 12.08.2024.
//

import SwiftUI

struct HourlyCard: View {
    var time: String
    var image: String
    var temperature: String
    var body: some View {
        VStack(spacing: 30) {
            Text(time)
            AsyncImageView(url: image)
            Text(temperature)
        }
        .font(.headline)
        .padding()
        .padding(.horizontal)
        .background(Color(.systemGray6))
        .clipShape(
            RoundedRectangle(cornerRadius: 10)
        )
    }
}
#Preview {
    HourlyCard(time: "", image: "", temperature: "")
}
