//
//  Environment.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import Foundation

public enum PlistKey {
    case serverURL
    case timeoutInterval
    case connectionProtocol
    
    func value() -> String {
        switch self {
        case .serverURL:
            return "serverUrl"
        case .timeoutInterval:
            return "timeout_interval"
        case .connectionProtocol:
            return "protocol"
        }
    }
}

public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .serverURL:
            return infoDict[PlistKey.serverURL.value()] as! String
        case .timeoutInterval:
            return infoDict[PlistKey.timeoutInterval.value()] as! String
        case .connectionProtocol:
            return infoDict[PlistKey.connectionProtocol.value()] as! String
        }
    }
    
}

