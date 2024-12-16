//
//  PropertyLocalDatasource.swift
//  idealistaChallenge
//
//  Created by diegitsen on 16/12/24.
//


import Foundation

class PropertyLocalDatasource {
        
    func saveProperty(cloudProperty: CloudProperty) async -> PropertyEntity {
        let property = PropertyEntity.fetchSingleOrCreate(cloudProperty: cloudProperty)
        await cloudProperty.multimedia.images.asyncForEach { image in
            await MainActor.run {  _ = PropertyPictureEntity.fetchSingleOrCreate(propertyEntity: property, image: image) }
        }
        await PersistenceManager.shared.save()
        return property
    }
    
    func getProperties() -> [PropertyEntity] {
        let properties = PersistenceManager.shared.fetch(PropertyEntity.self)
        return properties
    }
    
}

