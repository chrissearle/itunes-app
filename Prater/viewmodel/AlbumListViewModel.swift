//
//  AlbumListViewModel.swift
//  Prater
//
//  Created by Chris Searle on 05/08/2022.
//

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    
    enum State : Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    @Published var state: State = .good
    
    let limit: Int = 20
    var page: Int = 0
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.albums = []
                self?.state = .good
                self?.page = 0
                self?.fetchAlbums(for: term)
            }.store(in: &subscriptions)
    }
    
    func loadMore() {
        fetchAlbums(for: searchTerm)
    }
    
    func fetchAlbums(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        let offset = page * limit

        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=\(offset)") else {
            return
        }
        
        state = .isLoading

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("urlsession error: \(error)")
                
                DispatchQueue.main.async {
                    self?.state = .error("Loading failed \(error.localizedDescription)")
                }
                
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        for album in result.results {
                            self?.albums.append(album)
                        }
                        self?.page += 1
                        
                        self?.state = (result.results.count == self?.limit) ? .good : .loadedAll
                    }
                } catch {
                    print("decoding error: \(error)")
                    
                    DispatchQueue.main.async {
                        self?.state = .error("Decoding failed \(error.localizedDescription)")
                    }

                }
            }
        }.resume()
    }
}
