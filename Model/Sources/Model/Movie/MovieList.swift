//
//  MovieList.swift
//  Model
//
//  Created by vatran robert on 2023-04-14.
//

import Foundation

public struct MovieList: Codable {
    public let page: Int
    public let results: [Result]
}

public enum ResultError: Error {
    case resourceNotFound(Error)
}
