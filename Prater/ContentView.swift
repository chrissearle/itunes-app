//
//  ContentView.swift
//  Prater
//
//  Created by Chris Searle on 05/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem{
                    Label("Search", systemImage: "magnifyingglass")
                }

            AlbumSearchView()
                .tabItem{
                    Label("Albums", systemImage: "music.note")
                }

            SongSearchView()
                .tabItem {
                    Label("Songs", systemImage: "up")
                }

            
            MovieSearchView()
                .tabItem {
                    Label("Movies", systemImage: "tv")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
