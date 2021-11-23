//
//  PhotoCollectionViewCellViewModel.swift
//  FlickrPictureApp
//
//  Created by  Decagon on 22/11/2021.
//

import Foundation

class PhotoCollectionViewCellViewModel {
    let title: String
    let ownername: String
    let imageURL: String?
    var imageData: Data? = nil
    
    init(
        title: String,
        ownername: String,
        imageURL: String?
    ){
        self.title = title
        self.ownername = ownername
        self.imageURL = imageURL
    }
}
