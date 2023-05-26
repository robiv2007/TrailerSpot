//
//  IMovieCastDataSource.swift
//  
//
//  Created by vatran robert on 2023-05-23.
//

import Foundation
import Combine
import Model

public protocol IMovieCastDataSource {
    func getCast(id: Int) -> AnyPublisher<MovieCast, ResultError>
}
