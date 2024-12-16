//
//  Property.swift
//  idealistaChallenge
//
//  Created by diegitsen on 16/12/24.
//

import Foundation
import CoreData

class PropertyEntity: NSManagedObject, UniquedObject {
    // UniqueId
    @NSManaged var id: String
    
    // Object data
    @NSManaged var address: String
    @NSManaged var amount: Double
    @NSManaged var bathrooms: Int
    @NSManaged var countryRaw: String
    @NSManaged var currencySuffix: String
    @NSManaged var district: String
    @NSManaged var floor: String
    @NSManaged var hasAirConditioning: Bool
    @NSManaged var hasBoxRoom: Bool
    @NSManaged var hasExterior: Bool
    @NSManaged var info: String
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var municipality: String
    @NSManaged var neighborhood: String
    @NSManaged var operationRaw: String
    @NSManaged var price: Double
    @NSManaged var propertyTypeRaw: String
    @NSManaged var province: String
    @NSManaged var rooms: Int
    @NSManaged var size: Int
    @NSManaged var thumbnail: String
    
    // Object Relationships
    @NSManaged var picturesRaw: NSSet?
    
    var pictures: [PropertyPictureEntity] {
        let items = persistenceManager.mainContext.performAndWait { picturesRaw?.allObjects as? [PropertyPictureEntity] } ?? []
        return items
    }
}

extension PropertyEntity {
    
    class func fetchSingleOrCreate(cloudProperty: CloudProperty) -> PropertyEntity {
        let id = cloudProperty.id
        let property = PersistenceManager.shared.fetchSingleOrCreate(PropertyEntity.self, id: id)
    
        property.address = cloudProperty.address
        property.amount = cloudProperty.priceInfo.price.amount
        property.bathrooms = cloudProperty.bathrooms
        property.countryRaw = cloudProperty.country
        property.currencySuffix = cloudProperty.priceInfo.price.currencySuffix
        property.district = cloudProperty.district
        property.floor = cloudProperty.floor
        property.hasAirConditioning = cloudProperty.features.hasAirConditioning
        property.hasBoxRoom = cloudProperty.features.hasBoxRoom
        property.hasExterior = cloudProperty.hasExterior
        property.info = cloudProperty.description
        property.latitude = cloudProperty.latitude
        property.longitude = cloudProperty.longitude
        property.municipality = cloudProperty.municipality
        property.neighborhood = cloudProperty.neighborhood
        property.operationRaw = cloudProperty.operation
        property.price = cloudProperty.price
        property.propertyTypeRaw = cloudProperty.propertyType
        property.province = cloudProperty.province
        property.rooms = cloudProperty.rooms
        property.size = cloudProperty.size
        property.thumbnail = cloudProperty.thumbnail
        
        return property
    }

}
