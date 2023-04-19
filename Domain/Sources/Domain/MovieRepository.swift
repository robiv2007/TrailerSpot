import Foundation
import Combine
import Model

public protocol MovieRepository {
    func getMovies() -> AnyPublisher<MovieList, ResultError>
    func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError>
}
