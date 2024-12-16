//
//  IdealistaApi.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//


import Foundation

fileprivate let IDEALISTA_API_BASE_PATH = Environment().configuration(PlistKey.serverURL)

enum IdealistaAPIEndpoint: String {
    case getListOfProperties = "list.json"
    case getDetailOfProperty = "detail.json"
    
    func fetchRequestURL(endpoint: String? = nil) throws -> URL {
        var urlString = IDEALISTA_API_BASE_PATH + rawValue
        if let endpoint = endpoint { urlString += "\(endpoint)" }
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        return url
    }
}

