//
//  MovieListViewModel.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-18.
//

import Foundation
import Domain
import Combine
import Foundation
import Model
import Data
import SwiftUI


class MovieListViewModel: ObservableObject {
    @Published private(set) var popularMovieSList = [Movie]()
    @Published private(set) var upcomingMovies = [Movie]()
    @Published private(set) var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @Published var pageNumber = 1
    @Published var currentIndex = 0
    let imageUrl = "https://image.tmdb.org/t/p/w500/"
    private var isLoading = false
    private var error: Error?
    private let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()

    let columns = [
        GridItem(.adaptive(minimum: 120)),
    ]

    let rows = [
        GridItem(.flexible()),
    ]

    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
    }

    var pageNumberText: Int {
        pageNumber <= 1 ? pageNumber : pageNumber - 1 
    }

    func setPageNumber(_ newPageNumber: Int) {
        guard newPageNumber >= 1 else { return }
        pageNumber = newPageNumber
        fetchMovies()
    }

    func incrementPageNumber() {
        setPageNumber(pageNumber + 1)
    }

    func decrementPageNumber() {
        setPageNumber(pageNumber - 1)
    }


    func fetchMovies() {
        fetchData(publisher: repository.getPopularMovies(pageNumber: pageNumber)) { [weak self] movies in
            self?.popularMovieSList = movies
        }
    }

    func fetchUpcomingMovies() {
        fetchData(publisher: repository.getUpcomingMovies()) { [weak self] movies in
            self?.upcomingMovies = movies
        }
    }

    func addToCurrentIndex() {
        currentIndex = currentIndex < upcomingMovies.count - 1 ? currentIndex + 1 : 0
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
