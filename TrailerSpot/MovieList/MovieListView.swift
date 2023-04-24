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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Upcoming Movies")
                        .modifier(TextCategories())
                        .font(.title)
                    horizontalGrid()
                }
                Text("Popular")
                    .font(.title)
                    .modifier(TextCategories())
                verticalGrid()
                    .onAppear {
                        vm.fetchMovies()
                        vm.fetchUpcomingMovies()
                    }
            }
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.dark)
        .padding(16)
    }

    @ViewBuilder
    private func horizontalGrid() -> some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: vm.rows, spacing: 20){
                ForEach(vm.upcomingMovies, id: \.id){ item in
                    NavigationLink(destination: MovieDetailView(movie: item)){
                        image(path: item.posterPath)
                            .frame(width: 200, height: 300)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func verticalGrid() -> some View {
        LazyVGrid(columns: vm.columns, spacing: 20) {
            ForEach(vm.popularMovieSList, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    image(path: movie.posterPath)
                        .frame(width: 120, height: 180)
                }
            }
        }
    }

    @ViewBuilder
    private func image(path: String) -> some View {
        AsyncImage(url: URL(string: "\(vm.imageUrl)\(path )")) {
            $0.resizable()
                .cornerRadius(10)
        }placeholder: {
            ProgressView()
        }
    }

    struct TextCategories: ViewModifier {
        let font = Font.system(size: 24).weight(.semibold)
        func body(content: Content) -> some View {
            content
                .font(font)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                .background(.thinMaterial)
                .cornerRadius(50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
