//
//  MovieSearchView.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-28.
//

import SwiftUI

struct MovieSearchView: View {

    @StateObject var vm = MovieSearchViewModel()

    var body: some View {
        VStack {
            TextField("Search movies", text: $vm.searchText)
                .onChange(of: vm.searchText) { newValue in
                    vm.fetchSearchResult()
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                .padding(.bottom, 16)
            ScrollView {
                verticalGrid()
            }
        }
        .padding(8)
        .onAppear(perform: vm.fetchPopularMovies)
    }

    @ViewBuilder
    private func verticalGrid() -> some View {
        LazyVGrid(columns: vm.columns, spacing: 20) {
            ForEach(vm.searchResultList.isEmpty ? vm.popularMoviesList : vm.searchResultList, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    image(path: movie.posterPath,
                          title: movie.title)
                    .frame(width: 120, height: 180)
                }
            }
        }
    }

    @ViewBuilder
    private func image(path: String, title: String) -> some View {
        AsyncImage(url: URL(string: "\(vm.imageUrl)\(path)")) {
            $0.resizable()
                .cornerRadius(10)
        } placeholder: {
            VStack {
                Text(title)
                    .font(.subheadline)
                ProgressView()
            }
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
