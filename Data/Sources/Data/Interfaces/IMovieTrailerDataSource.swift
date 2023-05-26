//
//  IMovieTrailerDataSource.swift
//  
//
//  Created by vatran robert on 2023-05-23.
//

import Foundation
import Model
import Combine

public protocol IMovieTrailerDataSource {
    func getTrailers(id: Int) -> AnyPublisher<MovieDetails, ResultError>
}

