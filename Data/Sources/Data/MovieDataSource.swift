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
     let baseUrl = "https://api.themoviedb.org/3"


    public init() {}

    public func getPopularMovies() -> AnyPublisher<MovieList, ResultError> {
           let endpoint = "\(baseUrl)/movie/popular?api_key=\(apiKey)"
           return getMovies(from: endpoint)
       }

       public func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError> {
           let endpoint = "\(baseUrl)/movie/upcoming?api_key=\(apiKey)"
           return getMovies(from: endpoint)
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
}

