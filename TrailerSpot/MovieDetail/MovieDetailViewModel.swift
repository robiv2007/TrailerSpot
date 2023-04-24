//
//  MovieDetailViewModel.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-24.
//

import Foundation
import Model
import SwiftUI

class MovieDetailViewModel: ObservableObject {

    @Published var showFullDescription : Bool = false
    @Published var progressValue: Double = 0.0

    let posterPath = "https://image.tmdb.org/t/p/w500/"

    func ratingSet(voteAverage: Double) {
        progressValue = voteAverage / 10.0
        print("Progress value\(progressValue)")
    }

    var voteAverageColor: Color {
        if progressValue <= 0.5 {
            return Color.red
        } else {
            return Color.green
        }
    }
    
}
