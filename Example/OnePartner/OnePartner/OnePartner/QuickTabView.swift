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
        return "title"
    }
    var iconName: String {
        return "house"
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

struct CustomerTabView: View {
    @State private var selectedTab: Tab = .home
    
    @State private var tabBarHeight: CGFloat = 60

    private var tabBarView: some View {
        HStack {
            ForEach(Tab.allCases) { item in
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        selectedTab = item
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: item.iconName)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 44, height: 29)
                        Text(item.title)
                            .font(.caption2)
                            .lineLimit(1)
                    }.frame(maxWidth: .infinity)
                }.foregroundColor(selectedTab == item ? .blue : .secondary)
            }
        }
        .padding(.horizontal,15)
        
    }
    
    init() {
    }
    var body: some View {
        GeometryReader { geometry in
            let screenHeight   = geometry.size.height
            let safeAreaBottom = geometry.safeAreaInsets.bottom
            Group {
                switch selectedTab {
                case .home:
                    Text("home")
                default:
                    Text("Hello World")
                        .padding(20)
                        .overlay(
                            Color.blue
                                .frame(width: 100, height: 100),
                            alignment: .center
                        )
                }
            }
            .transition(.blurReplace)
            .animation(.easeInOut, value: selectedTab)

            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                tabBarView.background(.ultraThinMaterial)
            }
            .onAppear {
            }
        }
    }
}

#Preview {
    CustomerTabView()
}


