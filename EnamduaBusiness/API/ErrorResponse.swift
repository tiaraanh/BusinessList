//
//  ErrorResponse.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 02/05/23.
//

import Foundation

enum ErrorResponse: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach Yelp API"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server returned no data"
        case .unableToDecode:
            return "Unable to decode the data"
        }
    }
}
