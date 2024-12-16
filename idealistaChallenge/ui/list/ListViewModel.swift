//
//  ListViewModel.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation

class ListViewModel {
    
    let propertyRepository = PropertyRepository()
    var properties = Observable<[PropertyEntity]>()
    
    func getListOfProperties() async {
        await propertyRepository.getListOfProperties(onRepositoryDataCallback: { propertyServiceResponse in
            guard let propertiesData = propertyServiceResponse.listOfProperties else {
                return
            }
            properties.value = propertiesData
            print("hey! AAAAA \(propertyServiceResponse.listOfProperties?.count)")
        })
    }
    
    
}
