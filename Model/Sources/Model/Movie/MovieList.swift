//
//  MovieList.swift
//  Model
//
//  Created by vatran robert on 2023-04-14.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [Result]
}
