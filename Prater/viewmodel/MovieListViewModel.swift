//
//  MovieListViewModel.swift
//  Prater
//
//  Created by Chris Searle on 21/09/2022.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = [Movie]()
    @Published var state: FetchState = .good
    
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
        movies = []
        state = .good
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
        
        service.fetchMovies(for: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let results):
                    self?.movies = results.results

                    self?.state = .loadedAll
                    
                case .failure(let error):
                    self?.state = .error("Loading failed \(error.localizedDescription)")
                }
            }
        }
    }
}
