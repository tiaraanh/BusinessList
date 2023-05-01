//
//  UserResponse.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 01/05/23.
//

import Foundation

struct User: Decodable {
    let id: String
    let imageUrl: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image_url"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
