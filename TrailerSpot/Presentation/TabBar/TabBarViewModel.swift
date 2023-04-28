//
//  TabBarViewModel.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-27.
//

import Foundation
import SwiftUI

final class TabBarViewModel: ObservableObject {
    @Published var selectedTab = Tab.home

    var tabs: [Tab] = [.home, .search]

    init() { }

    enum Tab: Int {
        case home
        case search

        var title: String {
            switch self {
            case .home:
                return "Home"

            case .search:
                return "Search"
            }
        }

        var asset: String {
            switch self {
            case .home:
                return "house.fill"

            case .search:
                return "magnifyingglass"
            }
        }
    }
}
