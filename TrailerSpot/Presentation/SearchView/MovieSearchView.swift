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
            TextField("search movie", text: $vm.searchText)
                .textFieldStyle(.roundedBorder)
            Spacer()
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
