//
//  ApiService.swift
//  Prater
//
//  Created by Chris Searle on 21/09/2022.
//

import Foundation

enum EntityType: String {
    case album
    case song
    case movie
}

class ApiService {
    func fetchAlbums(for searchTerm: String, limit: Int = 20, page: Int = 0, completion: @escaping(Result<AlbumResult, ApiError>) -> Void) {
        let url = createURL(for: searchTerm, type: .album, limit: limit, offset: page * limit)
        fetch(type: AlbumResult.self, url: url, completion: completion)
    }
    
    func fetchSongs(for searchTerm: String, limit: Int = 20, page: Int = 0, completion: @escaping(Result<SongResult, ApiError>) -> Void) {
        let url = createURL(for: searchTerm, type: .song, limit: limit, offset: page * limit)
        fetch(type: SongResult.self, url: url, completion: completion)
    }

    func fetchMovies(for searchTerm: String, completion: @escaping(Result<MovieResult, ApiError>) -> Void) {
        let url = createURL(for: searchTerm, type: .movie, limit: nil, offset: nil)
        fetch(type: MovieResult.self, url: url, completion: completion)
    }

    private func fetch<T: Decodable>(type: T.Type, url: URL?, completion: @escaping(Result<T, ApiError>) -> Void) {
        guard let url = url else {
            let error = ApiError.badURL
            completion(Result.failure(error))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(ApiError.urlSession(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(ApiError.badResponse(response.statusCode)))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(ApiError.decoding(error as? DecodingError)))
                }
            }
        }.resume()
    }
    
    private func createURL(for searchTerm: String, type: EntityType, limit: Int?, offset: Int?) -> URL? {
        let baseURL = "https://itunes.apple.com/search"
        
        var queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: type.rawValue)
        ]

        if let limit = limit, let offset = offset {
            queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        var components = URLComponents(string: baseURL)
        
        components?.queryItems = queryItems
        
        return components?.url
    }
}
