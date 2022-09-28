//
//  SongLoadingView.swift
//  Prater
//
//  Created by Chris Searle on 28/09/2022.
//

import SwiftUI

struct SongRowView: View {
    let song: Song
    
    var body: some View {
        HStack {
            ImageLoadingView(urlString: song.artworkUrl60, size: CGSize(width: 60, height: 60))
            
            VStack(alignment: .leading) {
                Text(song.trackName)
                Text(song.artistName + " " + song.collectionName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .lineLimit(1)
            
            Spacer(minLength: 20)
            
            BuyButtonView(urlString: song.trackViewURL, price: song.trackPrice, currency: song.currency)
        }
    }
}

struct SongRowView_Previews: PreviewProvider {
    static var previews: some View {
        SongRowView(song: Song.example())
    }
}
