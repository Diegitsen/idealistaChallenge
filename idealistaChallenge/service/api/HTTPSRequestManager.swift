//
//  HTTPSRequestManager.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//
import Foundation

class HTTPSRequestManager: NSObject {
    private override init() {}
    static let shared = HTTPSRequestManager()
    
    func fetchSingle(token: String? = nil, url: URL) async throws -> Json {
        let jsonRaw = try await get(token: token, url: url)
        guard let json = jsonRaw as? Json else { throw JsonError.invalidJson }
        return json
    }
    
    func fetch(token: String? = nil, url: URL) async throws -> [Json] {
        let jsonRaw = try await get(token: token, url: url)
        guard let jsonArray = jsonRaw as? [Json] else { throw JsonError.invalidJson }
        return jsonArray
    }
    
    func postAndFetchSingle(token: String? = nil, body: Json, url: URL) async throws -> Json {
        let jsonRaw = try await post(token: token, body: body, url: url)
        if let json = jsonRaw as? Json {
            return json
        } else {
            return Json()
        }
    }
    
    func postAndFetch(token: String? = nil, body: Json, url: URL) async throws -> [Json] {
        let jsonRaw = try await post(token: token, body: body, url: url)
        guard let jsonArray = jsonRaw as? [Json] else { throw JsonError.invalidJson }
        return jsonArray
    }
    
    func postAndFetchString(token: String?, body: Json, url: URL) async throws -> String {
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if let token = token { request.setValue(token, forHTTPHeaderField: "Authorization") }
        request.httpBody = jsonData
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let (data,_) = try await urlSession.data(for: request)//URLSession.shared.data(for: request)
        let token = String(decoding: data, as: UTF8.self)
        guard !token.contains("error") else { throw JsonError.serverSideError }
        return token
    }
    
    func fetchString(token: String?, url: URL) async throws -> String {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if let token = token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let (data,_) = try await urlSession.data(for: request)
        let jsonString = String(decoding: data, as: UTF8.self)
        return jsonString
    }
    
    private func post(token: String?, body: Json, url: URL) async throws -> Any {
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        var request = URLRequest(url: url)
        
        let dataString = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        print("----- request POST ------")
        print("url -> \(url)")
        print(dataString)
        print("----- request POST ------")
        
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if let token = token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        
        request.httpBody = jsonData
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 30.0

        //TODO:: let urlSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let (data,_) = try await urlSession.data(for: request)
        let jsonRaw = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        print("----- response POST ------")
        print("\(jsonRaw)")
        print("----- response POST ------")
        return jsonRaw
    }
    
    private func get(token: String?, url: URL) async throws -> Any {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        print("----- request GET ------")
        print("url -> \(url)")
        print("----- request GET ------")
        
        if let token = token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let (data,_) = try await urlSession.data(for: request)
        let jsonRaw = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        print("----- response GET ------")
        print("\(jsonRaw)")
        print("----- response GET ------")
        
        return jsonRaw
    }
}

extension HTTPSRequestManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, urlCredential)
    }
}
