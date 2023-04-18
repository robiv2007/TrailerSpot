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


class MovieListViewModel: ObservableObject {
    @Published var movie = [Result]()
    @Published var isLoading = false
    @Published var error: Error?
    
    private let repository: MovieRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
    }
    
    func fetchPosts() {
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
}
