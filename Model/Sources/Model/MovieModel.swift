//
//  MovieModel.swift
//  Model
//
//  Created by vatran robert on 2023-04-14.
//

struct Result: Codable, Identifiable {

    let adult: Bool
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    static var mockMovie : Result
    {Result(adult: false, genreIDS: [], id: 1, originalLanguage: "Eng", originalTitle: "Harry ", overview: "", popularity: 0.0, posterPath: "", releaseDate: "", title: "Harry", video: true, voteAverage: 0.0, voteCount: 1)}
}


