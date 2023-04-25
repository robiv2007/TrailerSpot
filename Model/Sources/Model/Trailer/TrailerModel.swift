//
//  TrailerModel.swift
//  Model
//
//  Created by vatran robert on 2023-04-25.
//

import Foundation

struct TrailerResult: Codable,Identifiable {
    let name, key: String
    let site: String
    let official: Bool
    let id: String

    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/embed/\(key)?autoplay=1&playsinline=1")
    }
}
