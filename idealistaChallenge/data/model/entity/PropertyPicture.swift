//
//  PropertyPicture.swift
//  idealistaChallenge
//
//  Created by diegitsen on 16/12/24.
//

import Foundation
import CoreData

class PropertyPictureEntity: NSManagedObject, UniquedObject {
    // UniqueId
    @NSManaged var id: String
    
    // Object data
    @NSManaged var tag: String
    @NSManaged var url: String
    
    // Object Parents
    @NSManaged var parentProperty: PropertyEntity
}

extension PropertyPictureEntity {
    
    class func fetchSingleOrCreate(propertyEntity: PropertyEntity, image: Image) -> PropertyPictureEntity {
        let id = "\(propertyEntity.id)-\(image.tag)"
        let propertyPicture = PersistenceManager.shared.fetchSingleOrCreate(PropertyPictureEntity.self, id: id)
        
        propertyPicture.parentProperty = propertyEntity
        propertyPicture.url = image.url
        propertyPicture.tag = image.tag
        
        return propertyPicture
    }
}
