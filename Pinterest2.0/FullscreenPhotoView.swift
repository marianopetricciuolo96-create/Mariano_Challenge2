//
//  FullscreenPhotoView.swift
//  Pinterest2.0
//
//  Created by Mariano Petricciuolo on 12/11/25.
//

import SwiftUI

struct FullscreenPhotoView: View {
    let photo: Photo
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var savedPhotosModel: SavedPhotosModel
    
    @State private var showSavedAlert = false
    @State private var showDeletedAlert = false

    var isSaved: Bool { savedPhotosModel.savedPhotos.contains(photo) }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color(.systemBackground).ignoresSafeArea()

            VStack {
                Spacer()
                Image(photo.imageName).resizable().scaledToFit().cornerRadius(16).shadow(radius: 8).padding()
                Text(photo.title).font(.headline).foregroundStyle(.primary).padding(.bottom, 8)

                Button { isSaved ? deletePhoto() : savePhoto() } label: {
                    Label(isSaved ? "Remove from Gallery" : "Save to Gallery",
                          systemImage: isSaved ? "trash.fill" : "square.and.arrow.down")
                        .font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity)
                        .background(isSaved ? Color.red : Color.accentColor).cornerRadius(12).padding(.horizontal, 40)
                }
                Spacer().frame(height: 40)
            }
            .alert("Image saved!", isPresented: $showSavedAlert) { Button("OK", role: .cancel) {} }
            .alert("Image removed!", isPresented: $showDeletedAlert) { Button("OK", role: .cancel) { dismiss() } }
            
            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill").font(.system(size: 28)).foregroundStyle(.secondary).padding()
            }
        }
    }

    func savePhoto() { if !isSaved { savedPhotosModel.savedPhotos.append(photo) }; showSavedAlert = true }
    func deletePhoto() { savedPhotosModel.deletePhoto(photo: photo); showDeletedAlert = true }
}
