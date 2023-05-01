//
//  Business.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 29/04/23.
//

import Foundation

struct Business: Decodable {
    var id: String
    let name: String
    let image_url: String
    var isClosed: Bool
    let url: String
    let review_count: Int
    let rating: Float
    let coordinate: [Coordinates]
    let location: [Locations]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image_url = "image_url"
        case isClosed = "is_closed"
        case url
        case review_count = "review_count"
        case rating
        case coordinate = "coordinates"
        case location
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        image_url = try container.decodeIfPresent(String.self, forKey: .image_url) ?? ""
        isClosed = try container.decodeIfPresent(Bool.self, forKey: .isClosed) ?? false
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        review_count = try container.decodeIfPresent(Int.self, forKey: .review_count) ?? 0
        rating = try container.decodeIfPresent(Float.self, forKey: .rating) ?? 0
        coordinate = try container.decodeIfPresent([Coordinates].self, forKey: .coordinate) ?? []
        location = try container.decodeIfPresent([Locations].self, forKey: .location) ?? []
    }
    
}
