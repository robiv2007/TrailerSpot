//
//  TrailerModel.swift
//  Model
//
//  Created by vatran robert on 2023-04-25.
//

import Foundation

public struct Trailer: Codable,Identifiable {
    public let name, key: String
    public let site: String
    public let official: Bool
    public let id: String

    public var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://www.youtube.com/embed/\(key)?autoplay=1&playsinline=1")
    }
}
