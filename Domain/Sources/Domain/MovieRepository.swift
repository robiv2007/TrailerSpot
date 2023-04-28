import Foundation
import Combine
import Model

public protocol MovieRepository {
    func getPopularMovies() -> AnyPublisher<MovieList, ResultError>
    func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError>
    func getTrailers(id: Int) -> AnyPublisher<MovieDetails, ResultError>
    func getCast(id: Int) -> AnyPublisher<MovieCast, ResultError>
    func getSearchResult(searchText: String) -> AnyPublisher<MovieList, ResultError>
}
