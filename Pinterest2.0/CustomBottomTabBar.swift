//
//  CustomBottomTabBar.swift
//  Pinterest2.0
//
//  Created by Mariano Petricciuolo on 12/11/25.
//

import SwiftUI

struct CustomBottomTabBar: View {
    @Binding var selectedTab: TabSelection
    @Binding var isSearching: Bool
    
    @State private var tabRects: [TabSelection: CGRect] = [:]
    
    private let tabItems: [TabSelection] = [.library, .collections]
    private let buttonWidth: CGFloat = 85, padding: CGFloat = 8, searchSize: CGFloat = 55
    
    private var indicatorRect: CGRect { tabRects[selectedTab] ?? .zero }

    
    private struct RectKey: PreferenceKey {
        static var defaultValue: [TabSelection: CGRect] = [:]
        static func reduce(value: inout [TabSelection: CGRect], nextValue: () -> [TabSelection: CGRect]) {
            value.merge(nextValue()) { (_, new) in new }
        }
    }

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                
                if let rect = tabRects[selectedTab], tabItems.contains(selectedTab) {
                    Capsule()
                        .fill(.white).shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .frame(width: rect.width + padding * 2, height: rect.height)
                        .offset(x: rect.minX - padding)
                        .animation(.spring(response: 0.4, dampingFraction: 0.65, blendDuration: 0.5), value: selectedTab)
                }
                
                HStack(spacing: 0) {
                    ForEach(tabItems, id: \.self) { tab in
                        
                        Button { withAnimation { selectedTab = tab; isSearching = false } } label: {
                            VStack(spacing: 2) {
                                Image(systemName: tab == .library ? "photo.on.rectangle" : "square.grid.2x2").font(.title2)
                                Text(tab.rawValue).font(.caption2)
                            }
                            .padding(.vertical, 8)
                            .foregroundStyle(selectedTab == tab ? Color.accentColor : .primary)
                        }
                        .frame(width: buttonWidth)
                        .background(GeometryReader { geometry in
                            Color.clear.preference(key: RectKey.self, value: [tab: geometry.frame(in: .named("tabBarSpace"))])
                        })
                    }
                }
            }
            .frame(height: searchSize)
            .background(Capsule().fill(.ultraThinMaterial).shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5))
            .fixedSize(horizontal: true, vertical: false).coordinateSpace(name: "tabBarSpace")
            .onPreferenceChange(RectKey.self) { self.tabRects.merge($0) { (_, new) in new } }

            Spacer()
            
            
            Button { withAnimation { selectedTab = selectedTab == .search ? .library : .search; isSearching = selectedTab == .search } } label: {
                Image(systemName: "magnifyingglass").font(.title2).fontWeight(.bold)
                    .foregroundColor(selectedTab == .search ? Color.accentColor : .primary)
                    .frame(width: searchSize, height: searchSize)
                    .background(Circle().fill(.ultraThinMaterial).shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5))
            }
        }
        .padding(.horizontal, 20).padding(.bottom, 20)
    }
}
