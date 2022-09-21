//
//  FetchState.swift
//  Prater
//
//  Created by Chris Searle on 21/09/2022.
//

import Foundation

enum FetchState : Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}
