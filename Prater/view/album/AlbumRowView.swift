//
//  AlbumRowView.swift
//  Prater
//
//  Created by Chris Searle on 28/09/2022.
//

import SwiftUI

struct AlbumRowView: View {
    let album: Album
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: album.artworkUrl100, size: CGSize(width: 100, height: 100))
            
            VStack(alignment: .leading) {
                Text(album.collectionName)
                Text(album.artistName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            BuyButtonView(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
        }
    }
}

struct AlbumRowView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRowView(album: Album.example())
    }
}
