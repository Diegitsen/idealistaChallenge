//
//  ListViewModel.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation

class ListViewModel {
    
    let propertyRepository = PropertyRepository()
    var properties = Observable<[CloudProperty]>()
    
    func getListOfProperties() async {
        await propertyRepository.getListOfProperties(onRepositoryDataCallback: { propertyServiceResponse in
         
            print("hey! AAAAA \(propertyServiceResponse.listOfProperties?.count)")
        })
    }
    
    
}
