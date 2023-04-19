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
    @Published var movie = [Result]()
    @Published var upcomingMovies = [Result]()
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
    
    func fetchMovies() {
        print("Fetch")
        isLoading = true
        repository.getMovies()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.error = error
                    print("Error \(error)")
                case .finished:
                    print("Finished")
                    break
                }
            } receiveValue: { movie in
                self.movie = movie.results
                print("Movie value \(movie)")
            }
            .store(in: &cancellables)
    }

    func fetchUpcomingMovies() {
        print("Fetch")
        isLoading = true
        repository.getUpcomingMovies()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.error = error
                    print("Error \(error)")
                case .finished:
                    print("Finished")
                    break
                }
            } receiveValue: { movie in
                self.upcomingMovies = movie.results
                print("Upcoming Movies \(movie)")
            }
            .store(in: &cancellables)
    }
}
