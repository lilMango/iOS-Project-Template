//
//  TabContainerView.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import SwiftUI

struct TabContainerView: View {
    
    @StateObject private var tabContainerViewModel = TabContainerViewModel()
    
    var body: some View {
        
        TabView {
            ForEach(tabContainerViewModel.tabItemViewModels, id:\TabItemViewModel.self) { viewModel in
                tabView(for: viewModel.type)
                    .tabItem {
                        Image(systemName: viewModel.imageName)
                        Text(viewModel.title)
                    }
                    .tag(viewModel.type)
            }
        }
        
    }
    
    @ViewBuilder
    func tabView( for tabItemType: TabItemViewModel.TabItemType) -> some View {
        if #available(iOS 14.0, *) {
            switch tabItemType {
            case .feed:
                HomeFeedView()
            case .search:
                Text("Search")
            case .downloads:
                DownloadsView()
            case .settings:
                Text("Settings")
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

final class TabContainerViewModel: ObservableObject {
    
    @Published var selectedTab: TabItemViewModel.TabItemType = .feed
    
    let tabItemViewModels = [
        TabItemViewModel(imageName: "house.fill", title: "Feed", type: .feed),
        .init(imageName: "magnifyingglass", title: "Search", type: .search),
        .init(imageName: "arrow.down.to.line", title: "downloads", type: .downloads)
    ]
}

struct TabItemViewModel: Hashable {
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case feed
        case search
        case downloads
        case settings
    }
}


struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
            .environment(\.colorScheme, .dark)
    }
}


