//
//  MovieData.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-17.
//

import Foundation
import Model
import Combine

public protocol MovieData {
    func getMovies() -> AnyPublisher<MovieList, ResultError>
    func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError>
}
