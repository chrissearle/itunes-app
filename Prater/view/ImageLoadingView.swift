//
//  ImageLoadingView.swift
//  Prater
//
//  Created by Chris Searle on 28/09/2022.
//

import SwiftUI

struct ImageLoadingView: View {
    let urlString: String
    let size: CGSize
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { phase in
            switch (phase) {
            case .empty:
                ProgressView()
            case .failure(_):
                Color.gray
            case .success(let image):
                image.resizable()
                    .border(Color(white: 0.8))
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: size.width, height: size.height)
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadingView(urlString: Song.example().artworkUrl60, size: CGSize(width: 60, height: 60))
    }
}
