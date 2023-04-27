//
//  MovieDetailViewModel.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-24.
//

import Combine
import Data
import Domain
import Foundation
import Model
import SwiftUI

class MovieDetailViewModel: ObservableObject {
    
    @Published var showFullDescription : Bool = false
    @Published var progressValue: Double = 0.0
    @Published private(set) var trailerList = [Trailer]()
    @Published var castList = [Cast]()
    
    let posterPath = "https://image.tmdb.org/t/p/w500/"
    private let repository: MovieRepository
    private var isLoading = false
    private var error: Error?
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: MovieRepository = MovieRepositoryImpl()) {
        self.repository = repository
    }
    
    func ratingSet(voteAverage: Double) {
        progressValue = voteAverage / 10.0
        print("Progress value\(progressValue)")
    }
    
    func fetchTrailers(id: Int) {
        fetchData(publisher: repository.getTrailers(id: id)) { [weak self] trailers in
            self?.trailerList = trailers
        }
    }
    
    func fetchCast(id: Int) {
        fetchCast(publisher: repository.getCast(id: id)) { [weak self] cast in
            self?.castList = cast
        }
    }
    
    private func fetchData(publisher: AnyPublisher<MovieDetails, ResultError>, assignResults: @escaping ([Trailer]) -> Void) {
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
            } receiveValue: { trailer in
                assignResults(trailer.videos.results.filter({$0.name == "Official Trailer" && $0.official == true || $0.official == false}))
                print("Movies \(trailer)")
            }
            .store(in: &cancellables)
    }
    
    private func fetchCast(publisher: AnyPublisher<MovieCast, ResultError>, assignResults: @escaping ([Cast]) -> Void) {
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
            } receiveValue: { item in
                assignResults(item.cast)
                print("Cast \(item)")
            }
            .store(in: &cancellables)
    }
    
    var voteAverageColor: Color {
        if progressValue <= 0.5 {
            return Color.red
        } else {
            return Color.green
        }
    }
    
}
