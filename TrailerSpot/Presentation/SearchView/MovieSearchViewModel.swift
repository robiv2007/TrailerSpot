//
//  MovieSearchViewModel.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-28.
//

import Combine
import Data
import Domain
import Model
import Foundation

class MovieSearchViewModel: ObservableObject {

    @Published var searchText = ""
    @Published var searchResultList: [Movie] = []

    private var isLoading = false
    private var error: Error?
    private let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
    }

    func fetchSearchResult() {
        fetchData(publisher: repository.getSearchResult(searchText: searchText)) { [weak self] movies in
            self?.searchResultList = movies
        }
    }

    private func fetchData(publisher: AnyPublisher<MovieList, ResultError>, assignResults: @escaping ([Movie]) -> Void) {
        isLoading = true
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = error
                    print("Error \(error)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { movie in
                assignResults(movie.results)
                print("Movies \(movie)")
            }
            .store(in: &cancellables)
    }
}
