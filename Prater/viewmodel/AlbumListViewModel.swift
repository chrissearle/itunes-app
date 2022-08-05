//
//  AlbumListViewModel.swift
//  Prater
//
//  Created by Chris Searle on 05/08/2022.
//

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    
    let limit: Int = 20
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
            self?.fetchAlbums(for: term)
        }.store(in: &subscriptions)
    }
    
    func fetchAlbums(for searchTerm: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("urlsession error: \(error)")
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        self.albums = result.results
                    }
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }.resume()
    }
}
