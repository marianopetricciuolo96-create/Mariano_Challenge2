//
//  SavedGalleryView.swift
//  Pinterest2.0
//
//  Created by Mariano Petricciuolo on 12/11/25.
//

import SwiftUI

struct SavedGalleryView: View {
    @EnvironmentObject var savedPhotosModel: SavedPhotosModel
    @State private var selectedPhoto: Photo? = nil

    
    let columns = [
        GridItem(.flexible(minimum: 140), spacing: 10),
        GridItem(.flexible(minimum: 140), spacing: 10)
    ]

    var body: some View {
        NavigationStack {
            if savedPhotosModel.savedPhotos.isEmpty {
                ContentUnavailableView("No images saved", systemImage: "square.stack")
                    // Applica il titolo qui per lo stato vuoto
                    .navigationTitle("Gallery")
                    .navigationBarTitleDisplayMode(.large)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(savedPhotosModel.savedPhotos) { photo in
                            VStack(alignment: .leading, spacing: 6) {
                                // Immagine con altezza fissa 240
                                Image(photo.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 240)
                                    .clipped()
                                    .cornerRadius(12)
                                    
                                Text(photo.title)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                                    .padding(.horizontal, 4)
                            }
                            .contextMenu {
                                Button(role: .destructive) { savedPhotosModel.deletePhoto(photo: photo) } label: {
                                    Label("Remove from Gallery", systemImage: "trash")
                                }
                            }
                            .onTapGesture { selectedPhoto = photo }
                        }
                    }.padding()
                }
                
                .navigationTitle("Gallery")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .sheet(item: $selectedPhoto) { FullscreenPhotoView(photo: $0) }
    }
}
