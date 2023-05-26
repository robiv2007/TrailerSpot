//
//  MovieTrailerRepositoryImpl.swift
//  
//
//  Created by vatran robert on 2023-05-23.
//

import Foundation
import Combine
import Data
import Model

public struct MovieTrailerRepositoryImpl: MovieTrailerItemsRepository {

    private let movieData = MovieDataSource()

    public init() { }

    public func getTrailers(id: Int) -> AnyPublisher<MovieDetails, ResultError> {
        movieData.getTrailers(id: id)
    }
}
