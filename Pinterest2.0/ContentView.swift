//
//  ContentView.swift
//  Pinterest2.0
//
//  Created by Mariano Petricciuolo on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: TabSelection = .library
    @State private var isSearching: Bool = false
    @StateObject private var savedPhotosModel = SavedPhotosModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                GalleryView(isSearchTabActive: selectedTab == .search,
                            title: selectedTab == .search ? "Search" : "Home")
                
                if selectedTab == .collections {
                    SavedGalleryView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            CustomBottomTabBar(selectedTab: $selectedTab, isSearching: $isSearching)
        }
        .environmentObject(savedPhotosModel)
        .tint(.blue)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}
