import Foundation
import Combine
import Model

public protocol MovieRepository {
    func getPopularMovies(pageNumber: Int) -> AnyPublisher<MovieList, ResultError>
    func getUpcomingMovies() -> AnyPublisher<MovieList, ResultError>    
    func getSearchResult(searchText: String) -> AnyPublisher<MovieList, ResultError>
}
