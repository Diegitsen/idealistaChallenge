//
//  PropertyLocalDatasource.swift
//  idealistaChallenge
//
//  Created by diegitsen on 16/12/24.
//


import Foundation

class PropertyLocalDatasource {
        
    func saveProperty(cloudProperty: CloudProperty) async -> PropertyEntity {
        let property = PropertyEntity.fetchSingleOrCreate(cloudPerformance: cloudPerformanceResponse)
        await cloudPerformanceResponse.items.asyncForEach { performanceItemsBody in
            await MainActor.run {  _ = PerformanceItem.fetchSingleOrCreate(performance: performance, cloudPerformanceItemResponse: performanceItemsBody) }
        }
        await PersistenceManager.shared.save()
        return performance
    }
    
    func getPerformances() -> [Performance] {
        let performances = PersistenceManager.shared.fetch(Performance.self)
        return performances
    }
    
}

