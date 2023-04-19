//
//  TrailerSpotApp.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-14.
//

import SwiftUI

@main
struct TrailerSpotApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListView()
            }
        }
    }
}
