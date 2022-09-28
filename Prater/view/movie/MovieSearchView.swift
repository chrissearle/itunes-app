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
                    PlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    MovieListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movies")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
