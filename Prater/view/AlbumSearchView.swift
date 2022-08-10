//
//  AlbumSearchView.swift
//  Prater
//
//  Created by Chris Searle on 10/08/2022.
//

import SwiftUI

struct AlbumSearchView: View {
    @StateObject var viewModel = AlbumListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if (viewModel.searchTerm.isEmpty) {
                    AlbumPlaceHolderView(searchTerm: $viewModel.searchTerm)
                } else {
                    AlbumListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }
    }
}


struct AlbumPlaceHolderView: View {
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

struct AlbumSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumSearchView()
    }
}
