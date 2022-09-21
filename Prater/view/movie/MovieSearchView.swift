//
//  MovieSearchView.swift
//  Prater
//
//  Created by Chris Searle on 21/09/2022.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if (viewModel.searchTerm.isEmpty) {
                    MoviePlaceHolderView(searchTerm: $viewModel.searchTerm)
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movies")
        }
    }
}

struct MoviePlaceHolderView: View {
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

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
