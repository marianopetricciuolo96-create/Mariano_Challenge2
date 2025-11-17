//
//  Model.swift
//  Pinterest2.0
//
//  Created by Mariano Petricciuolo on 12/11/25.
//

import SwiftUI
import Combine


enum TabSelection: String, CaseIterable {
    case library = "Home", collections = "Gallery", search = "Search"
}

struct Photo: Identifiable, Equatable {
    let id = UUID()
    let imageName: String
    let title: String
    let height: CGFloat
    
    
    
    static let allPhotos: [Photo] = [
        Photo(imageName: "foto1", title: "New console", height: 240, ),
        Photo(imageName: "foto2", title: "Houses", height: 240),
        Photo(imageName: "foto3", title: "4th Generation", height: 240),
        Photo(imageName: "foto4", title: "Night city", height: 240),
        Photo(imageName: "foto5", title: "The Days", height: 240),
        Photo(imageName: "foto6", title: "Cyberpunk", height: 240),
        Photo(imageName: "foto7", title: "Poket Monsters", height: 240),
        Photo(imageName: "foto8", title: "Thinking alone", height: 240)

    ]
}

final class SavedPhotosModel: ObservableObject {
    @Published var savedPhotos: [Photo] = []
    
    func deletePhoto(photo: Photo) {
        savedPhotos.removeAll { $0.id == photo.id }
    }
}
