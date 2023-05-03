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
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                logo()
                ScrollView() {
                    VStack(alignment: .leading, spacing: 16) {
                        carouselWithImages()
                        
                        Text("Upcoming Movies")
                            .modifier(RoundedRectangleModifier())
                        
                        horizontalGrid()
                        
                        Text("Popular")
                            .modifier(RoundedRectangleModifier())
                        
                        verticalGrid()
                            .onAppear {
                                vm.fetchMovies()
                                vm.fetchUpcomingMovies()
                            }
                    }
                    .font(.title)
                    .foregroundColor(.orange)
                    
                    pageNumber()
                }
                .scrollIndicators(.hidden)
            }
            .preferredColorScheme(.dark)
            .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    private func pageNumber() -> some View {
        HStack(spacing: 16) {
            Button {
                vm.decrementPageNumber()
            } label: {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.left")
                    Text("\(vm.pageNumber <= 1 ? vm.pageNumber : vm.pageNumber - 1 )")
                }
                .tint(.gray)
            }
            
            Text("Page \(vm.pageNumber)")
                .font(.title)
                .foregroundColor(.orange)
            
            Button {
                vm.incrementPageNumber()
            } label: {
                HStack(spacing: 0) {
                    Text("\(vm.pageNumber + 1)")
                    Image(systemName: "chevron.right")
                }
                .tint(.gray)
            }
        }
    }
    
    @ViewBuilder
    private func carouselWithImages() -> some View {
        TabView(selection: $vm.currentIndex){
            ForEach(vm.upcomingMovies.indices, id: \.self) { index in
                ZStack(alignment: .topTrailing) {
                    image(path: vm.upcomingMovies[index].backDropPath ?? "", title: vm.upcomingMovies[index].title)
                        .tag(index)
                    Text(vm.upcomingMovies[index].title)
                        .padding(8)
                        .font(.subheadline)
                        .background(.thickMaterial)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .fontWeight(.bold)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .frame(maxWidth: .infinity, minHeight: 250)
        .onReceive(vm.timer) { _ in
            withAnimation(.easeOut) {
                vm.addToCurrentIndex()
            }
        }
    }
    
    @ViewBuilder
    private func logo() -> some View {
        HStack(spacing: 8){
            Image("appLogo")
                .resizable()
                .frame(width: 45, height: 45)
            Text("Trailer Spot")
                .font(.title2)
                .foregroundColor(.orange)
                .bold()
        }
    }
    
    @ViewBuilder
    private func horizontalGrid() -> some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: vm.rows, spacing: 20){
                ForEach(vm.upcomingMovies, id: \.id){ item in
                    NavigationLink(destination: MovieDetailView(movie: item)){
                        image(path: item.posterPath,
                              title: item.title
                        )
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
