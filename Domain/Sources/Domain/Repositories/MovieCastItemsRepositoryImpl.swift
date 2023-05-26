//
//  MovieCastItemsRepositoryImpl.swift
//  
//
//  Created by vatran robert on 2023-05-23.
//

import Foundation
import Combine
import Data
import Model

public struct MovieCastItemsRepositoryImpl: MovieCastItemsRepository {

    private let movieData = MovieDataSource()

    public init() { }

    public func getCast(id: Int) -> AnyPublisher<MovieCast, ResultError> {
        movieData.getCast(id: id)
    }

    
}
