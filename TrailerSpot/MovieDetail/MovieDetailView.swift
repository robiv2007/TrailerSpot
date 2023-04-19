//
//  MovieDetailView.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-19.
//

import SwiftUI
import Model

struct MovieDetailView: View {
    let movie: Result
    var body: some View {
        VStack {
            image(path: movie.posterPath ?? "")
                .padding(.top, 80)
            Spacer()
        }
    }

    @ViewBuilder
    private func image(path: String) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(path )")) {
            $0.resizable()
                .scaledToFill()
                .cornerRadius(10)
        }placeholder: {
            ProgressView()
        }
        .frame(width: 350, height: 400)
    }
}
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Result.mockMovie)
    }
}
