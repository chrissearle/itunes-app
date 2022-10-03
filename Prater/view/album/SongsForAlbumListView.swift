//
//  SongsForAlbumListView.swift
//  Prater
//
//  Created by Chris Searle on 03/10/2022.
//

import SwiftUI

struct SongsForAlbumListView: View {
    @ObservedObject var songsViewModel: SongsForAlbumListViewModel
    
    var body: some View {
        ScrollView {
            if (songsViewModel.state == .isLoading) {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Grid(horizontalSpacing: 20) {
                    ForEach(songsViewModel.songs) {song in
                        GridRow  {
                            Text("\(song.trackNumber)")
                                .font(.footnote)
                                .gridColumnAlignment(.trailing)
                            Text(song.trackName)
                                .gridColumnAlignment(.leading)
                            Spacer()
                            Text(formattedDuration(millis: song.trackTimeMillis))
                                .font(.footnote)
                            BuySongButtonView(song: song)
                        }
                        
                        Divider()
                    }
                }
                .padding([.vertical, .leading])
            }
        }
    }
    
    func formattedDuration(millis: Int) -> String {
        let interval = TimeInterval(millis / 1000)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        return formatter.string(from: interval) ?? ""        
    }
}

struct SongsForAlbumListView_Previews: PreviewProvider {
    static let viewModel = SongsForAlbumListViewModel.example()
    
    static var previews: some View {
        SongsForAlbumListView(songsViewModel: viewModel)
    }
}
