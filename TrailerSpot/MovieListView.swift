//
//  ContentView.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-14.
//

import SwiftUI
import Combine
import Domain

struct MovieListView: View {
    @StateObject var vm = MovieListViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 120)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(vm.movie) { movie in
                    image(path: movie.posterPath ?? "")
                }
            }
            .onAppear {
                vm.fetchMovies()
            }
        }
        .padding(16)
    }

    @ViewBuilder
    private func image(path: String) -> some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(path )")) {
            $0.resizable()
                .cornerRadius(10)
        }placeholder: {
            ProgressView()
        }
        .frame(width: 120, height: 180)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
