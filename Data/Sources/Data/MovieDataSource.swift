//
//  MovieDataSource.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-17.
//

import Foundation
import Combine
import Model

public class MovieDataSource: MovieData {

    let apiKey = "ace7b669ec91ad7702878aa98fd99d60"
    let baseUrl = "https://api.themoviedb.org/3/movie/"


    public init() {}

    public func getPopularMovies() -> AnyPublisher<MovieList, ResultError> {
        let endpoint = "\(baseUrl)popular?api_key=\(apiKey)"
        return getMovies(from: endpoint)
    }

    public func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError> {
        let endpoint = "\(baseUrl)upcoming?api_key=\(apiKey)"
        return getMovies(from: endpoint)
    }

    public func getTrailers(id: Int) -> AnyPublisher<MovieDetails, ResultError> {
        let endpoint = "\(baseUrl)\(id)?api_key=\(apiKey)&append_to_response=videos"
        return getTrailers(from: endpoint)
    }


    
    public func getMovies(from endpoint: String) -> AnyPublisher<MovieList, ResultError> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: ResultError.resourceNotFound(endpoint)).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared

        return session.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: MovieList.self, decoder: JSONDecoder())
            .mapError { error in
                ResultError.apiError(error)
            }
            .eraseToAnyPublisher()
    }

    public func getTrailers(from endpoint: String) -> AnyPublisher<MovieDetails, ResultError> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: ResultError.resourceNotFound(endpoint)).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared

        return session.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: MovieDetails.self, decoder: JSONDecoder())
            .mapError { error in
                ResultError.apiError(error)
            }
            .eraseToAnyPublisher()
    }
}

