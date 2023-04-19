//
//  AppDestinationViewer.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-19.
//

import Foundation
import Navigation
import SwiftUI

class AppDestinationViewer: DestinationViewer<Destination> {
    @ViewBuilder
    override func view(for destination: Destination) -> any View {
        switch destination {
        case .detailView:
            MovieListView()
        }
    }
}
