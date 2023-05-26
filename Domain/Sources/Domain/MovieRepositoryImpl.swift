//
//  File.swift
//  
//
//  Created by vatran robert on 2023-04-18.
//

import Foundation
import Combine
import Data
import Model

public class MovieRepositoryImpl: MovieRepository {
    private let movieData = MovieDataSource()
    
    public init() { }
    
    public func getPopularMovies(pageNumber: Int) -> AnyPublisher<MovieList, ResultError> {
        movieData.getPopularMovies(pageNumber: pageNumber)
    }
    
    public func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError> {
        movieData.getUpcomingMovies()
    }

    public func getSearchResult(searchText: String) -> AnyPublisher<MovieList, ResultError> {
        movieData.getSearchResults(searchText: searchText)
    }
}
