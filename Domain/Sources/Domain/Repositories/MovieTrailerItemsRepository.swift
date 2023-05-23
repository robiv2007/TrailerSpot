//
//  MovieTrailerItemsRepository.swift
//  
//
//  Created by vatran robert on 2023-05-23.
//

import Foundation
import Combine
import Model

public protocol MovieTrailerItemsRepository {
    func getTrailers(id: Int) -> AnyPublisher<MovieDetails, ResultError>
}
