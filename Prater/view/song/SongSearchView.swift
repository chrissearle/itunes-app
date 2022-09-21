//
//  SongSearchView.swift
//  Prater
//
//  Created by Chris Searle on 21/09/2022.
//

import SwiftUI

struct SongSearchView: View {

    @StateObject var viewModel = SongListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if (viewModel.searchTerm.isEmpty) {
                    SongPlaceHolderView(searchTerm: $viewModel.searchTerm)
                } else {
                    SongListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Songs")
        }
    }
}

struct SongPlaceHolderView: View {
    @Binding var searchTerm: String
    
    let suggestions = ["queen", "pink floyd", "madness"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title2)
                }
            }
        }
    }
}

struct SongSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SongSearchView()
    }
}
