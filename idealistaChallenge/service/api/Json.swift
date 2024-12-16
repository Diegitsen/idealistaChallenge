//
//  Json.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//


import Foundation

typealias Json = Dictionary<String,Any>

enum JsonError: LocalizedError {
    case invalidJson
    case serverSideError
    
    public var errorDescription: String? {
        switch self {
        case .invalidJson: return "No se pudo convertir la respuesta"
        case .serverSideError: return "Hubo un error por el lado del servidor"
        }
    }
}

