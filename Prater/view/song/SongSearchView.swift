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
                    PlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    SongListView(viewModel: viewModel)
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Songs")
        }
    }
}

struct SongSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SongSearchView()
    }
}
