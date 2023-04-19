//
//  Destination.swift
//  TrailerSpot
//
//  Created by Robert Vatran on 2023-04-19.
//

import SwiftUI

/// Enumeration of possible specific destinations in this app.
public enum Destination: NavigationStackable {
    case detailView

}

/// The navigator specific to this project
public typealias AppNavigator = Navigator<Destination>
