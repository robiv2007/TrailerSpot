//
//  MovieList.swift
//  Model
//
//  Created by vatran robert on 2023-04-14.
//

import Foundation

public struct MovieList: Codable {
    public let page: Int
    public let results: [Movie]
}

public enum ResultError: Error {
    case resourceNotFound(String)
    case apiError(Error)
}
