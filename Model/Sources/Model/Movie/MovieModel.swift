//
//  MovieModel.swift
//  Model
//
//  Created by vatran robert on 2023-04-14.
//

public struct Movie: Codable, Identifiable {
    
    public let adult: Bool
    public let genreIDS: [Int]
    public let id: Int
    public let originalLanguage, originalTitle, overview: String
    public let popularity: Double
    public let posterPath: String
    public let releaseDate, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    public let backDropPath: String
    
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
        case backDropPath = "backdrop_path"
    }
    
    static public var mockMovie : Movie
    {Movie(adult: false, genreIDS: [], id: 1, originalLanguage: "Eng", originalTitle: "Harry ", overview: "", popularity: 0.0, posterPath: "/hR1jdCw0A9czgsbp45TASkjjBhA.jpg", releaseDate: "", title: "Harry", video: true, voteAverage: 6.0, voteCount: 1, backDropPath: "/lWqjXgut48IK5f5IRbDBAoO2Epp.jpg")}
}


