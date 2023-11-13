//
//  NetworkingManager.swift
//  FetchDesserts
//
//  Created by Riley Brookins on 11/7/23.
//

import Foundation

class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL. \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
        

    }
    
    // Return data from url and handle the responsee
    static func download(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return data
    }
}
