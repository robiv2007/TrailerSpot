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

    public init() { }
    
    public func getMovies() -> AnyPublisher<MovieList, ResultError> {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=ace7b669ec91ad7702878aa98fd99d60&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1&with_watch_monetization_types=flatrate") else {
            return Fail(error: ResultError.resourceNotFound(Error.self as! Error)).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
               let session = URLSession.shared

               return session.dataTaskPublisher(for: urlRequest)
                   .map { $0.data }
                   .decode(type: MovieList.self, decoder: JSONDecoder())
                   .mapError { error in
                       ResultError.resourceNotFound(error)
                   }
                   .eraseToAnyPublisher()
    }

    public func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=ace7b669ec91ad7702878aa98fd99d60&language=en-US&page=1&include_adult=false") else {
            return Fail(error: ResultError.resourceNotFound(Error.self as! Error)).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
               let session = URLSession.shared

               return session.dataTaskPublisher(for: urlRequest)
                   .map { $0.data }
                   .decode(type: MovieList.self, decoder: JSONDecoder())
                   .mapError { error in
                       ResultError.resourceNotFound(error)
                   }
                   .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case invalidURL(Error)
}

