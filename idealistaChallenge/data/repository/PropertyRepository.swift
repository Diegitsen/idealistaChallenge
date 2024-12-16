//
//  PropertyRepository.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation

class PropertyRepository {
    
    private let localDatasource = PropertyLocalDatasource()
    private let remoteDatasource = PropertyRemoteDatasource()

    
    func getListOfProperties(onRepositoryDataCallback: (PropertyServiceResponse) -> Void) async {
        await remoteDatasource.getListOfProperties(onRemoteDataCallback: { propertyServiceResponse in
            onRepositoryDataCallback(propertyServiceResponse)
        })
    }

}
