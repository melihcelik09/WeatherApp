//
//  AsyncImageView.swift
//  WeatherApp
//
//  Created by Melih on 12.08.2024.
//

import SwiftUI

struct AsyncImageView: View {
    var url:String
    var size:CGFloat = 32
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
        } placeholder: {
            ProgressView()
        }
    }
}


#Preview {
    AsyncImageView(url: "")
}
