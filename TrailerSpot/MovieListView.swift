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
        VStack {
            List(vm.movie) { movie in
                Text(movie.title)
            }
            .onAppear {
                vm.fetchPosts()
                print("posts \(vm.movie)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
