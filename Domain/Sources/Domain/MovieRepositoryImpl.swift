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
    
    public func getMovies() -> AnyPublisher<MovieList, ResultError> {
        movieData.getMovies()
    }
    
    public func getMovie(by id: String) {
        movieData.getMovie(by: id)
    }
}
