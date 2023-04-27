//
//  TabBarView.swift
//  TrailerSpot
//
//  Created by vatran robert on 2023-04-27.
//

import SwiftUI

struct TabBarView: View {
     @StateObject var vm = TabBarViewModel()

    var body: some View {
        TabView(selection: $vm.selectedTab) {
            ForEach(vm.tabs, id: \.self) { tab in
                view(for: vm.selectedTab)
                    .tabItem {
                        Label(tab.title, systemImage: tab.asset)
                            .background(Color.white)
                    }
                    .tag(tab)
                    .frame(maxHeight: .infinity)
            }
        }
    }

    @ViewBuilder
    private func view(for tab: TabBarViewModel.Tab) -> some View {
        switch tab {
        case .home:

            MovieListView()
        case .search:
            VStack {
                Text("Search view")
            }
        }
    }

}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
