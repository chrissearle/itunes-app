//
//  MovieRowView.swift
//  Prater
//
//  Created by Chris Searle on 28/09/2022.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: movie.artworkUrl100, size: CGSize(width: 67, height: 100))
            
            VStack(alignment: .leading) {
                Text(movie.trackName)
                Text(movie.primaryGenreName)
                    .foregroundColor(.gray)
                Text(movie.releaseDate)
            }
            .font(.caption)
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            BuyButtonView(urlString: movie.previewURL, price: movie.trackPrice, currency: movie.currency)
        }
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView(movie: Movie.example())
    }
}
