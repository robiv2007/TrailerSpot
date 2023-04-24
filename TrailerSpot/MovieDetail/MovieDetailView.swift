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
    @State var showFullDescription : Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                image(path: movie.backDropPath)
                expandableText()
                Spacer()
            }
            .padding(16)
        }
    }

    @ViewBuilder
    private func expandableText() -> some View {
        VStack(alignment: .leading, spacing: 8){
            Text(movie.overview)
                .lineLimit(showFullDescription ? nil : 2)
                .foregroundColor(.secondary)
            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    showFullDescription.toggle()
                }
            }, label: {
                Text(showFullDescription ? "Less" : "Read more..")
                    .font(.caption)
                    .fontWeight(.bold)
            })
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
        .frame(maxWidth: .infinity, maxHeight: 450)
    }
}
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Result.mockMovie)
    }
}
