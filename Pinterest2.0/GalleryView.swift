//
//  GalleryView.swift
//  Pinterest2.0
//
//  Created by Mariano Petricciuolo on 12/11/25.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var savedPhotosModel: SavedPhotosModel
    @State private var selectedPhoto: Photo? = nil
    @State private var searchText: String = ""
    
    let isSearchTabActive: Bool
    let title: String
    
    let allPhotos = Photo.allPhotos // Utilizza il mock dal Model

    var filteredPhotos: [Photo] {
        isSearchTabActive && !searchText.isEmpty
            ? allPhotos.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            : allPhotos
    }

    let columns = [ GridItem(.adaptive(minimum: 150), spacing: 10) ]

    var body: some View {
        NavigationStack {
            ScrollView {
                if isSearchTabActive {
                    TextField("Search photos by title...", text: $searchText)
                        .padding(10).background(Color(.systemGray6)).cornerRadius(8)
                        .padding([.horizontal, .top])
                        .transition(.opacity).onChange(of: isSearchTabActive) { searchText = "" }
                }

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(filteredPhotos) { photo in
                        // Cella incorporata
                        VStack(alignment: .leading, spacing: 6) {
                            Image(photo.imageName).resizable().scaledToFill().frame(height: photo.height).clipped().cornerRadius(12)
                            Text(photo.title).font(.caption).foregroundStyle(.secondary).lineLimit(1).padding(.horizontal, 4)
                        }.onTapGesture { selectedPhoto = photo }
                            .padding(.horizontal, 8)
                    }
                }.padding()
            }
            .navigationTitle(title).navigationBarTitleDisplayMode(.large)
            .background(Color(.systemBackground).ignoresSafeArea())
            .sheet(item: $selectedPhoto) { FullscreenPhotoView(photo: $0) }
        }
    }
}
