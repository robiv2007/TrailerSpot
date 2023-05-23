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
    private let trailerRepository: MovieTrailerItemsRepository
    private var isLoading = false
    private var error: Error?
    private var cancellables = Set<AnyCancellable>()
    
    init(
        repository: MovieRepository = MovieRepositoryImpl(),
        trailerRepository: MovieTrailerItemsRepository = MobieTrailerRepositoryImpl())
    {
        self.repository = repository
        self.trailerRepository = trailerRepository
    }
    
    func ratingSet(voteAverage: Double) {
        progressValue = voteAverage / 10.0
        print("Progress value\(progressValue)")
    }
    
    func fetchTrailers(id: Int) {
        fetchData(publisher: trailerRepository.getTrailers(id: id), assignResults: { [weak self] trailers in
            self?.trailerList = trailers.filter({$0.name == "Official Trailer" || $0.official })
        }, filterResults: { $0.videos.results })
    }

    func fetchCast(id: Int) {
        fetchData(publisher: repository.getCast(id: id), assignResults: { [weak self] cast in
            self?.castList = cast
        }, filterResults: { $0.cast })
    }


    private func fetchData<T, R>(publisher: AnyPublisher<T, ResultError>, assignResults: @escaping ([R]) -> Void, filterResults: @escaping (T) -> [R]) {
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
                let results = filterResults(item)
                assignResults(results)
                print("\(T.self) \(item)")
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
