//
//  APIError.swift
//  Crypta
//
//  Created by Dias on 01.10.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case rateLimited
    case network
    case decoding
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .rateLimited:
            return "Too many requests. Try again later."
        case .network:
            return "Connection problems. Check the internet."
        case .decoding:
            return "Data from the server could not be processed."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}
