//
//  SongListViewModel.swift
//  Prater
//
//  Created by Chris Searle on 21/09/2022.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = [Song]()
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
        songs = []
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
        
        service.fetchSongs(for: searchTerm, limit: limit, page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let results):
                    for song in results.results {
                        self?.songs.append(song)
                    }
                    self?.page += 1
                    
                    self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                    
                case .failure(let error):
                    self?.state = .error("Loading failed \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> SongListViewModel {
        let viewModel = SongListViewModel()
        
        viewModel.songs = [
            Song.example(),
            Song.example2()
        ]
        
        return viewModel
    }
}

