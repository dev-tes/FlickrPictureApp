//
//  PersistedPhotos+CoreDataProperties.swift
//  FlickrPictureApp
//
//  Created by  Decagon on 24/11/2021.
//
//

import Foundation
import CoreData


extension PersistedPhotos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersistedPhotos> {
        return NSFetchRequest<PersistedPhotos>(entityName: "PersistedPhotos")
    }

    @NSManaged public var ownersName: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var titleOfImage: String?
    @NSManaged public var image: String?

}

extension PersistedPhotos : Identifiable {

}
