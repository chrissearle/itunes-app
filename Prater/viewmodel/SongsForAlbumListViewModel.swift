//
//  SongsForAlbumsViewModel.swift
//  Prater
//
//  Created by Chris Searle on 03/10/2022.
//

import Foundation

class SongsForAlbumListViewModel: ObservableObject {
    let albumId: Int
    @Published var songs = [Song]()
    @Published var state: FetchState = .good
    
    private let service = ApiService()
    
    init (albumId: Int) {
        self.albumId = albumId
        self.fetch()
    }
    
    func fetch() {
        fetchSongs(albumId: albumId)
    }
    
    private func fetchSongs(albumId: Int) {
        state = .isLoading
        
        service.fetchSongs(for: albumId, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch (result) {
                case .success(let results):
                    if (results.resultCount > 0) {
                        self?.songs = results.results.filter { song in
                            song.id > 0
                        }
                    }
                    self?.state = .good

                case .failure(let error):
                    self?.state = .error("Loading failed \(error.localizedDescription)")
                    print(error)
                }
            }
        })
    }
    
    static func example() -> SongsForAlbumListViewModel {
        let viewModel = SongsForAlbumListViewModel(albumId: 1)
        
        viewModel.songs = [
            Song.example(),
            Song.example2()
        ]
        
        return viewModel
    }
}
