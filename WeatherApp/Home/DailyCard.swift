//
//  DailyCard.swift
//  WeatherApp
//
//  Created by Melih on 12.08.2024.
//

import SwiftUI

struct DailyCard: View {
    var date: String
    var image: String
    var phrase: String
    var temperature: String
    var body: some View {
        HStack(spacing: 20) {
            Text(date)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            AsyncImageView(url: image)
            Spacer()
            HStack{
                Text(phrase)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text(temperature)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
           
        }.frame(maxWidth: .infinity)
            .padding()
            .padding(.vertical)
            .background(Color(.systemGray2))
    }
}

#Preview {
    DailyCard(date: "", image: "", phrase: "", temperature: "")
}
