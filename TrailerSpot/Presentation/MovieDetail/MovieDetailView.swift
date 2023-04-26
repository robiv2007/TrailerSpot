//
//  MovieDetailView.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-19.
//

import SwiftUI
import Model

struct MovieDetailView: View {
    @StateObject var vm = MovieDetailViewModel()
    let movie: Result
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottomTrailing) {
                    image(path: movie.backDropPath)
                    VStack(spacing: 0) {
                        RatingView(progress: $vm.progressValue,
                                   color: vm.voteAverageColor,
                                   rating: movie.voteAverage)
                        .frame(width: 40)
                        Text("\(movie.voteCount) Votes")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(8)
                    }
                }
                titleAndReleaseDate()
                expandableText()
                trailerWindow()

            }
            .padding(8)
            .onAppear {
                vm.ratingSet(voteAverage: movie.voteAverage)
                vm.fetchTrailers(id: movie.id)
            }
        }
    }

    @ViewBuilder
    private func titleAndReleaseDate() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(movie.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.orange)
            Text("Release Date \(movie.releaseDate)")
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder
    private func trailerWindow() -> some View {
        Text("Trailer")
            .font(.headline)
            .foregroundColor(.orange)
        if let video = vm.trailerList.first?.youtubeURL {
            YouTubeWebView(url: video.absoluteString)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: 400)
                .cornerRadius(10)
        } else {
            Text("Trailer not available")
                .foregroundColor(.red)
        }
    }
    
    @ViewBuilder
    private func expandableText() -> some View {
        VStack(alignment: .leading, spacing: 8){
            Text("About the movie:")
                .fontWeight(.bold)
                .foregroundColor(.orange)
            Text(movie.overview)
                .lineLimit(vm.showFullDescription ? nil : 2)
                .foregroundColor(.secondary)
            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    vm.showFullDescription.toggle()
                }
            }, label: {
                Text(vm.showFullDescription ? "Less" : "Read more..")
                    .fontWeight(.bold)
            })
        }
        .font(.subheadline)
        .padding(.bottom, 16)
    }
    
    @ViewBuilder
    private func image(path: String) -> some View {
        AsyncImage(url: URL(string: "\(vm.posterPath)\(path )")) {
            $0.resizable()
                .scaledToFill()
                .cornerRadius(10)
        }placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: 450)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Result.mockMovie)
    }
}
