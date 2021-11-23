//
//  APIModel.swift
//  FlickrPictureApp
//
//  Created by  Decagon on 22/11/2021.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let photos: Photos
}

// MARK: - Photos
struct Photos: Codable {
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, title, ownername: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, ownername
        case imageURL = "url_m"
    }
}
