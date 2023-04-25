import Foundation
import Combine
import Model

public protocol MovieRepository {
    func getPopularMovies() -> AnyPublisher<MovieList, ResultError>
    func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError>
}
