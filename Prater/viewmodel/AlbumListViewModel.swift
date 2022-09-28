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
    @Published var state: FetchState = .good
    
    let limit: Int = 20
    var page: Int = 0
    
    private let service = ApiService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetch(for: term)
            }.store(in: &subscriptions)
    }
    
    private func clear() {
        albums = []
        state = .good
        page = 0
    }
    
    func loadMore() {
        fetch(for: searchTerm)
    }
    
    private func fetch(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == .good else {
            return
        }
        
        state = .isLoading
        
        service.fetchAlbums(for: searchTerm, limit: limit, page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let results):
                    for album in results.results {
                        self?.albums.append(album)
                    }
                    self?.page += 1
                    
                    self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                    
                case .failure(let error):
                    self?.state = .error("Loading failed \(error.localizedDescription)")
                }
            }
        }
    }
}
