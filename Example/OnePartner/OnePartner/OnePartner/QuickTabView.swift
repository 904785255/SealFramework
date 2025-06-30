//
//  QuickTabView.swift
//  OnePartner
//
//  Created by bin sun on 2025/6/23.
//

import Foundation
import SwiftUI
enum Tab: Int, CaseIterable, Identifiable, Hashable {
    case home
    case search
    case profile
    case discover

    var id: Int {
        rawValue
    }
    
    var title: String {
        return ""
    }
    var iconName: String {
        return ""
    }
    var iconSelectedName: String {
        "\(iconName)-fill"
    }
    @ViewBuilder
    func makeContentView(selectedTab: Binding<Tab>) -> some View {
        
        EmptyView()
    }
    
    
}


struct QuickTabView: View {
    @State private var selectedTab: Tab = .home
    init() {
        
    }
    var body: some View {
        TabView(selection: .init(get: {
            selectedTab
        }, set: { newTab in
            
        })) {
            ForEach(Tab.allCases) { tab in
                tab.makeContentView(selectedTab: $selectedTab).tabItem {
                    Image(uiImage: UIImage(named: selectedTab == tab ? tab.iconSelectedName : tab.iconName)!)
                    Text(tab.title)
                }.tag(tab)
            }
        }
    }
}
