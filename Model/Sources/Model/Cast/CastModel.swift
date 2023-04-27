//
//  CastModel.swift
//  Model
//
//  Created by vatran robert on 2023-04-26.
//

import Foundation

public struct MovieCast: Codable {
    public let id: Int?
    public let cast: [Cast]
}

public struct Cast: Codable {
    public let adult: Bool
    public let gender, id: Int
    public let knownForDepartment: KnownForDepartment
    public let name: String
    public let originalName: String?
    public let popularity: Double
    public let profilePath: String?
    public let castID: Int?
    public let character: String?
    public let creditID: String
    public let order: Int?
    public let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

public enum KnownForDepartment: String, Codable {
    case acting = "Acting"
}
