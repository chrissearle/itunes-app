//
//  AlbumDetailView.swift
//  Prater
//
//  Created by Chris Searle on 03/10/2022.
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    
    @StateObject var songsViewModel: SongsForAlbumListViewModel
    
    init(album: Album) {
        self.album = album
        
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumId: album.id))
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: album.artworkUrl100, size: CGSize(width: 100, height: 100))
                
                VStack(alignment: .leading) {
                    Text(album.collectionName)
                        .foregroundColor(Color(.label))
                        .font(.footnote)
                    Text(album.artistName)
                        .padding(.bottom, 5)
                    
                    
                    Text(album.primaryGenreName)
                    Text("\(album.trackCount) songs")
                    Text("Releaased: \(formattedDate(value: album.releaseDate))")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
                
                Spacer(minLength: 20)
                
                BuyButtonView(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
            }
            .padding( )
        }
        
        SongsForAlbumListView(songsViewModel: songsViewModel)
            .onAppear {
                songsViewModel.fetch()
            }
    }
    
    func formattedDate(value: String) -> String {
        let dateFormatterGetter = DateFormatter()
        dateFormatterGetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormatterGetter.date(from: value) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}   

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}
