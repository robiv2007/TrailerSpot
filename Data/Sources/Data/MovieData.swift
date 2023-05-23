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
    func getPopularMovies(pageNumber:Int) -> AnyPublisher<MovieList, ResultError>
    func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError>
    func getCast(id: Int) -> AnyPublisher<MovieCast, ResultError>
    func getSearchResults(searchText: String) -> AnyPublisher<MovieList, ResultError>
}
