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
        return fetchData(from: endpoint, type: MovieList.self)
    }
    
    public func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError> {
        let endpoint = "\(baseUrl)upcoming?api_key=\(apiKey)"
        return fetchData(from: endpoint, type: MovieList.self)
    }
    
    public func getTrailers(id: Int) -> AnyPublisher<MovieDetails, ResultError> {
        let endpoint = "\(baseUrl)\(id)?api_key=\(apiKey)&append_to_response=videos"
        return fetchData(from: endpoint, type: MovieDetails.self)
    }
    
    public func getCast(id: Int) -> AnyPublisher<MovieCast, ResultError> {
        let endpoint = "\(baseUrl)\(id)/credits?api_key=\(apiKey)"
        return fetchData(from: endpoint, type: MovieCast.self)
    }


    private func fetchData<T: Decodable>(from endpoint: String, type: T.Type) -> AnyPublisher<T, ResultError> {
        guard let url = URL(string: endpoint) else {
            return Fail(error: ResultError.resourceNotFound(endpoint)).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared

        return session.dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                ResultError.apiError(error)
            }
            .eraseToAnyPublisher()
    }
}
