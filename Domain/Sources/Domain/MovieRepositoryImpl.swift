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
    
    public func getPopularMovies() -> AnyPublisher<MovieList, ResultError> {
        movieData.getPopularMovies()
    }
    
    public func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError> {
        movieData.getUpcomingMovies()
    }
}
