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
import SwiftUI

class MovieSearchViewModel: ObservableObject {

    @Published var searchText = ""
    @Published var searchResultList: [Movie] = []
    @Published var popularMoviesList: [Movie] = []

    let imageUrl = "https://image.tmdb.org/t/p/w500/"
    private var isLoading = false
    private var error: Error?
    private let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()

    let columns = [
        GridItem(.adaptive(minimum: 120)),
    ]

    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
    }

    func fetchSearchResult() {
        let replaced = searchText.replacingOccurrences(of: " ", with: "%20")
        fetchData(publisher: repository.getSearchResult(searchText: replaced)) { [weak self] movies in
            self?.searchResultList = movies
        }
    }

    func fetchPopularMovies() {
        fetchData(publisher: repository.getPopularMovies()) { [weak self] movies in
            self?.popularMoviesList = movies
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
