//
//  CurrentInfo.swift
//  WeatherApp
//
//  Created by Melih on 12.08.2024.
//

import SwiftUI

struct CurrentInfo: View {
    var name: String
    var image: String
    var phrase: String
    var body: some View {
        VStack {
            Text(name)
                .font(.title)
                .fontWeight(.bold)
            HStack(alignment:.center) {
                AsyncImageView(url: image)
                Text(phrase)
                    .font(.title)
                    .fontWeight(.medium)
            }.padding()
        }
    }
}

#Preview {
    CurrentInfo(name: "", image: "", phrase: "")
}

