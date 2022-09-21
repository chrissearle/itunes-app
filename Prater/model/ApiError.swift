//
//  ApiError.swift
//  Prater
//
//  Created by Chris Searle on 21/09/2022.
//

import Foundation

enum ApiError: Error, CustomStringConvertible {
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch (self) {
            
        case .badURL:
            return "badURL"
        case .urlSession(let error):
            return "urlSession: \(error.debugDescription)"
        case .badResponse(let status):
            return "badResponse: \(status)"
        case .decoding(let error):
            return "decoding: \(error)"
        case .unknown:
            return "unknown"
        }
    }
    
    var localizedDescription: String {
        switch (self) {
            
        case .badURL, .unknown:
            return "something went wrong"
        case .urlSession(let error):
            return error?.localizedDescription ?? "something went wrong"
        case .badResponse(_):
            return "something went wrong"
        case .decoding(let error):
            return error?.localizedDescription ?? "something went wrong"
        }
    }
}
