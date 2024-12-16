//
//  CloudProperty.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation

struct CloudProperty: Equatable {
    let id: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfo
    let propertyType: String
    let operation: String
    let size: Int
    let hasExterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: Multimedia
    let features: Features

    init(json: Json) {
        id = json["propertyCode"] as? String ?? ""
        thumbnail = json["thumbnail"] as? String ?? ""
        floor = json["floor"] as? String ?? ""
        price = json["price"] as? Double ?? 0.0
        let priceInfoJson = json["priceInfo"] as? Json ?? Json()
        priceInfo = PriceInfo(json: priceInfoJson)
        propertyType = json["propertyType"] as? String ?? ""
        operation = json["operation"] as? String ?? ""
        size = json["size"] as? Int ?? 0
        hasExterior = json["exterior"] as? Bool ?? false
        rooms = json["rooms"] as? Int ?? 0
        bathrooms = json["bathrooms"] as? Int ?? 0
        address = json["address"] as? String ?? ""
        province = json["province"] as? String ?? ""
        municipality = json["municipality"] as? String ?? ""
        district = json["district"] as? String ?? ""
        country = json["country"] as? String ?? ""
        neighborhood = json["neighborhood"] as? String ?? ""
        latitude = json["latitude"] as? Double ?? 0.0
        longitude = json["longitude"] as? Double ?? 0.0
        description = json["description"] as? String ?? ""
        let multimediaJson = json["multimedia"] as? Json ?? Json()
        multimedia = Multimedia(json: multimediaJson)
        let featuresJson = json["features"] as? Json ?? Json()
        features = Features(json: featuresJson)
    }
}

struct PriceInfo: Equatable {
    let price: Price

    init(json: Json) {
        let priceJson = json["price"] as? Json ?? Json()
        price = Price(json: priceJson)
    }
}

struct Price: Equatable {
    let amount: Double
    let currencySuffix: String

    init(json: Json) {
        amount = json["amount"] as? Double ?? 0.0
        currencySuffix = json["currencySuffix"] as? String ?? ""
    }
}

struct Multimedia: Equatable {
    let images: [Image]

    init(json: Json) {
        let imagesJson = json["images"] as? [Json] ?? []
        images = imagesJson.map { Image(json: $0) }
    }
}

struct Image: Equatable {
    let url: String
    let tag: String

    init(json: Json) {
        url = json["url"] as? String ?? ""
        tag = json["tag"] as? String ?? ""
    }
}

struct Features: Equatable {
    let hasAirConditioning: Bool
    let hasBoxRoom: Bool

    init(json: Json) {
        hasAirConditioning = json["hasAirConditioning"] as? Bool ?? false
        hasBoxRoom = json["hasBoxRoom"] as? Bool ?? false
    }
}

