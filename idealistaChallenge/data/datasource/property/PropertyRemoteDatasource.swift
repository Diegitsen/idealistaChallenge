//
//  PropertyDatasource.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation

class PropertyRemoteDatasource {
    
//    private let localDatasource = PerformanceLocalDatasource()
    
    func getListOfProperties(onRemoteDataCallback: (PropertyServiceResponse) -> Void) async {
        do {
            
            let url = try IdealistaAPIEndpoint.getListOfProperties.fetchRequestURL()
            let fetchedData = try await HTTPSRequestManager.shared.fetch(url: url)
            
            let cloudProperties = fetchedData.map(CloudProperty.init(json:))
            var properties: [PropertyEntity] = []
            await cloudProperties.asyncForEach { cloudProperty in
//                let property = await localDatasource.savePerformance(cloudPerformanceResponse: cloudPerformance)
//                performances.append(performance)
            }
            let propertyServiceResponse = PropertyServiceResponse(
                isSuccessful: true,
                errorCode: nil,
                listOfProperties: cloudProperties)
            onRemoteDataCallback(propertyServiceResponse)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    

}

struct PropertyServiceResponse: Equatable {
    let isSuccessful: Bool
    let errorCode: Int?
    let listOfProperties: [CloudProperty]?
}