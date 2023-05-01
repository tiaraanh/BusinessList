//
//  Coordinates.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 30/04/23.
//

import Foundation

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude) ?? 0
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude) ?? 0
    }
}
